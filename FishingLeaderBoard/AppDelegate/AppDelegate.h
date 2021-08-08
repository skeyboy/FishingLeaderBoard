//
//  AppDelegate.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/15.
//  Copyright © 2019 yue. All rights reserved.
//
#define fSessionUserInfoDic             @"fSessionUserInfoDic" //!< 用户信息保存的KEY
#define fSessionUser                    @"fSessionUser"
#define fSessionUserPassword            @"fSessionUserPassword"
#import "RouteService.h"
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <CoreLocation/CLLocationManager.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

typedef BOOL(^BMKLocationResult)(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError * onError);

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(strong, nonatomic) BMKMapManager * mapManager;
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BMKLocation * location;
@property(nonatomic)   BMKLocationManager  *locationManager ;

/// 定位结果
-(BOOL)hasLocation;
//判断是否有定位权限
-(BOOL)hasAuthor;
-(NSString   * ) getToken;
+(AppDelegate *_Nonnull)appDelegate;

/// token失效后的弹出的页面
@property(nonatomic) UINavigationController * reLoginNav;

@property (nonatomic,strong) UITabBarController   * tabBarController;//!<


@end

@interface AppDelegate (BaiduMapLocation)
//- (void)configBaiduMap ;
/// 返回位置更新信息
-(void)fetchNewLocationInfo:(BMKLocationResult) result;

@end
