//
//  EventSpotGame.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 赛事活动列表模型
NS_ASSUME_NONNULL_BEGIN
@class EventSpotGameItem;
@interface EventSpotGame : NSObject
PropCopy(Page, page)
PropCopy(NSArray<EventSpotGameItem*>, list)
@end
@interface EventSpotGameItem : NSObject
PropAssign(NSInteger, id)
PropCopy(NSString, name)
PropCopy(NSString, city)
PropAssign(NSInteger, type)//1 活动 2 赛事
PropAssign(NSInteger, top)// 1指定 2 不置顶
PropAssign(NSInteger, pattern)// 1指定 2 不置顶
PropAssign(float, weight)
PropCopy(NSString, posters)
PropCopy(NSString, coverImage)
PropCopy(NSString, tab)
PropCopy(NSString, money)
PropCopy(NSString, spotName)
PropCopy(NSString, spotType)
PropAssign(NSInteger, peopleNumber)
PropAssign(NSInteger, eventTimes)
PropCopy(NSString, fishes)
PropCopy(NSDate, startTime)
PropCopy(NSDate, endTime)//报名截止时间
PropCopy(NSDate, lotTime)//摇号截止时间
PropAssign(NSInteger, isPast)//是否过期
PropAssign(NSInteger, status)


@end

NS_ASSUME_NONNULL_END
