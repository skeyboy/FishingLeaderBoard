//
//  ExchangeViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"
@class ExchangeViewController;
NS_ASSUME_NONNULL_BEGIN
@protocol ExchangeViewControllerDelegate<NSObject>
@required -(void)scanExchangeBill;
@end


/// 积分兑换查看弹框页
@interface ExchangeViewController : FViewController

@property(nonatomic) UIViewController<ExchangeViewControllerDelegate> *fromVc;
@property(assign, nonatomic) id<ExchangeViewControllerDelegate> exchangeVcDelegate;


@end

NS_ASSUME_NONNULL_END
