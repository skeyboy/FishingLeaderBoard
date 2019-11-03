//
//  UIViewController+ShowHud.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ShowHud)
-(void)loadingWithMessage:(NSString *) msg;
-(void)loading;
-(void)hideHud;
-(void)showWithInfo:(NSString *) info
    delayToHideAfter:(NSTimeInterval) timeInterval;
@end

NS_ASSUME_NONNULL_END
