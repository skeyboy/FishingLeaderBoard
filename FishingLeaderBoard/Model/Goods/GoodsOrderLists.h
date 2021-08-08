//
//  GoodsOrderLists.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsOrderLists : NSObject
PropCopy(Page, page)
PropCopy(NSArray<GoodsOrderListItem*>, list)
@end

NS_ASSUME_NONNULL_END
