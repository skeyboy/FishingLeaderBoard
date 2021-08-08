//
//  skuInfoItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/5.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skuInfoItem : NSObject
PropAssign(NSInteger, skuId)
PropAssign(NSInteger, currency)
PropCopy(NSString, value)

@end

NS_ASSUME_NONNULL_END
