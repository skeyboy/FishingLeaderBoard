//
//  PaiMingItem.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/15.
//  Copyright © 2020 yue. All rights reserved.
//

#import "PaiMingItem.h"

@implementation PaiMingItem
YYModelCommon
@end

@implementation PaiMingList : NSObject
YYModelCommon
YYModelDate((@[@"startTime"]))

YYModelContainerPropertyGenericClass((
@{
    @"list":PaiMingItem.class
}))
@end
