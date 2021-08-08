//
//  SpotSurrounding.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConfig.h"
#import "Page.h"
#import "SpotInfo.h"
NS_ASSUME_NONNULL_BEGIN
@class SpotSurround;
@interface SpotSurrounding : NSObject
PropCopy(Page, page)
PropCopy(NSArray<SpotSurround*>, list)
@end
@interface SpotSurround : SpotInfo
@end
NS_ASSUME_NONNULL_END
