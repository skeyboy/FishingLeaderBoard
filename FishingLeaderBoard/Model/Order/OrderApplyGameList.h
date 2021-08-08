//
//  OrderApplyGameList.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class OrderApplyGame;
@interface OrderApplyGameList : NSObject
PropCopy(Page, page)
PropCopy(NSArray<OrderApplyGame*>, list)
@end

NS_ASSUME_NONNULL_END
