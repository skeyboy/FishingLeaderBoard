//
//  DiaoChangHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailHeadView.h"
#import "CBSegmentView.h"

@implementation DiaoChangDetailHeadView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = LOGINBGCOLOR;
        NSArray *array = @[@""];
        CBSegmentView *sliderSegmentView = [[CBSegmentView alloc]initWithFrame:CGRectMake(0, 150, frame.size.width, 40)];
        [self addSubview:sliderSegmentView];
        [sliderSegmentView setTitleArray:array withStyle:CBSegmentStyleSlider];
        sliderSegmentView.titleChooseReturn = ^(NSInteger x) {
            NSLog(@"点击了第%ld个按钮",x+1);
        };
        
    }
    return self;
}

@end
