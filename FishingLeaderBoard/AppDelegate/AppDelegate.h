//
//  AppDelegate.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BMKLocationKit/BMKLocationComponent.h>

#import "FTabBarVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(strong, nonatomic) BMKMapManager * mapManager;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FTabBarVC *tbc;
@end

@interface AppDelegate (BaiduMapLocation)
- (void)configBaiduMap ;
@end
