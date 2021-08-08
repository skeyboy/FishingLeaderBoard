//
//  CostomProgressView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import "CostomProgressView.h"

@implementation CostomProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
     
     
    
    }
    return self;
}
-(void)setProgressView:(float)progress arr:(NSArray *)arrLabelTexts
{
    [self removeAllSubviews];
    self.progressView = [[UIProgressView alloc]init];
    [self.progressView setProgressTintColor:[UIColor orangeColor]];
         self.progressView.transform = CGAffineTransformMakeScale(1.0f,10.0f);
         [self addSubview:self.progressView];
         [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.equalTo(self.mas_centerY);
             make.left.equalTo(self.mas_left).offset(10);
             make.width.equalTo(@(SCREEN_WIDTH-40));
         }];
    self.progressView.progress = progress;
    UILabel *label = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"您已完成%.0f场比赛",120*progress] font:[UIFont systemFontOfSize:14] textColor:[UIColor orangeColor] textAlignment:NSTextAlignmentCenter];
         [self addSubview:label];
         [label mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.mas_left).offset(self.progressView.progress*(SCREEN_WIDTH-40)+10);
             make.height.equalTo(@30);
             make.centerY.equalTo(self.mas_centerY).offset(-30);
         }];
    for(int i = 0;i<arrLabelTexts.count;i++)
    {
        UILabel *label = [FViewCreateFactory createLabelWithName:arrLabelTexts[i] font:[UIFont systemFontOfSize:14] textColor:BLACKCOLOR textAlignment:NSTextAlignmentRight];
        [self addSubview:label];
        float width =(SCREEN_WIDTH-40)/arrLabelTexts.count;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY).offset(30);
            make.width.equalTo(@(width));
            make.left.equalTo(self.mas_left).offset(width*i);
        }];
    }
}
@end
