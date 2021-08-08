//
//  GoodsLists.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsListsItem.h"
NS_ASSUME_NONNULL_BEGIN


@interface GoodsLists : NSObject
PropCopy(Page, page)
PropCopy(NSArray<GoodsListsItem*>, list)

@end

NS_ASSUME_NONNULL_END
