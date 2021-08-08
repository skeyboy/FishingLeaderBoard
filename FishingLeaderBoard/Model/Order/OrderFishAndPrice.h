//
//  OrderFishAndPrice.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/20.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderFishAndPrice : NSObject
@property(assign, nonatomic) NSInteger id;
@property(assign, nonatomic) float fishPrice;
@property(copy, nonatomic) NSString* fishName;
@end

NS_ASSUME_NONNULL_END
