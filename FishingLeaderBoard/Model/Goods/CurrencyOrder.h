//
//  CurrencyOrder.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/17.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"
@class CurrencyOrderItem;
NS_ASSUME_NONNULL_BEGIN

@interface CurrencyOrder : NSObject
PropCopy(NSArray, list)
PropCopy(Page, page)
@end
typedef NS_ENUM(NSUInteger, OrderStatus) {
    OrderStatusNotYou = 1,//不属于你的
    OrderStatusReady = 2,//待提货
    OrderStatusFinished = 3,//已提货
    OrderStatusUnknown = 4//未知
};
@interface CurrencyOrderItem:NSObject
@property(copy, nonatomic) NSString * coverImg;
@property(copy, nonatomic) NSDate *orderTime;
@property(copy, nonatomic) NSDate* takeTime;
@property(assign, nonatomic) NSInteger skuId;
@property(copy, nonatomic) NSString * code;
@property(assign, nonatomic) NSInteger totalCurrency;
@property(copy, nonatomic) NSString * remark;
@property(copy, nonatomic) NSString * goodsName;
@property(assign, nonatomic) NSInteger number;
@property(assign, nonatomic) OrderStatus orderStatus;
@property(copy, nonatomic) NSString * userName;
@property(copy, nonatomic) NSString * selectSku;
@end


NS_ASSUME_NONNULL_END
