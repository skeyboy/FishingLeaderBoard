//
//  ToPayView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ToPayView.h"
#import "EMOrderDetailViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YuWeChatShareManager.h"
@interface ToPayView()<YuWXPayResponse,YuAliPayResponse>
@end
@implementation ToPayView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.chooseZhiFuBaoImgView.image = nil;
    self.chooseWXImgView.image = nil;
    self.chooseWalletImgView.image = [UIImage imageNamed:@"select"];
    self.payWay = PayTypeWallet;
    [self.WalletPay setTitle:@"钱包支付" forState:UIControlStateNormal];
    [self.zhiFuBaoPay setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [self.wxPay setTitle:@"微信支付" forState:UIControlStateNormal];
    if (![YuWeChatShareManager isWXAppInstalled]) {
        self.wxPay.hidden = YES;
    }

}

- (IBAction)back:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)confirmPay:(id)sender {
    if(self.toPage == 0)
    {//n报名支付
//    [self enrollPay:self.payWay
//            eventId:@(self.eventId).description
//         tranAmount:@(self.money).description
//        enrollCount:self.enrollCount];
        self.confirmBtnForEnrollGameClick(@(self.eventId).description, @(self.money).description, self.enrollCount, self.payWay);
    }else if(self.toPage == 1){
        //买鱼支付
        self.confirmBtnClick(self.payWay);
    }else if(self.toPage == 2)
    {
        self.confirmBtnClick(self.payWay);
    }
   
}
- (IBAction)chooseWallet:(id)sender {
    self.chooseZhiFuBaoImgView.image = nil;
    self.chooseWXImgView.image = nil;
    self.chooseWalletImgView.image = [UIImage imageNamed:@"select"];
    self.payWay = PayTypeWallet;
}
/// 支付宝
- (IBAction)chooseZhiFuBao:(id)sender {
    self.chooseZhiFuBaoImgView.image = [UIImage imageNamed:@"select"];
    self.chooseWXImgView.image = nil;
    self.chooseWalletImgView.image = nil;
    self.payWay = PayTypeAli;

}

//微信
- (IBAction)chooseWX:(id)sender {
    self.chooseZhiFuBaoImgView.image = nil;
    self.chooseWXImgView.image = [UIImage imageNamed:@"select"];
    self.chooseWalletImgView.image = nil;
    self.payWay = PayTypeWx;
}


////支付结果回调
//-(void)wxPayResponseCode:(int)errCode
//                  errStr:(NSString *)errStr
//                    type:(int)type
//           withReturnKey:(NSString *)returnKey{
//    switch (errCode) {
//        case -2:
//
//            [self.viewController makeToask:@"您放弃了支付，请重点击支付按钮"];
//             break;
//        case 0:
//
//        default:
//            break;
//    }
//    [self clear];
//}
//#pragma 用户下单支付宝回调结果处理
//-(void)aliPayResponse:(NSDictionary *)dic{
//    NSInteger resultStatus = [NSNumber numberWithString: [dic valueForKey:@"resultStatus"]].integerValue;
//    if (resultStatus == 9000) {
//        [self.viewController makeToask:@"订单支付成功"];
//    } else {
//        [self.viewController makeToask:dic[@"memo"]];
//    }
//    [self clear];
//}
//-(void)enrollPay:(PayType) payType eventId:(NSString *) eventId tranAmount:(NSString *) tranAmount enrollCount:(NSInteger) enrollCount {
//    NSDictionary *dict  = @{
//        @"count":@(self.orderValue.count),
//        @"tranAmount":self.orderValue.tranAmount,
//        @"eventId":@(self.orderValue.eventId),
//        @"payType":@(payType),
//        @"applicationCode":self.orderValue.applicationCode,
//        @"spotId":@(self.orderValue.spotId),
//        @"spotUserId":@(self.orderValue.spotUserId),
//        @"userId":@([AppManager manager].userInfo.id)
//    };
//
//    [ToolClass pay:dict
//          shortUri:ORDER_ENROLL_PAY
//           payType:payType
//            holder:self.viewController
//       aliResponse:self
//        wxResponse:self
//    walletCallback:^{
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"请到\"我的订单\"查看" preferredStyle:UIAlertControllerStyleAlert];
//
//               UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                   [self clear];
//
//               }];
//               [alert addAction:sure];
//               [self.viewController presentViewController:alert animated:NO completion:^{
//               }];
//     }];
//
//}
//-(void)clear{
//
//
//     UIViewController * aVc  = self.viewController;
//    if ([aVc respondsToSelector:@selector(getGameAndActDetail)]) {
//        [aVc performSelector:@selector(getGameAndActDetail)];//刷新赛事报名活动
//    }
//    [self.superview removeFromSuperview];
//    [self removeFromSuperview];
//}
@end
