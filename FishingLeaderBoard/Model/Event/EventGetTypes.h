//
//  EventGetTypes.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/11.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventGetTypes : NSObject
PropCopy(NSString, fishes)
PropCopy(NSArray, defaultImg)
PropCopy(NSString, spotType)
PropCopy(NSArray<SpotPondInfo*>, spotFishponds)

@end

NS_ASSUME_NONNULL_END
