//
//  EnrollGameObject.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/9.
//  Copyright © 2019 yue. All rights reserved.
//

#import "EnrollGameObject.h"
#import "MyOrderViewController.h"
#import "PersonCountView.h"
@implementation EnrollGameObject
//下单
-(void)enrollGame:(EventGameDetail*)eventGameDetail eventId:(NSInteger)eventId vc:(UIViewController*)vc
{
    PersonCountView *pcV= [[[NSBundle mainBundle]loadNibNamed:@"PersonCountView" owner:self options:nil]firstObject];
    pcV.eventGameDetail = eventGameDetail;
    pcV.detailLabel.text = [NSString stringWithFormat:@"您共需要支付%.2f元",[eventGameDetail.money floatValue]+[eventGameDetail.prepayMoney floatValue]];
    pcV.enrollCount = 1;
    pcV.money =[eventGameDetail.money floatValue] +[eventGameDetail.prepayMoney floatValue];
    pcV.eventId = eventId;
    [vc.view addSubview:pcV];
    [pcV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.top.equalTo(vc.view.mas_top);
        make.bottom.equalTo(vc.view.mas_bottom);
    }];
    @weakify(pcV)
    pcV.toPayBtnClick = ^(NSString *eventId, NSString *money, NSInteger count) {
        [self enrollPayEventId:eventId tranAmount:money enrollCount:count vc:vc];
        [weak_pcV removeFromSuperview];
    };
}

//报名函数
-(void)enrollPayEventId:(NSString *) eventId tranAmount:(NSString *) tranAmount enrollCount:(NSInteger) enrollCount vc:(UIViewController*)vc{
    self.vc = vc;
    NSDictionary *orderValue  = @{
        @"count":@(enrollCount),
        @"tranAmount":tranAmount,
        @"eventId":eventId,
        //        @"payType":@(payType),
    };
    [[ApiFetch share] orderPostFetch:ORDER_APPLY_GAME
                                body:orderValue
                              holder:vc
                           dataModel:OrderApplyGameParent.class
                           onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        self.createOrderSuccessClick(YES);
        OrderApplyGame  * orderApplayGame =  ( OrderApplyGame  *)modelValue;
        //TODO 传递参数给订单页面
        self.pay =[[[NSBundle mainBundle]loadNibNamed:@"ToPayView" owner:self options:nil]firstObject];
        self.pay.orderValue = modelValue;
        self.pay.detailLabel.text =  [NSString stringWithFormat:@"您共需要支付%@元",tranAmount];
        self.pay.enrollCount = enrollCount;
        self.pay.money =[tranAmount floatValue];
        self.pay.eventId = [eventId integerValue];
        [vc.view addSubview:self.pay];
        [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vc.view.mas_left);
            make.right.equalTo(vc.view.mas_right);
            make.top.equalTo(vc.view.mas_top);
            make.bottom.equalTo(vc.view.mas_bottom);
        }];
//        @weakify(pay)
        self.pay.confirmBtnForEnrollGameClick = ^(NSString * eventId, NSString *money, NSInteger count, PayType payType) {
            [self enrollPay:payType eventId:eventId tranAmount:money enrollCount:count or:modelValue];
//            [weak_pay removeFromSuperview];
        };
    }];
    
}
//showNoPayList未支付订单列表进
-(void)choosePayTypeSuperVC:(UIViewController *)vc vc:(UIViewController*)vc1 intoType:(NSInteger)intoType or:(OrderApplyGame*)orderValue tranAmount:(NSString*)tranAmount enrollCount:(NSInteger)enrollCount eventId:(NSString*)eventId
{
    self.vc = vc;
    self.fvc = vc1;
    self.intoType = intoType;
    ToPayView *pay =[[[NSBundle mainBundle]loadNibNamed:@"ToPayView" owner:self options:nil]firstObject];
    pay.orderValue = orderValue;
    pay.detailLabel.text =  [NSString stringWithFormat:@"您共需要支付%@元",tranAmount];
    pay.enrollCount = enrollCount;
    pay.money =[tranAmount floatValue];
    pay.eventId = [eventId integerValue];
    [vc.view addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.top.equalTo(vc.view.mas_top);
        make.bottom.equalTo(vc.view.mas_bottom);
    }];
    self.pay = pay;
