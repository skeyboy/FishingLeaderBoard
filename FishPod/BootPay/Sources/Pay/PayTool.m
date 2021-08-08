//
//  ToolClass.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

 #import <AlipaySDK/AlipaySDK.h>
#import "FConstont.h"
#import "PayTool.h"
#import "ApiFetch+Order.h"
#import "ApiFetch+Goods.h"
#import "OrderApplyGame.h"
#import "UIViewController+ShowHud.h"
@implementation PayTool  

+(void)applicationCode:(NSString *) applicationCode  holder:(UIViewController*) hoderVC{
    
    
    UIAlertController * payController = [UIAlertController alertControllerWithTitle:@"支付提示" message:@"选择您的支付方式" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    UIAlertAction * aliPayAction = [UIAlertAction actionWithTitle:@"支付宝支付" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self payApplicationCode:applicationCode
                              payType:PayTypeAli holder:hoderVC] ;
    }];
    UIAlertAction * wxPayAction = [UIAlertAction actionWithTitle:@"微信支付" style:0 handler:^(UIAlertAction * _Nonnull action) {
           [self payApplicationCode:applicationCode
                                 payType:PayTypeWx holder:hoderVC];
       }];
    UIAlertAction * walletPayAction = [UIAlertAction actionWithTitle:@"钱包支付" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self payApplicationCode:applicationCode
                              payType:PayTypeWallet holder:hoderVC];
       }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [payController addAction:walletPayAction];
    [payController addAction:aliPayAction];
    [payController addAction:wxPayAction];
    [payController addAction:cancelAction];
    
[hoderVC presentViewController:payController
                      animated:YES
                    completion:^{
    
}];
}
+(void)payApplicationCode:(NSString *) applicationCode payType:(PayType) payType  holder:(UIViewController*) hoderVC {
        NSDictionary * orderValue = @{
            @"applicationCode":applicationCode,
            @"payType":@(payType)
        };
       [[ApiFetch share] orderPostFetch:ORDER_ENROLL_PAY
                                   body:orderValue
                                 holder:hoderVC
                              dataModel:NSDictionary.class
                              onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
           
           NSString * payOrderId =@"";
           switch (payType) {
               case PayTypeWx:{
                   //微信支付
    //               [YuWeChatShareManager manager]
               }
                   break;
                   case PayTypeAli:{
                   //支付宝
                       [[AlipaySDK defaultService]  payOrder:payOrderId
                                                  fromScheme:ALI_SCHEME
                                                    callback:^(NSDictionary *resultDic) {
                           
                       }];
               }
                   break;
               default:
                   break;
           }
       }];
}
+(void)enrollPay:(PayType) payType
         eventId:(NSString *) eventId
      tranAmount:(NSString *) tranAmount
     enrollCount:(NSInteger) enrollCount
          holder:(UIView *) holder
{
    
    NSDictionary *orderValue  = @{
        @"count":@(enrollCount),
        @"tranAmount":tranAmount,
        @"eventId":eventId,
        @"payType":@(payType),
    };
    [[ApiFetch share] orderPostFetch:ORDER_ENROLL_PAY
                                body:orderValue
                              holder:holder.viewController
                           dataModel:NSDictionary.class
                           onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        
    }];
    if (payType == PayTypeWx) {
        
    }
    if (payType == PayTypeAli) {
     }
}

+(void)pay:(NSDictionary *)payParams
  shortUri:(NSString *) uri
   payType:(PayType) payType
    holder:(UIViewController *) hodlerVC
    isPost:(BOOL)isPost
aliResponse:(id<YuAliPayResponse>) aliResponse
//wxResponse:(id<YuWXPayResponse>) wxResponse
walletCallback:(void(^)(void)) walletResult{
    Class modelClass;
        switch (payType) {
            case PayTypeWx:
                modelClass = OrderApplyGameWx.class;
                break;
                case PayTypeAli:
                modelClass = OrderApplyGameAli.class;
                break;
                case PayTypeWallet:
                modelClass = OrderApplyGameParent.class;
                break;
            default:
                break;
        }
        @weakify(self)
       if(isPost == YES)
       {
               [[ApiFetch share] orderPostFetch:uri
                                           body:payParams
                                         holder:hodlerVC
                                      dataModel:modelClass
                                      onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                   
                   OrderApplyGameBase * orderApplayGame = (  OrderApplyGameBase * ) modelValue;
                   switch (orderApplayGame.type) {
                       case PayTypeWx:
                       {
                           OrderApplyGameWx *wxPayValue = ( OrderApplyGameWx *) modelValue;
                           NSDictionary * value = [wxPayValue.value jsonValueDecoded];
//                           [YuWeChatShareManager pay:value responseView:wxResponse];
                       }
                           break;
                       case PayTypeAli:{
                           OrderApplyGameAli * aliPayValue = (OrderApplyGameAli *)modelValue;
                           [[AlipaySDK defaultService] payOrder:aliPayValue.value
                                                     fromScheme: ALI_SCHEME
                                                       callback:^(NSDictionary *resultDic) {//返回异常信息
           //                     NSInteger resultStatus = [[NSNumber numberWithString: [resultDic valueForKey:@"resultStatus"] ] integerValue];
//                               [hodlerVC makeToask:resultDic[@"memo"]];
                               id<YuAliPayResponse> payResponse = [AlipaySDK defaultService].payResponse;
                                         if (payResponse) {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [payResponse aliPayResponse:resultDic];
                                             });
                                         }
                           } withResp:aliResponse];
                       }break;
                           case PayTypeWallet:
                       {
                           walletResult();
                       }
                           break;
                       default:
                           break;
                   }
                  
               }];
       }else{
               [[ApiFetch share] orderGetFetch:uri
                                           query:payParams
                                         holder:hodlerVC
                                      dataModel:modelClass
                                      onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                   
                   OrderApplyGameBase * orderApplayGame = (  OrderApplyGameBase * ) modelValue;
                   switch (orderApplayGame.type) {
                       case PayTypeWx:
                       {
                           OrderApplyGameWx *wxPayValue = ( OrderApplyGameWx *) modelValue;
                           NSDictionary * value = [wxPayValue.value jsonValueDecoded];
//                           [YuWeChatShareManager pay:value responseView:wxResponse];
                       }
                           break;
                       case PayTypeAli:{
                           OrderApplyGameAli * aliPayValue = (OrderApplyGameAli *)modelValue;
                           [[AlipaySDK defaultService] payOrder:aliPayValue.value
                                                     fromScheme: ALI_SCHEME
                                                       callback:^(NSDictionary *resultDic) {//返回异常信息
           //                     NSInteger resultStatus = [[NSNumber numberWithString: [resultDic valueForKey:@"resultStatus"] ] integerValue];
                               [hodlerVC makeToask:resultDic[@"memo"]];
                           } withResp:aliResponse];
                       }break;
                           case PayTypeWallet:
                       {
                           walletResult();
                       }
                           break;
                       default:
                           break;
                   }
                  
               }];
       }
}

