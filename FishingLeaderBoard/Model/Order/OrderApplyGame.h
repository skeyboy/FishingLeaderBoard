//
//  OrderApplyGame.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class OrderApplyGame;
@interface OrderApplyGameBase : NSObject
PropAssign(PayType, type)
@end

@interface OrderApplyGameWx : OrderApplyGameBase
PropCopy(NSString, value)
@end

@interface OrderApplyGameAli : OrderApplyGameBase
PropCopy(NSString,value)
@end



@interface OrderApplyGameParent:OrderApplyGameBase
PropCopy(NSDate, activityDate)
PropCopy(NSString, applicationCode)
PropAssign(NSInteger, check)
PropAssign(NSInteger, count)
PropAssign(NSInteger, eventId)
PropCopy(NSString, eventName)
PropAssign(NSInteger, eventType)
PropCopy(NSString, icon)
PropAssign(NSInteger, spotId)
PropCopy(NSString, spotName)
PropCopy(NSString, spotType)
PropAssign(NSInteger, spotUserId)
PropAssign(NSInteger, status)
PropCopy(NSString, tranAmount)
PropCopy(NSDate, startDate)
PropCopy(NSDate, endDate)
PropAssign(NSInteger, peopleNumber)
PropAssign(NSInteger, fishNum)
PropCopy(NSString, address)
PropCopy(NSString, lat)
PropCopy(NSString, lng)
PropCopy(NSString, price)
PropCopy(NSDate, createTime)
PropCopy(NSString, seatNumber)//座位号 ，号隔开
PropCopy(NSString, phone)
@end
//报名下单
@interface OrderApplyGame : OrderApplyGameParent

@end

NS_ASSUME_NONNULL_END
