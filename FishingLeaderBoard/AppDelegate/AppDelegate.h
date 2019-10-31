//
//  AppDelegate.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <CoreLocation/CLLocationManager.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "FTabBarVC.h"

typedef void(^BMKLocationResult)(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData);

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(strong, nonatomic) BMKMapManager * mapManager;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FTabBarVC *tbc;
@property (nonatomic, strong) BMKLocation * location;
@property (nonatomic, strong) BMKGeoCodeSearch * geocodeSearch;
@property(nonatomic)   BMKLocationManager  *locationManager ;
@end

@interface AppDelegate (BaiduMapLocation)
//- (void)configBaiduMap ;
/// 返回位置更新信息
-(void)fetchNewLocationInfo:(BMKLocationResult ) result;

@end
