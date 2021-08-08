//
//  GoodsOrderDetail.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/5.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Goods, Order;
@interface GoodsOrderDetail : NSObject

@property(copy, nonatomic) NSString * selectSku;
@property(copy, nonatomic) Order * order;
@property(copy, nonatomic) Goods * goods;
@property(copy, nonatomic) NSString * address;
@property(copy, nonatomic) NSString * spotName;

@end

@interface Goods:NSObject
@property(copy, nonatomic) NSString * coverImg;
@property(copy, nonatomic) NSString * goodsDesc;
@property(assign, nonatomic) NSInteger goodsType;
@property(assign, nonatomic) NSInteger id;
@property(copy, nonatomic) NSString * recommends;
@property(assign, nonatomic) NSInteger hot;
@property(assign, nonatomic) NSInteger removed;
@property(assign, nonatomic) NSInteger price;
PropCopy(NSDate, createTime)
PropCopy(NSDate, updateTime)

@property(assign, nonatomic) NSInteger sale;
@property(copy, nonatomic) NSString * name;
@property(copy, nonatomic) NSString * descImg;
@end
@interface Order:NSObject
@property(assign, nonatomic) NSInteger id;
@property(copy, nonatomic)NSString *remark;
@property(assign, nonatomic) NSInteger spotId;
@property(assign, nonatomic) NSInteger skuId;
@property(copy, nonatomic) NSString * code;
@property(assign, nonatomic) NSInteger receiveType;
@property(assign, nonatomic) NSInteger number;
@property(assign, nonatomic) NSInteger userId;
@property(assign, nonatomic) NSInteger currency;
//`status` int(4) DEFAULT NULL COMMENT '订单状态（1：待支付，2：待提货，3：已完成，4：交易失败）'
@property(assign, nonatomic) NSInteger status;
@property(assign, nonatomic) NSInteger addId;
PropCopy(NSDate, createTime)
PropCopy(NSDate, updateTime)
PropCopy(NSDate, finishTime)
@end



NS_ASSUME_NONNULL_END
