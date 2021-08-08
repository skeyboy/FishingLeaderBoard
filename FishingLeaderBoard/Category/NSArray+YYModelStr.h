//
//  NSArray+YYModelStr.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/19.
//  Copyright © 2019 yue. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YYModelStr)
+ (NSArray *)modelArrayWithClass:(Class)cls onlyStrArray:(NSArray *)items;
@end

NS_ASSUME_NONNULL_END
