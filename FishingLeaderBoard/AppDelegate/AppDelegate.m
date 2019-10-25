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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
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
    
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tbc = [[FTabBarVC alloc] init];
    [self.tbc setSelectedIndex:4];
    self.window.rootViewController = self.tbc;
    return YES;
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
