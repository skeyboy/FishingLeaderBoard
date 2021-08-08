//
//  NSString+StringSize.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//
#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif
#if TARGET_OS_iOS
#import <Foundation/Foundation.h>
#endif
NS_ASSUME_NONNULL_BEGIN

@interface NSString (StringSize)

/// 根据font计算出文本所占面，默认高度为30，按照一行来计算
/// @param font <#font description#>
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font
              inHeight:(CGFloat) height;
@end

NS_ASSUME_NONNULL_END
