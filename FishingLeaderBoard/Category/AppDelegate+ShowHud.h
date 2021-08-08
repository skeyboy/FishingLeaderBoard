//
//  AppDelegate+ShowHud.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//


#import "AppDelegate.h"
#import "MBProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (ShowHud)
-(void)loadingWithMessage:(NSString *)msg mode:(MBProgressHUDMode)mode;
-(void)loading;
-(void)hideHud;
-(void)showWithInfo:(NSString *) info
    delayToHideAfter:(NSTimeInterval) timeInterval;
-(void)showDefaultInfo:(NSString *)str;
-(void)showJiZaiInfo:(NSString *)info;


/// 默认的网络加载提示
-(void)showDefaultLoading;
@end

NS_ASSUME_NONNULL_END
