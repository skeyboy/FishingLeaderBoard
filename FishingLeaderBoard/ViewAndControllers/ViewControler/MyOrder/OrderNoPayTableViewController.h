//
//  OrderNoPayTableViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderNoPayTableViewController : UITableViewController
//1:我的订单（未支付订单）-》支付
//2：立即报名-》我的订单（未支付订单）-》支付
@property(assign,nonatomic)NSInteger intoPageType;
@property(strong,nonatomic)UIViewController *vc;
@end

NS_ASSUME_NONNULL_END
