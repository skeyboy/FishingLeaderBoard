//
//  FTabBarClass.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginAndRegisterViewController.h"
#import "HomeTableViewController.h"
#import "MyViewController.h"
#import "BuHuoTableViewController.h"
#import "SaiShiAndHuoDongTableViewController.h"
#import "PinPaiViewController.h"
#import "SellerViewController.h"
#import "AgentViewController.h"
#import "JiFenViewController.h"
#import "DuiHuanJiFenViewController.h"
#import "DiscoverViewController.h"
#import "AppManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface FTabBarClass : NSObject

+(UITabBarController *)intoTabBarControll;

@end

NS_ASSUME_NONNULL_END
