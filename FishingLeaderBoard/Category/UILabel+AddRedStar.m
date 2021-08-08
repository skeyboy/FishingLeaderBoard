//
//  UILabel+AddRedStar.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/12.
//  Copyright © 2020 yue. All rights reserved.
//

#import "UILabel+AddRedStar.h"


@implementation UILabel (AddRedStar)

-(void)setRedStarText:(NSString *)text
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[text rangeOfString:@"*"]];
    self.attributedText =str;
}

@end
