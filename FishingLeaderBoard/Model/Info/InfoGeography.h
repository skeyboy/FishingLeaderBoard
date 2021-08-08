//
//  InfoGeography.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 首页天气信息数据
@interface InfoGeography : NSObject
PropCopy(NSString, address)
PropCopy(NSString, temperature)
PropCopy(NSString, wind)
PropCopy(NSString, weather)
PropCopy(NSString, pM25)

@end

NS_ASSUME_NONNULL_END
