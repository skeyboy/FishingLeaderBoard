//
//  UserPageInfo.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPageInfo : NSObject
PropAssign(NSInteger, activity)
PropAssign(NSInteger, collect)
PropAssign(NSInteger, coupons)
PropAssign(NSInteger, game)
PropAssign(double, money)
PropCopy(NSString,  nickName)
PropCopy(NSString, phone)
PropCopy(NSString, sign)
@end

NS_ASSUME_NONNULL_END
