//
//  ShowOrderNumberView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderApplyGame;
NS_ASSUME_NONNULL_BEGIN

/// 订单序列，显示座位号
@interface ShowOrderNumberView : UIView

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIView *bgSomeLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timerLbael;

@property (weak, nonatomic) IBOutlet UIButton *payBtn;

-(void)isOrder:(BOOL)isOrder order:(OrderApplyGame*)order vc:(nonnull UIViewController *)vc fvc:(UIViewController*)fvc type:(NSInteger)type;

- (IBAction)toPay:(id)sender;

- (IBAction)cancelOrder:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property(strong,nonatomic)OrderApplyGame *orderApplyGame;

@property(assign,nonatomic)NSInteger shiJianCha;
@property(strong,nonatomic)YYTimer *timer;

@property(strong,nonatomic)UIViewController*fvc;
@property(assign,nonatomic)NSInteger type;
@end

NS_ASSUME_NONNULL_END
