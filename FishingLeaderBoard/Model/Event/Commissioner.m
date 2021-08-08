//
//  Commissioner.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import "Commissioner.h"

@implementation Commissioner
YYModelCommon
YYModelContainerPropertyGenericClass((@{
    @"list":CommissionerGame.class
}))
@end

@implementation CommissionerGame
YYModelCommon
POSTER_FISHES
YYModelDate((@[
@"approvalTime",@"endTime",@"finishTime",@"lotTime",@"startTime"
]))

+(BOOL)asArray{
    return YES;
}
-(NSString *)statusInfo{
    switch (self.status) {
        case 1:
            return @" · 待审批";
            break;
            case 2:
            return @" · 已审批";
        default:
            return @" · 未知";
            break;
    }
}
@end
