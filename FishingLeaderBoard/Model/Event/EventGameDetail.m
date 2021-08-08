//
//  EventGameDetail.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "EventGameDetail.h"

@implementation EventGameDetail
YYModelCommon
YYModelDate((@[@"createTime",@"endTime",@"lotTime",@"startTime",@"updateTime"]))

POSTER_FISHES

-(NSString *)shareTtitleInfo{
    return  [NSString stringWithFormat:@"%@ %@ %@(%@)",[self eventTitle],[self eventTimeTitle],self.spotName,self.name]
    ;
}
-(NSString *)eventTitle{
    if (self.tab) {
        return @"";
    }
    if (self.tab) {
        return @"";
    }
    if (self.tab) {
        return @"";
    }
    return @"";
}
-(NSString *)eventTimeTitle{
    switch (self.eventTimes) {
        case 1:
            return @"日场";
            break;
            case 2:
            return @"夜场";
            break;
        default:
            return @"";
            break;
    }
}
@end
