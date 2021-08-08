//
//  SellerStock.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/20.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SellerStock : NSObject
@property(assign, nonatomic) NSInteger number;
@property(copy, nonatomic) NSString * coverImg;
@property(copy, nonatomic) NSString * selectSku;
@property(assign, nonatomic) NSInteger skuId;
@property(copy, nonatomic) NSString * goodsName;
@end

NS_ASSUME_NONNULL_END
