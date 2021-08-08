//
//  SpotPondInfo.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/10.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpotPondInfo : NSObject
PropAssign(float, waterSquare)
PropAssign(float, waterDepth)
PropAssign(float, rodLong)
PropAssign(float, spotDistance)

PropCopy(NSString, fishs)
PropCopy(NSString, id)
PropCopy(NSString, name)
PropCopy(NSString, spotId)

PropAssign(NSInteger,fishpondType)
PropAssign(NSInteger,removed)
PropAssign(NSInteger,spotCount)

PropCopy(NSDate, createTime)
PropCopy(NSDate, updateTime)

@end

@interface SpotPondInfoList : SpotPondInfo

@end

NS_ASSUME_NONNULL_END
