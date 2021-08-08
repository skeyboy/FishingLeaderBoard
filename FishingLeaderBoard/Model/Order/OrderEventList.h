//
//  OrderEventList.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderEventList : NSObject
PropCopy(Page, page)
PropCopy(NSArray<OrderEventListItem*>, list)
@end

NS_ASSUME_NONNULL_END
