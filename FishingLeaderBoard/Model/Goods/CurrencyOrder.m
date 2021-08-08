//
//  CurrencyOrder.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/17.
//  Copyright © 2020 yue. All rights reserved.
//

#import "CurrencyOrder.h"

@implementation CurrencyOrder
YYModelCommon
YYModelContainerPropertyGenericClass((@{
    @"list":CurrencyOrderItem.class
}))
@end

@implementation CurrencyOrderItem
YYModelCommon
YYModelDate((@[@"takeTime",@"orderTime"]))
@end
