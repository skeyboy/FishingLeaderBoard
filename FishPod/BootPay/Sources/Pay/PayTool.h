//
//  ToolClass.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YuWeChatShareManager.h"
#import "AlipaySDK+pay.h"
NS_ASSUME_NONNULL_BEGIN

#define ALI_SCHEME @"ali2019043064374582"

@protocol YuAliPayResponse <NSObject>

-(void)aliPayResponse:(NSDictionary *_Nullable) dic;

@end

@interface PayTool : NSObject

//下单换取App支付订单
+(void)applicationCode:(NSString *) applicationCode  holder:(UIViewController*) hoderVC;

///支付付款的通一位置

/// 统一的金钱交易入口
/// @param payParams 请求参数
/// @param uri 交易对应的URL
/// @param payType 交易类型
/// @param hodlerVC 发起交易所在的视图
/// @param aliResponse 支付宝的回调处理
/// @param wxResponse 微信的回调处理
/// @param walletResult 钱包的处理
+(void)pay:(NSDictionary *)payParams
   shortUri:(NSString *) uri payType:(PayType) payType
    holder:(UIViewController *) hodlerVC
    isPost:(BOOL)isPost
aliResponse:(id<YuAliPayResponse>) aliResponse
//wxResponse:(id<YuWXPayResponse>) wxResponse
walletCallback:(void(^)(void)) walletResult;
+(void)payGoods:(NSDictionary *)payParams
   shortUri:(NSString *) uri payType:(PayType) payType
    holder:(UIViewController *) hodlerVC
    isPost:(BOOL)isPost
aliResponse:(id<YuAliPayResponse>) aliResponse
//     wxResponse:(id<YuWXPayResponse>) wxResponse
 walletCallback:(void(^)(void)) walletResult;
@end

NS_ASSUME_NONNULL_END
