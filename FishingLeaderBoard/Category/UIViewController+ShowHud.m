//
//  UIViewController+ShowHud.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIViewController+ShowHud.h"

#import "MBProgressHUD.h"


@implementation UIViewController (ShowHud)
-(void)loading{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)loadingWithMessage:(NSString *)msg{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)hideHud{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)showWithInfo:(NSString *)info
    delayToHideAfter:(NSTimeInterval)timeInterval{
    [self loadingWithMessage:info];
    [self performSelector:@selector(hideHud) afterDelay:timeInterval];
}
@end
