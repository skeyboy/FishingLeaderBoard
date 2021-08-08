//
//  GoodsDetail.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "specsInfoItem.h"
#import "valueListItem.h"
#import "skuInfoItem.h"
NS_ASSUME_NONNULL_BEGIN
@class specsInfoItem;
@interface GoodsDetail : NSObject
PropAssign(NSInteger, id)
//钓场总库存，大于0时可自提
PropAssign(NSInteger, spotCount)
//总公司库存，大于0时可快递到家
PropAssign(NSInteger, companyCount)
PropCopy(NSString, coverImg)
PropCopy(NSArray, coverList)

PropCopy(NSString, descImg)
PropCopy(NSString, goodsDesc)
PropCopy(NSString, name)
PropCopy(NSString, recommends)
PropCopy(NSString, miniShare)


PropAssign(NSInteger, goodsType)
PropAssign(NSInteger, hot)
PropAssign(NSInteger, price)
PropAssign(NSInteger, isLike)



PropCopy(NSArray<specsInfoItem*>, specsInfo)
PropCopy(NSArray<skuInfoItem*>, skuInfo)

@end
NS_ASSUME_NONNULL_END