+(void)payGoods:(NSDictionary *)payParams
  shortUri:(NSString *) uri
   payType:(PayType) payType
    holder:(UIViewController *) hodlerVC
    isPost:(BOOL)isPost
aliResponse:(id<YuAliPayResponse>) aliResponse
//wxResponse:(id<YuWXPayResponse>) wxResponse
walletCallback:(void(^)(void)) walletResult{
    Class modelClass;
        switch (payType) {
            case PayTypeWx:
                modelClass = OrderApplyGameWx.class;
                break;
                case PayTypeAli:
                modelClass = OrderApplyGameAli.class;
                break;
                case PayTypeWallet:
                modelClass = OrderApplyGameParent.class;
                break;
            default:
                break;
        }
        @weakify(self)
       if(isPost == YES)
       {
               [[ApiFetch share] goodsPostFetch:uri
                                           body:payParams
                                         holder:hodlerVC
                                      dataModel:modelClass
                                      onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                   
                   OrderApplyGameBase * orderApplayGame = (  OrderApplyGameBase * ) modelValue;
                   switch (orderApplayGame.type) {
                       case PayTypeWx:
                       {
                           OrderApplyGameWx *wxPayValue = ( OrderApplyGameWx *) modelValue;
                           NSDictionary * value = [wxPayValue.value jsonValueDecoded];
//                           [YuWeChatShareManager pay:value responseView:wxResponse];
                       }
                           break;
                       case PayTypeAli:{
                           OrderApplyGameAli * aliPayValue = (OrderApplyGameAli *)modelValue;
                           [[AlipaySDK defaultService] payOrder:aliPayValue.value
                                                     fromScheme: ALI_SCHEME
                                                       callback:^(NSDictionary *resultDic) {//返回异常信息
           //                     NSInteger resultStatus = [[NSNumber numberWithString: [resultDic valueForKey:@"resultStatus"] ] integerValue];
//                               [hodlerVC makeToask:resultDic[@"memo"]];
                               id<YuAliPayResponse> payResponse = [AlipaySDK defaultService].payResponse;
                                         if (payResponse) {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [payResponse aliPayResponse:resultDic];
                                             });
                                         }
                           } withResp:aliResponse];
                       }break;
                           case PayTypeWallet:
                       {
                           walletResult();
                       }
                           break;
                       default:
                           break;
                   }
                  
               }];
       }else{
               [[ApiFetch share] goodsGetFetch:uri
                                           query:payParams
                                         holder:hodlerVC
                                      dataModel:modelClass
                                      onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                   
                   OrderApplyGameBase * orderApplayGame = (  OrderApplyGameBase * ) modelValue;
                   switch (orderApplayGame.type) {
                       case PayTypeWx:
                       {
                           OrderApplyGameWx *wxPayValue = ( OrderApplyGameWx *) modelValue;
                           NSDictionary * value = [wxPayValue.value jsonValueDecoded];
//                           [YuWeChatShareManager pay:value responseView:wxResponse];
                       }
                           break;
                       case PayTypeAli:{
                           OrderApplyGameAli * aliPayValue = (OrderApplyGameAli *)modelValue;
                           [[AlipaySDK defaultService] payOrder:aliPayValue.value
                                                     fromScheme: ALI_SCHEME
                                                       callback:^(NSDictionary *resultDic) {//返回异常信息
           //                     NSInteger resultStatus = [[NSNumber numberWithString: [resultDic valueForKey:@"resultStatus"] ] integerValue];
                               [hodlerVC makeToask:resultDic[@"memo"]];
                           } withResp:aliResponse];
                       }break;
                           case PayTypeWallet:
                       {
                           walletResult();
                       }
                           break;
                       default:
                           break;
                   }
                  
               }];
       }
}
@end
