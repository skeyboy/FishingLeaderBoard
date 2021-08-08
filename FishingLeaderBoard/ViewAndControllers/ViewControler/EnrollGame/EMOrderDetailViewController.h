//
//  EMOrderDetailViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JhFormTableViewVC.h"
#import "ShowOrderNumberView.h"
@class OrderApplyGame;
NS_ASSUME_NONNULL_BEGIN

/// 订单详情
@interface EMOrderDetailViewController : JhFormTableViewVC

@property(strong,nonatomic)OrderApplyGame*orderApplyGame;
@property(assign,nonatomic)BOOL isOrder;//已支付 1，未支付 0
//1:我的订单（未支付订单）-》支付
//2：立即报名-》我的订单（未支付订单）-》支付
@property(assign,nonatomic)NSInteger intoPageType;
                                            
//未支付刷新上个页面数据用
@property(strong,nonatomic)UIViewController*vc;
@end

NS_ASSUME_NONNULL_END
