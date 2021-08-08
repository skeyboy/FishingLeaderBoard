//
//  InfoNewHot.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConfig.h"
#import "Page.h"
NS_ASSUME_NONNULL_BEGIN
@class NewHot;
@interface InfoNewHot : NSObject
PropCopy(Page, page)
PropCopy(NSArray<NewHot*>, list)
PropCopy(NSObject, extend)
@end
@interface NewHot : NSObject
PropAssign(NSInteger, id)
PropCopy(NSString, title)
PropCopy(NSArray, images)
PropAssign(NSInteger, hot)
PropCopy(NSDate, createTime)
@end

NS_ASSUME_NONNULL_END
