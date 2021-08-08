//
//  NSArray+YYModelStr.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "NSArray+YYModelStr.h"



@implementation NSArray (YYModelStr)
+(NSArray *)modelArrayWithClass:(Class)cls onlyStrArray:(NSArray *)items{
    if (items.count>0) {
        if( [items.firstObject isKindOfClass:NSString.class]){
            return items;
        }
    }
    return @[];
}
@end
