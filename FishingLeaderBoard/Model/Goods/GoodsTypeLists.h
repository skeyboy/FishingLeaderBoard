//
//  GoodsTypeLists.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GoodsTypeListsItem;
@interface GoodsTypeLists : NSObject
PropCopy(NSArray<GoodsTypeListsItem*>, value)
@end
@interface GoodsTypeListsItem : NSObject
PropAssign(NSInteger, id)
PropCopy(NSString, name)
PropAssign(BOOL, hasNext)
@end
NS_ASSUME_NONNULL_END
