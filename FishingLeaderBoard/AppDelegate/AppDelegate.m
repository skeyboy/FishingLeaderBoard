//
//  AppDelegate.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginAndRegisterViewController.h"
#import "IQKeyboardManager.h"
#import "YuWeChatShareManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <BMKLocationKit/BMKLocationComponent.h>
@interface AppDelegate ()
@property(nonatomic,copy,nullable) BMKLocationResult bmkLocationResult;

@end
@interface AppDelegate ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>
 
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tbc = [[FTabBarVC alloc] init];
    [self.tbc setSelectedIndex:4];
    self.window.rootViewController = self.tbc;
    [self config];

    return YES;
}
 //#pragma 微信支付回调(下面两个兼容iOS版本)
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [[YuWeChatShareManager manager] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;


//微信的
    return   [[YuWeChatShareManager manager] application:app
                                                 openURL:url
                                                 options:options];
}

#pragma 支付宝

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}
-(void)config{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {

    //定位功能可用
        [self performSelector:@selector(configBaiduMap) withObject:nil afterDelay:1];

    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {

    //定位不能用
        

    }
    

    [[YuWeChatShareManager manager] registWX];
       IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
       //默认为YES，关闭为NO
       manager.enable = YES;
       //键盘弹出时，点击背景，键盘收回
       manager.shouldResignOnTouchOutside = YES;
       //如果YES，那么使用textField的tintColor属性为IQToolbar，否则颜色为黑色。默认是否定的。
       manager.shouldToolbarUsesTextFieldTintColor = YES;
       //如果YES，则在IQToolbar上添加textField的占位符文本。默认是肯定的。
       manager.shouldShowToolbarPlaceholder = YES;
       //设置IQToolbar按钮的文字
       manager.toolbarDoneBarButtonItemText = @"完成";
       //隐藏键盘上面的toolBar,默认是开启的
       manager.enableAutoToolbar = YES;
       manager.enable = NO;
       
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

@implementation AppDelegate (BaiduMapLocation)

-(void)fetchNewLocationInfo:(BMKLocationResult)result{
    if (self.locationManager) {
        self.bmkLocationResult = result;
        [self.locationManager startUpdatingLocation];
    }
}
#pragma mark 百度地图设置
- (void)configBaiduMap {
//    TODO 补全百度地图apikey
    NSString *ak = @"W1Btv2pd45POt10CC1P86Xhj";
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    self.mapManager = mapManager;
    BOOL ret = [mapManager start:ak generalDelegate:nil];
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:ak authDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
  

 }
-(void)startLocation{
        self.locationManager = [[BMKLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
    //    locationManager.allowsBackgroundLocationUpdates = YES;
        self.locationManager.locationTimeout = 10;
    self.locationManager.reGeocodeTimeout = 10;
    [self.locationManager startUpdatingLocation];

        [self.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
                 //获取经纬度和该定位点对应的位置信息
            
        }];
}
-(void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    if (iError == BMKLocationAuthErrorSuccess) {
        
        [self startLocation];
    }
}
#pragma 定位回调
-(void)BMKLocationManager:(BMKLocationManager *)manager didFailWithError:(NSError *)error{
    
}
-(void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    NSLog(@"%@ %@",location.location,location.rgcData);
    if (self.bmkLocationResult) {
        self.bmkLocationResult(location.location, location.rgcData);
        
    }
    self.bmkLocationResult = nil;
}
-(void)BMKLocationManager:(BMKLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
}
@end
