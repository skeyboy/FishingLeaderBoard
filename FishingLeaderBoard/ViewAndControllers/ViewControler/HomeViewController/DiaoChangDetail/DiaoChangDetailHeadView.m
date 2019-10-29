//
//  DiaoChangHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailHeadView.h"
#import "FSSegmentTitleView.h"
@interface DiaoChangDetailHeadView()<FSSegmentTitleViewDelegate>

@end
@implementation DiaoChangDetailHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(frame), 50) delegate:nil indicatorType:1];
        titleView.titlesArr = @[@"活动/赛事",@"简介",@"渔获"];
        [self addSubview:titleView];
        titleView.titleSelectColor=BLACKCOLOR;
        titleView.indicatorColor =BLACKCOLOR;
        titleView.backgroundColor = WHITECOLOR;
    }
    return self;
}
-(void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    
}
@end

