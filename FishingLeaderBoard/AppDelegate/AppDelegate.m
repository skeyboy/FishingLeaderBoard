//
//  AppDelegate.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/15.
//  Copyright © 2019 yue. All rights reserved.
//
#import <dlfcn.h>
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "LoginAndRegisterViewController.h"
#import "IQKeyboardManager.h"
#import "YuWeChatShareManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "ApiFetch+Info.h"
//#import <UMCommon/UMCommon.h>
//#import <UMAnalytics/MobClick.h>
//#import <UMCommonLog/UMCommonLogHeaders.h>
#import "YuWeChatShareManager.h"
//#import <YCSymbolTracker/YCSymbolTracker.h>

@interface AppDelegate (){
    __block BMKLocation * _Nullable mLocation;
    __block BMKLocationReGeocode * _Nullable mRgcData;
    __block NSError *mBmkErrror;
}
@property(nonatomic,copy,nullable) BMKLocationResult bmkLocationResult;
@property(nonatomic) NSMutableArray * fetchLocationRequests;
@end
@interface AppDelegate ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>
 
@end


@implementation AppDelegate
-(NSString   *)getToken{
    return  [AppManager manager].token  != nil ?  [AppManager manager].token : @"";
}
-(BOOL)hasAuthor{
    
    BOOL author =  [CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized);
    return author;
}
-(BOOL)hasLocation{
  BOOL author =  [CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized);
    if (!author) {
        return NO;
    }
    return mLocation && mRgcData;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [RouteService startService];
    
    
    self.fetchLocationRequests = [NSMutableArray arrayWithCapacity:0];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
  
     NSDictionary *userInfoDict = [[NSUserDefaults standardUserDefaults]objectForKey:fSessionUserInfoDic];
       if(userInfoDict !=nil)
       {
           [AppManager manager].userInfo = [UserInfo modelWithDictionary:userInfoDict];
           NSLog(@"token :%@",[AppManager manager].userInfo.token);
           NSLog(@"usID :%ld",[AppManager manager].userInfo.id);
       }
       [FTabBarClass intoTabBarControll];
    
    [self umeng];
    
//    [[YuWeChatShareManager manager] loginFromVC:self.window.rootViewController];
    self.window.backgroundColor = WHITECOLOR;
//    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"demo.order"];
//    [YCSymbolTracker exportSymbolsWithFilePath:filePath];
    return YES;
}
-(void)umeng{
//    #if DEBUG
//    [UMCommonLogManager setUpUMCommonLogManager];
//        [UMConfigure initWithAppkey:@"5e210c781f1f831a0ff48930" channel:@"Debug"];
//    #else
//    
//        [UMConfigure initWithAppkey:@"5e2327ebcb23d27707000123" channel:@"App Store"];
//
//        [self config];
//    #endif
//        //设置为自动采集页面
//        [MobClick setAutoPageEnabled:YES];
//    [UMConfigure setLogEnabled:YES];
//    [MobClick setCrashReportEnabled:YES];  

}

 //#pragma 微信支付回调(下面两个兼容iOS版本)
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [[YuWeChatShareManager manager] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    if ([url.host isEqualToString:@"safepay"]) {
        id<YuAliPayResponse> payResponse = [AlipaySDK defaultService].payResponse;

        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
                       if (payResponse) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                                             [payResponse aliPayResponse:resultDic];
                                         });
                       }
        }];
        return YES;
    }


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
    if([JLRoutes routeURL:url]){
        
        return  true;
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            id<YuAliPayResponse> payResponse = [AlipaySDK defaultService].payResponse;
            if (payResponse) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [payResponse aliPayResponse:resultDic];
                });
            }
            
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
        [self performSelector:@selector(configBaiduMap) withObject:nil afterDelay:1];


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

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    if( [userActivity.webpageURL.absoluteString containsString:WXAPPID]){
        //从微信跳转进来的
        //微信传递的数据  _webpageURL    NSURL *    @"https://fish.diaoyuphb.com/WXAPPID/pay/?returnKey=&ret=-2"    0x0000000282561b00
          return [WXApi handleOpenUniversalLink:userActivity
                                       delegate:[YuWeChatShareManager manager]];
    }else{
        [self.window.rootViewController makeToask:@"非法跳转"];
    }
    return NO;
  
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

+(AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
@end

@implementation AppDelegate (BaiduMapLocation)

-(void)fetchNewLocationInfo:(BMKLocationResult)result{
    [self performSelector:@selector(config)];
    if (![self.fetchLocationRequests containsObject:result]) {
        
        [self.fetchLocationRequests addObject:result];
    }
//    self.bmkLocationResult = result;
    if (![self hasAuthor]) {
           result(nil, nil,@{@"info":@"模拟器暂不支持定位"});

        return;
    }
#if TARGET_OS_SIMULATOR
   result(nil, nil,@{@"info":@"模拟器暂不支持定位"});

#else

    if (self.locationManager) {
        [self.locationManager startUpdatingLocation];
    }
    if (mLocation && mRgcData) {
        [self responseLocation];
    }
#endif
}

#pragma mark 百度地图设置
- (void)configBaiduMap {
    
    
//    TODO 补全百度地图apikey
#if DEBUG
  NSString *ak =  @"thHOlwdqNo8asGPQfYMxyIQECZEYyScd";
#else
    NSString *ak = @"xjER08kNPo3O0g6xQD5t49sAL4i7APUo";
#endif
    BMKMapManager *mapManager = [BMKMapManager sharedInstance];
    //设置为 GCJ坐标
   BOOL convertResult = [BMKMapManager  setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL];
    if (!convertResult) {
        NSLog(@"百度地图设置坐标转换错误");
    }
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
    if (self.bmkLocationResult) {
        self.bmkLocationResult(nil, nil, error);
    }
}
-(void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    NSLog(@"%@ %@",location.location,location.rgcData);
    mLocation  = location ;
    mRgcData = location.rgcData ;
    mBmkErrror = error;
    self.location = mLocation;
    [self responseLocation];
}
-(void)BMKLocationManager:(BMKLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
}

-(void)responseLocation{
    NSEnumerator *enumerator = [self.fetchLocationRequests reverseObjectEnumerator];
       
       for (BMKLocationResult fetchLocaltionBlock in enumerator) {
           BOOL autoRemoved = fetchLocaltionBlock(mLocation.location,mRgcData,mBmkErrror);
           if (autoRemoved) {
               [self.fetchLocationRequests removeObject:fetchLocaltionBlock];
           }
       }
}


@end

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;  // Guards should start from 1.
}

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    if (!*guard) return;  // Duplicate the guard check.

       void *PC = __builtin_return_address(0);
       Dl_info info;
       dladdr(PC, &info);

       printf("fname=%s \nfbase=%p \nsname=%s\nsaddr=%p \n",info.dli_fname,info.dli_fbase,info.dli_sname,info.dli_saddr);

       char PcDescr[1024];
       printf("guard: %p %x PC %s\n", guard, *guard, PcDescr);
    
}
