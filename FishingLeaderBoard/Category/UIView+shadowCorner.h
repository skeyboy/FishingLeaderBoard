//
//  UIView+shadowCorner.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (shadowCorner)
-(void)addShadowCornerRadius:(float)radius cornerRadius:(float)corner shadowOpacity:(CGFloat)op;
@end

NS_ASSUME_NONNULL_END
