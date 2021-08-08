//
//  PaiMingItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/15.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaiMingItem : NSObject

PropCopy(NSString, headImg)
PropCopy(NSString, nickName)
PropAssign(NSInteger,id)

PropAssign(NSInteger,userId)
PropAssign(NSInteger,eventId)
PropAssign(NSInteger,currencyCount)
PropAssign(NSInteger, buyBackCount)

@end
//{
//  "code": 0,
//  "data": {
//    "eventName": "string",
//    "list": [
//      {
//        "buyBackCount": 0,
//        "currencyCount": 0,
//        "eventId": 0,
//        "headImg": "string",
//        "id": 0,
//        "nickName": "string",
//        "userId": 0
//      }
//    ],
//    "startTime": "2020-04-08T03:17:21.834Z"
//  },
//  "message": "string"
//}
@interface PaiMingList : NSObject
PropCopy(NSArray<PaiMingItem*>, list)
PropCopy(NSString,eventName)
PropCopy(NSDate,startTime)

@end
NS_ASSUME_NONNULL_END
