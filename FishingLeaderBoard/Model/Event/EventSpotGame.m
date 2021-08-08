//
//  EventSpotGame.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "EventSpotGame.h"

@implementation EventSpotGame
YYModelCommon
POSTER_FISHES
YYModelDate((@[]))
YYModelContainerPropertyGenericClass((
                                      @{
                                          @"list":EventSpotGameItem.class
                                      }))

@end

@implementation EventSpotGameItem
+(BOOL)asArray{
    return YES;
}
YYModelCommon
YYModelDate((@[@"startTime",@"lotTime",@"endTime"]))
@end
