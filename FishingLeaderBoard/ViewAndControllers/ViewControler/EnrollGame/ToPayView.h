//
//  ToPayView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "AppDelegate+ShowHud.h"
#import "FConstont.h"
@class OrderApplyGame;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBtnClick) (PayType);
typedef void(^ConfirmBtnForEnrollGameClick) (NSString*,NSString*,NSInteger,PayType);

/// 支付方式选择
@interface ToPayView : UIView
@property (weak, nonatomic) IBOutlet UIButton *WalletPay;

@property (weak, nonatomic) IBOutlet UIButton *zhiFuBaoPay;

@property (weak, nonatomic) IBOutlet UIButton *wxPay;
@property (weak, nonatomic) IBOutlet UIImageView *chooseWalletImgView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseZhiFuBaoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseWXImgView;

// 0：钱包 1：支付宝 2：微信
@property (assign,nonatomic)PayType payWay;

- (IBAction)back:(id)sender;

- (IBAction)cancel:(id)sender;

- (IBAction)confirmPay:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


- (IBAction)chooseWallet:(id)sender;

- (IBAction)chooseZhiFuBao:(id)sender;

- (IBAction)chooseWX:(id)sender;


@property(assign,nonatomic)float money;

@property(assign,nonatomic)NSInteger enrollCount;

@property(assign,nonatomic)NSInteger eventId;

@property(copy, nonatomic) OrderApplyGame * orderValue;
//0:报名支付，未支付订单等支付 1:买鱼支付 2：积分快递到家支付
@property(assign,nonatomic)NSInteger toPage;
@property(copy,nonatomic)ConfirmBtnClick confirmBtnClick;
@property(copy,nonatomic)ConfirmBtnForEnrollGameClick confirmBtnForEnrollGameClick;
@end

NS_ASSUME_NONNULL_END
