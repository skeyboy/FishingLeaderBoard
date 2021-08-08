//
//  SpotLocationChoseViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SpotLocationChoseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearchOption.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


#import "CityViewController.h"
@interface SpotLocationChoseViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UISearchBarDelegate,BMKSuggestionSearchDelegate,UITableViewDelegate,UITableViewDataSource,BMKPoiSearchDelegate>{
    __block BOOL isCityChange;
}
@property (weak, nonatomic) IBOutlet BMKMapView *spotMapView;
@property(nonatomic) BMKAnnotationView * currentAnnotationView;
@property(strong,nonatomic)NSString *cityId;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *locationsTableview;
@property(nonatomic) NSMutableArray * items;
@property(nonatomic) BMKPinAnnotationView *annotationView ;
@end

@implementation SpotLocationChoseViewController
#pragma tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    BMKPoiInfo * info = self.items[indexPath.row];
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = info.address;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  BMKPoiInfo * info = self.items[indexPath.row];
           self.reverLocationResult(info.address, info.pt,self.cityId);
         [self.navigationController popViewControllerAnimated:YES];
    
    return;
    UIAlertController *infoAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您是否要使用此位置" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        BMKPoiInfo * info = self.items[indexPath.row];
        self.reverLocationResult(info.address, info.pt,self->_cityId);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [infoAlert addAction:cancelAction];
    [infoAlert addAction:confirmAction];
    
    [self presentViewController:infoAlert
                       animated:YES
                     completion:^{
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.items = [NSMutableArray arrayWithCapacity:0];
    self.locationsTableview.delegate = self;
    self.locationsTableview.dataSource = self;
    if (@available(iOS 13,*)) {
         self.searchBar.barStyle = UIBarStyleDefault;
         self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
         self.searchBar.searchTextField.font = [UIFont systemFontOfSize:15];
         self.searchBar.searchTextField.backgroundColor=[UIColor colorWithWhite:1 alpha:0.2];
        self.searchBar.searchTextField.textColor = [UIColor lightGrayColor];
        
    } else {
        _searchBar.backgroundColor = [UIColor clearColor];
        
        UIView* searchTextField = [_searchBar
                                   subViewOfClassName:@"UISearchBarTextField"];
        searchTextField.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    self.searchBar.delegate = self;
    [self setNavViewWithTitle:@"钓场地址选择" isShowBack:YES];
    self.spotMapView.zoomLevel = 20;
    self.spotMapView.zoomEnabled = YES;
    self.spotMapView.delegate = self;
    self.spotMapView.showsUserLocation = YES;
    self.spotMapView.zoomEnabled = YES;
    [self.appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
              annotation.coordinate =  location.coordinate;
              annotation.title = rgcData.locationDescribe;
              [self.spotMapView addAnnotation:annotation];
              [self.spotMapView setCenterCoordinate:location.coordinate animated:YES];
        self.cityLabel.text = rgcData.city;
        [self reverseBy:location.coordinate];
        return YES;
    }];
    [self.spotMapView showsUserLocation];
}
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated reason:(BMKRegionChangeReason)reason{
    if (reason == BMKRegionChangeReasonGesture) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
                       annotation.coordinate =  mapView.centerCoordinate;
                        [self.spotMapView addAnnotation:annotation];
                 [self reverseBy:mapView.centerCoordinate];
    }
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//                annotation.coordinate =  mapView.centerCoordinate;
//                 [self.spotMapView addAnnotation:annotation];
//          [self reverseBy:mapView.centerCoordinate];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar endEditing:YES];
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        /**
         根据指定标识查找一个可被复用的标注，用此方法来代替新创建一个标注，返回可被复用的标注
         */
        if (self.annotationView) {
            [self.annotationView removeFromSuperview];
        }
        if (!self.annotationView) {
            self.annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationViewIdentifier"];

            /**
             初始化并返回一个annotationView
             
             @param annotation 关联的annotation对象
             @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
             @return 初始化成功则返回annotationView，否则返回nil
             */
            self.annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationViewIdentifier"];
//            TODO
            //annotationView显示的图片，默认是大头针
            self.annotationView.image = [UIImage imageNamed:@"spot_location"];
            /**
             默认情况下annotationView的中心点位于annotation的坐标位置，可以设置centerOffset改变
             annotationView的位置，正的偏移使annotationView朝右下方移动，负的朝左上方，单位是像素
             */
            self.annotationView.centerOffset = CGPointMake(0, 0);
            /**
             默认情况下, 弹出的气泡位于annotationView正中上方，可以设置calloutOffset改变annotationView的
             位置，正的偏移使annotationView朝右下方移动，负的朝左上方，单位是像素
             */
            self.annotationView.calloutOffset = CGPointMake(0, 0);
            //是否显示3D效果，标注在地图旋转和俯视时跟随旋转、俯视，默认为NO
            self.annotationView.enabled3D = NO;
            //是否忽略触摸时间，默认为YES
            self.annotationView.enabled = YES;
            /**
             开发者不要直接设置这个属性，若设置，需要在设置后调用BMKMapView的-(void)mapForceRefresh;方法
             刷新地图，默认为NO，当annotationView被选中时为YES
             */
            self.annotationView.selected = NO;
            //annotationView被选中时，是否显示气泡（若显示，annotation必须设置了title），默认为YES
            self.annotationView.canShowCallout = YES;
            /**
             显示在气泡左侧的view(使用默认气泡时，view的width最大值为32，
             height最大值为41，大于则使用最大值）
             */
            self.annotationView.leftCalloutAccessoryView = nil;
            /**
             显示在气泡右侧的view(使用默认气泡时，view的width最大值为32，
             height最大值为41，大于则使用最大值）
             */
            self.annotationView.rightCalloutAccessoryView = nil;
            /**
             annotationView的颜色： BMKPinAnnotationColorRed，BMKPinAnnotationColorGreen，
             BMKPinAnnotationColorPurple
             */
            self.annotationView.pinColor = BMKPinAnnotationColorRed;
            //设置从天而降的动画效果
            self.annotationView.animatesDrop = YES;
            //当设为YES并实现了setCoordinate:方法时，支持将annotationView在地图上拖动
            self.annotationView.draggable = YES;
            //当前view的拖动状态
            //annotationView.dragState;
            
        }
      
        return self.annotationView;
    }
    
    return nil;
}

