//
//  UIViewController+ShowHud.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HudCostomView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ShowHud)
-(void)loadingWithMessage:(NSString *)msg mode:(MBProgressHUDMode)mode;
-(void)loading;
-(void)hideHud;
-(void)showWithInfo:(NSString *) info
    delayToHideAfter:(NSTimeInterval) timeInterval;
-(void)showDefaultInfo:(NSString *)str;
-(void)showJiZaiInfo:(NSString *)info;


/// 默认的网络加载提示
-(void)showDefaultLoading;

-(void)makeToask:(NSString *) message;
@end

NS_ASSUME_NONNULL_END
