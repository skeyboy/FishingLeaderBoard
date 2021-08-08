//
//  UIViewController+AppDelegate.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIViewController+AppDelegate.h"



@implementation UIViewController (AppDelegate)
-(AppDelegate *)appDelegate{
    return  [UIApplication sharedApplication].delegate;
}
-(UIViewController *)rootViewController{
    return self.appDelegate.window.rootViewController;
}
@end
