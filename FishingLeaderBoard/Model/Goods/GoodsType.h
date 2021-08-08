//
//  GoodsType.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/11.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsType;
NS_ASSUME_NONNULL_BEGIN
@interface GoodTypeValue : NSObject
@property(nonatomic) NSArray<GoodsType*> *value;
@end
@interface GoodsType : NSObject
@property(assign, nonatomic) BOOL hasNext;
@property(assign, nonatomic) NSInteger  id;
@property(copy, nonatomic) NSString * name;
@end

NS_ASSUME_NONNULL_END
