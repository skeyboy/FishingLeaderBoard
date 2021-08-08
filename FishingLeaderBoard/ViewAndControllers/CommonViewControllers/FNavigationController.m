//
//  FNavigationController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FNavigationController.h"

@implementation FNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // [self.navigationBar setBackgroundImage:[UIImage imageWithColorHexString:COLOR_APP_BG withSize:(CGSize){SCREEN_WIDTH, 64}] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationBar setShadowImage:[[UIImage imageWithColorHexString:COLOR_APP_BG withSize:(CGSize){SCREEN_WIDTH, 1}] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
    //    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationBar setShadowImage:[[UIImage imageNamed:@"nav_split"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
    //    self.navigationBar.backgroundColor = CLEARCOLOR;
    self.navigationBar.barStyle =  UIBarStyleBlack;
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

@end
