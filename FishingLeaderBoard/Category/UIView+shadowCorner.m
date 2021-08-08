//
//  UIView+shadowCorner.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIView+shadowCorner.h"

@implementation UIView (shadowCorner)
-(void)addShadowCornerRadius:(float)radius cornerRadius:(float)corner shadowOpacity:(CGFloat)op
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowOffset =CGSizeMake(0,0);
    self.layer.shadowColor =[UIColor blackColor].CGColor;
    self.layer.shadowOpacity = op;
    self.layer.shadowRadius = radius;
    self.clipsToBounds = NO;
    self.layer.cornerRadius = corner;

}
@end
