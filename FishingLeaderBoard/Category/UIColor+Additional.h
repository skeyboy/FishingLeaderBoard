//
//  UIColor+Additional.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Additional)
/**
 *  根据字符串生成颜色
 *
 *  @param inColorString 16进制的颜色字符串，如ab2345
 *
 *  @return 颜色
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;


@end

NS_ASSUME_NONNULL_END
