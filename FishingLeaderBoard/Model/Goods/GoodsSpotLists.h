//
//  GoodsSpotLists.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/5.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsSpotListsItem;
NS_ASSUME_NONNULL_BEGIN


@interface GoodsSpotListsItem : NSObject
PropAssign(NSInteger, id)
PropCopy(NSString, name)
PropCopy(NSString, distance)
PropAssign(NSInteger, number)
PropAssign(NSInteger, skuId)
PropAssign(NSInteger, spotId)
PropCopy(NSString, spotName)
PropCopy(NSString, spotAddress)
PropCopy(NSDate, createTime)
PropCopy(NSDate, updateTime)
@end
NS_ASSUME_NONNULL_END
