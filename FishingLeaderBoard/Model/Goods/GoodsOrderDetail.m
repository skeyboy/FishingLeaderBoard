//
//  GoodsOrderDetail.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/5.
//  Copyright © 2020 yue. All rights reserved.
//

#import "GoodsOrderDetail.h"

@implementation GoodsOrderDetail
YYModelCommon
YYModelContainerPropertyGenericClass((
@{
    @"order":Order.class
    ,@"goods":Goods.class
}))

@end

@implementation Goods
YYModelCommon
YYModelDate((@[@"createTime",@"updateTime"]))

@end

@implementation Order
YYModelCommon
YYModelDate((@[@"createTime",@"finishTime",@"updateTime"]))
@end
