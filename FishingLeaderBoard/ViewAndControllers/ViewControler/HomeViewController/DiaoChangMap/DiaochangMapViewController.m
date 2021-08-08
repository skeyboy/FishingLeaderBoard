//
//  DiaochangMapViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaochangMapViewController.h"
#import <BMKLocationKit/BMKLocationComponent.h>
#import "DiaoChangDetailViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "AppDelegate.h"
#import "YYKit.h"
#import "BMKAnnotationView+SpotInfo.h"
#import "BMKPointAnnotation+SpotInfo.h"
@interface DiaochangMapViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *bmkMapView;
@property( nonatomic) NSMutableArray * spots;
//钓场小按钮
@property(nonatomic) NSMutableArray * spotsAnn;
@end

@implementation DiaochangMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.bmkMapView.delegate = self;
    self.bmkMapView.showsUserLocation = YES;
    self.bmkMapView.zoomEnabled = YES;
    self.bmkMapView.zoomLevel = 12;
    self.bmkMapView.maxZoomLevel = 20;
    @weakify(self)

    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [self showJiZaiInfo:@"正在加载位置信息"];
    [appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate =  location.coordinate;
        annotation.title = rgcData.locationDescribe;
//        [self.bmkMapView addAnnotation:annotation];
        [self.bmkMapView setCenterCoordinate:location.coordinate animated:YES];
        [self hideHud];
        if (onError) {//定位出错则默认为北京
            [weak_self fetchSpotSurronundingLng:116.020876 lat:39.875935];
            return YES;
        }
#if TARGET_OS_SIMULATOR
        [weak_self fetchSpotSurronundingLng:116.020876 lat:39.875935];
#else
        [weak_self fetchSpotSurronundingLng:location.coordinate.longitude lat:location.coordinate.latitude];
#endif
        return YES;
    }];
}
//
-(void)fetchSpotSurronundingLng:(float ) lng
                         lat:(float ) lat{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setValue:@(lng).description forKey:@"lng"];
    [params setValue:@(lat).description forKey:@"lat"];
     @weakify(self)
    [[ApiFetch share] spotGetFetch:SPOT_MAP
                               query:params
                             holder:self
                          dataModel:SpotMap.class
                          onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
        //       TODO 此处补全数据
       
//        [self.spotMaps addObjectsFromArray:modelValue];
        [self addSomeDiaoChang:modelValue];
    }];}


-(void)addSomeDiaoChang:(NSArray*) diaos{
    if (!diaos) {
        return;
    }
    
    //先清除之前的位置，再去添加新的
    NSEnumerator * enu = [self.spotsAnn reverseObjectEnumerator];
    for (UIView * annView in enu) {
        [annView removeFromSuperview];
        [self.spotsAnn removeObject:annView];
    }
    for (SpotMap *spot in diaos) {
        
        [spot bindToMapView:self.bmkMapView];
    }
}


#pragma 百度地图代理
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated reason:(BMKRegionChangeReason)reason{
    if (reason == BMKRegionChangeReasonGesture) {
        [self fetchSpotSurronundingLng:mapView.centerCoordinate.longitude lat:mapView.centerCoordinate.latitude];
    }
}
/**
 根据anntation生成对应的annotationView
 
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        /**
         根据指定标识查找一个可被复用的标注，用此方法来代替新创建一个标注，返回可被复用的标注
         */
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationViewIdentifier"];
        if (!annotationView) {
            /**
             初始化并返回一个annotationView
             
             @param annotation 关联的annotation对象
             @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
             @return 初始化成功则返回annotationView，否则返回nil
             */
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationViewIdentifier"];
//            TODO 
            //annotationView显示的图片，默认是大头针
            annotationView.image = [UIImage imageNamed:@"spot_location"];
            /**
             默认情况下annotationView的中心点位于annotation的坐标位置，可以设置centerOffset改变
             annotationView的位置，正的偏移使annotationView朝右下方移动，负的朝左上方，单位是像素
             */
            annotationView.centerOffset = CGPointMake(0, 0);
            /**
             默认情况下, 弹出的气泡位于annotationView正中上方，可以设置calloutOffset改变annotationView的
             位置，正的偏移使annotationView朝右下方移动，负的朝左上方，单位是像素
             */
            annotationView.calloutOffset = CGPointMake(0, 0);
            //是否显示3D效果，标注在地图旋转和俯视时跟随旋转、俯视，默认为NO
            annotationView.enabled3D = NO;
            //是否忽略触摸时间，默认为YES
            annotationView.enabled = YES;
            /**
             开发者不要直接设置这个属性，若设置，需要在设置后调用BMKMapView的-(void)mapForceRefresh;方法
             刷新地图，默认为NO，当annotationView被选中时为YES
             */
            annotationView.selected = NO;
            //annotationView被选中时，是否显示气泡（若显示，annotation必须设置了title），默认为YES
            annotationView.canShowCallout = YES;
            /**
             显示在气泡左侧的view(使用默认气泡时，view的width最大值为32，
             height最大值为41，大于则使用最大值）
             */
            annotationView.leftCalloutAccessoryView = nil;
            /**
             显示在气泡右侧的view(使用默认气泡时，view的width最大值为32，
             height最大值为41，大于则使用最大值）
             */
            annotationView.rightCalloutAccessoryView = nil;
            /**
             annotationView的颜色： BMKPinAnnotationColorRed，BMKPinAnnotationColorGreen，
             BMKPinAnnotationColorPurple
             */
            annotationView.pinColor = BMKPinAnnotationColorRed;
            //设置从天而降的动画效果
            annotationView.animatesDrop = YES;
            //当设为YES并实现了setCoordinate:方法时，支持将annotationView在地图上拖动
            annotationView.draggable = NO;
            //当前view的拖动状态
            //annotationView.dragState;
            
        }
        if (annotationView) {
            if (!self.spotsAnn) {
                self.spotsAnn = [NSMutableArray arrayWithCapacity:0];
            }
            if(![self.spotsAnn containsObject:annotationView]){
                [self.spotsAnn addObject:annotationView];
            }
        }
        annotationView.spotInfo =  ((BMKPointAnnotation *)annotation).spotInfo;
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(BMKMapView *)mapView clickAnnotationView:(BMKAnnotationView *)view{
    
    SpotMap *spotInfo = view.spotInfo;
    if (spotInfo) {
        //跳转钓场详情
        DiaoChangDetailViewController * diaochangVc = [[DiaoChangDetailViewController alloc] init];
        diaochangVc.spotId = spotInfo.id;
        [self.navigationController pushViewController:diaochangVc
                                             animated:YES];
    }
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
}
@end
