//
//  ToolClass.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
