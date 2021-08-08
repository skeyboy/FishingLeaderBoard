//
//  InfoBanner.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface InfoBanner : NSObject
PropCopy(NSString , title)
PropCopy(NSString, icon)
PropAssign(NSInteger, targetId)
//PS轮播图类型 type1：钓场，2：活动，3：赛事，4：文章
PropAssign(NSInteger, type)
@end
NS_ASSUME_NONNULL_END
