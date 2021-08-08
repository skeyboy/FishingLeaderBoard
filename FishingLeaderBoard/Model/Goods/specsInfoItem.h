//
//  specsInfoItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "valueListItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface specsInfoItem : NSObject
PropAssign(NSInteger, id)
PropCopy(NSString, name)
PropCopy(NSArray<valueListItem*>, valueList)
@end

NS_ASSUME_NONNULL_END
