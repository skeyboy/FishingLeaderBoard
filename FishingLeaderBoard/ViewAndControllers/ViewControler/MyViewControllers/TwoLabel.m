//
//  TwoLabel.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "TwoLabel.h"

@implementation TwoLabel

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initView];
    }
    return self;
}
-(void)initView
{
    self.topLabel = [FViewCreateFactory createLabelWithName:@"1" font:FONT_3_bold textColor:BLACKCOLOR];
    [self addSubview:self.topLabel];
    self.bottomLabel = [FViewCreateFactory createLabelWithName:@"粉丝" font:FONT_3 textColor:BLACKCOLOR];
    [self addSubview:self.bottomLabel];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.bottomLabel.mas_top);
        make.height.mas_equalTo(self.bottomLabel.mas_height);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
}

@end
