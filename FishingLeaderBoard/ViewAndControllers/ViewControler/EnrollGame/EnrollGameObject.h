//
//  EnrollGameObject.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/9.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToPayView.h"
NS_ASSUME_NONNULL_BEGIN

@interface EnrollGameObject : NSObject<YuAliPayResponse,YuWXPayResponse,ApiFetchOptionalHandler>
typedef void(^CreateOrderSuccessClick) (BOOL);
@property(copy,nonatomic)CreateOrderSuccessClick createOrderSuccessClick;
@property(strong,nonatomic)UIViewController*vc;
//1,2
@property(strong,nonatomic)UIViewController *fvc;
@property(strong,nonatomic)ToPayView *pay;
//1:我的订单（未支付订单）-》支付
//2：立即报名-》我的订单（未支付订单）-》支付
//0：立即报名-》支付
@property(assign,nonatomic)NSInteger intoType;
-(void)enrollGame:(EventGameDetail*)eventGameDetail eventId:(NSInteger)eventId vc:(UIViewController*)vc;
//showNoPayList未支付订单列表进
-(void)choosePayTypeSuperVC:(UIViewController *)vc vc:(UIViewController*)vc1 intoType:(NSInteger)intoType or:(OrderApplyGame*)orderValue tranAmount:(NSString*)tranAmount enrollCount:(NSInteger)enrollCount eventId:(NSString*)eventId;
@end

NS_ASSUME_NONNULL_END
