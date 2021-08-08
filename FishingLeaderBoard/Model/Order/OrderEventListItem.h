//
//  OrderEventListItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderEventListItem : NSObject
@property(assign, nonatomic) NSInteger count;
@property(assign, nonatomic) float cunYuShouRu;
@property(assign, nonatomic) NSInteger eventId;
@property(assign, nonatomic) NSInteger eventType;
@property(assign, nonatomic) float yuPiaoShouRu;
@property(assign, nonatomic) float shouYuZhiChu;
@property(copy, nonatomic) NSString* coverImage;
@property(copy, nonatomic) NSString* eventName;
@property(copy, nonatomic) NSDate* finishTime;
@property(copy, nonatomic) NSDate* startTime;
@property(copy, nonatomic) NSDate* updateTime;
@end

NS_ASSUME_NONNULL_END
