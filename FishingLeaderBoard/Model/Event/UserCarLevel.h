//
//  UserCarLevel.h
//  FishingLeaderBoard
//
//  Created by 李雨龙 on 2020/4/9.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCarLevel : NSObject
@property(assign) NSUInteger activityGoalPrice;
@property(assign) NSUInteger activityKeepPrice;
@property(assign) NSUInteger activityPrice;
@property(copy) NSString * cardNum;
@property(assign) NSUInteger currency;
@property(assign) NSUInteger gameCount;
@property(assign) NSUInteger gameGoalCount;
@property(assign) NSUInteger gameGoalPrice;
@property(assign) NSUInteger gameKeepCount;
@property(assign) NSUInteger gameKeepPrice;
@property(assign) NSUInteger gamePrice;
@property(assign) NSUInteger kValue;
@property(copy) NSDate* serviceEndTime;
@property(assign) NSUInteger userId;
@property(assign) NSUInteger userLevel;
@property(copy) NSString * userName;

@end

NS_ASSUME_NONNULL_END
