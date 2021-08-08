//
//  EventCurrency.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/17.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventCurrency : NSObject

@property(copy, nonatomic) NSString * cardNum;
@property(assign, nonatomic) float currency;

///  1普通，2白银  3黄金   4白金
@property(assign, nonatomic) NSInteger userLevel;
@end

NS_ASSUME_NONNULL_END
