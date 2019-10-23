//
//  ToolClass.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolClass : NSObject
//计算字体长度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
// 根据颜色生成UIImage
+ (UIImage*)imageWithColor:(UIColor*)color;
@end

NS_ASSUME_NONNULL_END
