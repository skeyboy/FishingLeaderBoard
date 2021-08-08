//
//  GoodsOrderListItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsOrderListItem : NSObject
PropCopy(NSString, code)
PropCopy(NSString, coverImg)

PropCopy(NSString, currency)

PropCopy(NSString, goodsName)
PropCopy(NSString, selectSku)
PropCopy(NSString, seatNumber)
PropCopy(NSString, distance)
PropAssign(NSInteger, number)
PropAssign(NSInteger, receiveType)
PropAssign(NSInteger, status)
@end

NS_ASSUME_NONNULL_END
