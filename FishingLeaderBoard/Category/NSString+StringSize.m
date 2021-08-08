//
//  NSString+StringSize.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "NSString+StringSize.h"
#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

@implementation NSString (StringSize)
- (CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font
                     inHeight:30];
}
- (CGSize)sizeWithFont:(UIFont *)font
              inHeight:(CGFloat) height{
  
CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font}context:nil];

return rect.size;

}
@end