//    @weakify(pay)
    pay.confirmBtnForEnrollGameClick = ^(NSString * eventId, NSString *money, NSInteger count, PayType payType) {
        [self enrollPay:payType eventId:eventId tranAmount:money enrollCount:count or:orderValue];
//        [weak_pay removeFromSuperview];
    };
}
-(void)toBillsForAlert:(UIAlertController *) alert{
    UIAlertAction * billAction = [UIAlertAction actionWithTitle:@"查看订单" style:0 handler:^(UIAlertAction * _Nonnull action) {
                   MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
        myOrderVC.defaultSelectedIndex = (long)1;//完成订单列表
        [self clear];
                   [self.vc.navigationController pushViewController:myOrderVC
                                                           animated:YES];
               }];
    [alert addAction:billAction];
}
//支付结果回调
-(void)wxPayResponseCode:(int)errCode
                  errStr:(NSString *)errStr
                    type:(int)type
           withReturnKey:(NSString *)returnKey{
    switch (errCode) {
        case 0:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"请到\"我的订单\"查看" preferredStyle:UIAlertControllerStyleAlert];
           
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self clear];
                
            }];
            [alert addAction:sure];
            [self toBillsForAlert:alert];
            [self.vc presentViewController:alert animated:NO completion:^{
            }];
            break;
        }
        default:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:@"请到\"我的订单\"重新支付" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self clear];
                
            }];
            [alert addAction:sure];
            [self toBillsForAlert:alert];
            [self.vc presentViewController:alert animated:NO completion:^{
            }];
        }
            break;
    }
}
#pragma 用户下单支付宝回调结果处理
-(void)aliPayResponse:(NSDictionary *)dic{
    NSInteger resultStatus = [NSNumber numberWithString: [dic valueForKey:@"resultStatus"]].integerValue;
    if (resultStatus == 9000) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"请到\"我的订单\"查看" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clear];
            
        }];
        [alert addAction:sure];
        [self toBillsForAlert:alert];

        [self.vc presentViewController:alert animated:NO completion:^{
        }];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:@"请到\"我的订单\"重新支付" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clear];
            
        }];
        [alert addAction:sure];
        [self toBillsForAlert:alert];

        [self.vc presentViewController:alert animated:NO completion:^{
        }];
        
    }
}
-(void)enrollPay:(PayType) payType eventId:(NSString *) eventId tranAmount:(NSString *) tranAmount enrollCount:(NSInteger) enrollCount or:( OrderApplyGame *)orderValue{
    NSDictionary *dict  = @{
        @"count":@(orderValue.count),
        @"tranAmount":orderValue.tranAmount,
        @"eventId":@(orderValue.eventId),
        @"payType":@(payType),
        @"applicationCode":orderValue.applicationCode,
        @"spotId":@(orderValue.spotId),
        @"spotUserId":@(orderValue.spotUserId),
        @"userId":@([AppManager manager].userInfo.id)
    };
    /*
    [ToolClass pay:dict
          shortUri:ORDER_ENROLL_PAY
           payType:payType
            holder:self.vc
            isPost:YES
       aliResponse:self
        wxResponse:self
    walletCallback:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"请到\"我的订单\"查看" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clear];
            
        }];
        [alert addAction:sure];
        [self toBillsForAlert:alert];
        [self.vc presentViewController:alert animated:NO completion:^{
        }];
    }];
     */
    
}
-(void)clear{
    if(self.pay)
    {
        [self.pay removeFromSuperview];
        self.pay= nil;
    }
    if(self.intoType == 0)
    {
        if ([self.vc respondsToSelector:@selector(getGameAndActDetail)]) {
            [self.vc performSelector:@selector(getGameAndActDetail)];//刷新赛事报名活动
        }
    }else if(self.intoType == 1)
    {//1:我的订单（未支付订单）-》支付
        [self.vc.navigationController popViewControllerAnimated:NO];
        if ([self.fvc respondsToSelector:@selector(getPageData)]) {
            [self.fvc performSelector:@selector(getPageData)];//刷新赛事报名活动
        }
    }else if(self.intoType == 2)
    {
        //立即报名-》我的订单（未支付订单）-》支付
        [self.vc.navigationController popToViewController:self.fvc animated:YES];
        //刷新报名页
        if ([self.fvc respondsToSelector:@selector(getGameAndActDetail)]) {
            [self.fvc performSelector:@selector(getGameAndActDetail)];//刷新赛事报名活动
        }
    }
}
@end
