//
//  HudCostomView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/10.
//  Copyright © 2019 yue. All rights reserved.
//

#import "HudCostomView.h"

@implementation HudCostomView

- (CGSize)intrinsicContentSize {
    CGFloat contentViewH = 80;
    CGFloat contentViewW =SCREEN_WIDTH - 40;
    return CGSizeMake(contentViewW, contentViewH);
}


- (instancetype)initWithFrame:(CGRect)frame {
//   self = [[NSBundle mainBundle] loadNibNamed:@"GLNoticeView" owner:nil options:nil].firstObject;
    self = [super initWithFrame:frame];
    if(self)
    {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    }
    return self;
}


@end
