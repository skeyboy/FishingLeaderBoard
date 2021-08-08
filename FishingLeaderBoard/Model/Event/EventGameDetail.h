//
//  EventGameDetail.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface EventGameDetail : NSObject
PropAssign(NSInteger,  overDay)
PropAssign(NSInteger, id)
PropAssign(NSInteger, readNum)
PropAssign(NSInteger,associationType)
PropAssign(NSInteger,createUserId)
PropAssign(NSInteger,eventTimes)
PropAssign(NSInteger,fee)
PropAssign(NSInteger,isPast)//0 没过期 1过期
PropAssign(NSInteger,isPay) // 0 1 有待支付直接跳转待支付列表
PropAssign(NSInteger,lotNumber)//1不摇号2摇号
PropAssign(NSInteger,peopleNumber)
PropAssign(NSInteger,removed)
PropAssign(NSInteger,spotId)
PropAssign(NSInteger,status)
PropAssign(NSInteger,top)
//钓场类型（1：黑坑，2：路亚，3：自然水域，4：海钓）
PropAssign(NSInteger,type)//1：活动，2赛事
PropAssign(NSInteger,version)
PropAssign(NSInteger,updateAccountId)
PropAssign(NSInteger,isCollect)

PropCopy(NSDate, createTime)
PropCopy(NSDate, endTime)
PropCopy(NSDate, lotTime)
PropCopy(NSDate, startTime)
PropCopy(NSDate, updateTime)

PropCopy(NSString, content)
PropCopy(NSString, coverImage)
PropCopy(NSString, createUserName)
PropCopy(NSString, fishes)
PropCopy(NSString, money)
PropCopy(NSString, name)
PropCopy(NSString, tab)
PropCopy(NSString, weight)
PropCopy(NSString, posters)

PropCopy(NSString, spotName)
PropCopy(NSString, province)
PropCopy(NSString, longitude)
PropCopy(NSString, latitude)
PropCopy(NSString, city)
PropCopy(NSString, area)
PropCopy(NSString, address)
PropAssign(NSInteger, fishNum)
PropCopy(NSString, phone)
PropCopy(NSString,miniShare)

//============
//model
PropAssign(NSInteger, endTimeInt)
PropAssign(NSInteger, fishpondId)
PropAssign(NSInteger, pattern)
PropAssign(NSInteger, playType)
PropAssign(NSInteger, prepay)
PropAssign(NSInteger, spotType)
PropAssign(CGFloat, repurchase)

PropCopy(NSString,dateStr)
PropCopy(NSString,finishTimeStr)
PropCopy(NSString,lotTimeStr)
PropCopy(NSString,startTimeStr)
PropCopy(NSString,prepayMoney)

PropCopy(NSDate, finishTime)

-(NSString *)shareTtitleInfo;
@end

NS_ASSUME_NONNULL_END