- (void)mapView:(BMKMapView *)mapView
 annotationView:(BMKAnnotationView *)view
didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {
    if (newState == BMKAnnotationViewDragStateEnding) {
        self.currentAnnotationView = view;
               BOOL reg = [self reverseBy:view.annotation.coordinate];
           if (!reg) {
               [self makeToask:@"位置解析异常"];
           }else{
               if (self.currentAnnotationView) {
                   [self.currentAnnotationView.annotation setCoordinate:view.annotation.coordinate];
                }
           }
    }
    
}

#pragma 逆地理编码
-(BOOL)reverseBy:(CLLocationCoordinate2D )coordinate{
    BMKGeoCodeSearch * _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
                  _geoCodeSearch.delegate = self;

                  //初始化逆地理编码类
              BMKReverseGeoCodeSearchOption *reverseGeoCodeOption= [[BMKReverseGeoCodeSearchOption alloc] init];
    reverseGeoCodeOption.radius = 50;
                  //需要逆地理编码的坐标位置
                  reverseGeoCodeOption.location = coordinate;
                  BOOL reg = [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    return reg;
}
#pragma 逆地理编码
/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error{
 
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error{
    if (self.reverLocationResult && error==BMK_SEARCH_NO_ERROR) {
        
        if (result.poiList.count) {
            //修改为展示列表来选择
                   [self showPoiLlist:result.poiList];
        }else{
            [self.spotMapView setCenterCoordinate:result.location
                                         animated:YES];
            [self searchAddr:result.address];

//            self.reverLocationResult(result.address, result.location);
//                  [self makeToask:[NSString stringWithFormat:@"当前位置为:%@",result.address]];
        }
       
    }
}
-(void)showPoiLlist:(NSArray *) poiList{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:poiList];
    [self.locationsTableview reloadData];
  
}

- (IBAction)cityLabelClick:(id)sender {
    [self pushToCityList];
}

- (IBAction)downBtnClick:(id)sender {
    [self pushToCityList];
}
-(void)pushToCityList{
    @weakify(self)
       CityViewController *cityVc = [[CityViewController alloc] init];
       cityVc.CityResult = ^(NSString * _Nonnull cityName, NSString * _Nonnull cityId) {
           weak_self.cityLabel.text = cityName;
           self->isCityChange = YES;
           [weak_self searchAddr:cityName];
           weak_self.cityId = cityId;

        };
       [self.navigationController pushViewController:cityVc
                                                           animated:YES];

}
#pragma 实现搜素

-(void)searchAddr:(NSString *) keyword{
    BMKPOINearbySearchOption * nearSearchOption = [[BMKPOINearbySearchOption alloc] init];
    nearSearchOption.keywords = @[keyword];
    nearSearchOption.tags = @[@"小区",@"美食",@"建筑",@"超市",@"酒店"];
    nearSearchOption.location = self.spotMapView.centerCoordinate;
    
    BMKPOICitySearchOption *citySearchOption = [[BMKPOICitySearchOption alloc] init];
    citySearchOption.city = self.cityLabel.text;
    citySearchOption.keyword = keyword;
    citySearchOption.isCityLimit = YES;
    citySearchOption.pageSize = 20;
    BMKPoiSearch * search = [[BMKPoiSearch alloc] init];
    search.delegate = self;
//    BOOL result = [search poiSearchNearBy:nearSearchOption];
    BOOL result = [search poiSearchInCity:citySearchOption];
    if (!result) {
        [self makeToask:@"可手动拖动地图选择位置"];
    }
}

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPOISearchResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    switch (errorCode) {
        case BMK_SEARCH_NETWOKR_ERROR:
        case BMK_SEARCH_NETWOKR_TIMEOUT:
            [self makeToask:@"地图搜索网络异常"];
            break;
        case BMK_SEARCH_RESULT_NOT_FOUND:
            [self makeToask:@"没有搜索的您需要的位置"];
            break;
        case BMK_SEARCH_NO_ERROR:
        {
            if (isCityChange) {
                isCityChange = !isCityChange;
                if (poiResult.poiInfoList.count) {
                    BMKPoiInfo *poiInfo = poiResult.poiInfoList.firstObject;
                    [self.spotMapView setCenterCoordinate:poiInfo.pt animated:YES];
                }
            }
            [self showPoiLlist:poiResult.poiInfoList];
        }
            break;
        default:
            break;
    }
}
- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPOIDetailSearchResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode{
    
}

#pragma Search bar
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchAddr:searchText];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self  searchBar:searchBar
       textDidChange:searchBar.text];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
        [searchBar endEditing:YES];
    
}
@end

@implementation UIView (subViewOfClassName)

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }

        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}


@end
