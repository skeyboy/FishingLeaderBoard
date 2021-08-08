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


+(UIView *)addSomeTwoLabelTopColor:(UIColor*)topTextColor BottomColor:(UIColor *)bottomTextColor topFont:(UIFont*)tf bottomFont:(UIFont*)bf textDataArrDict:(NSArray *)dataArr  frame:(CGRect)frame  twoLabelHeight:(CGFloat)theight click:(TwoClickBlock)twoClickBlock
{
    
    int count = (int)dataArr.count;
    NSMutableArray *twoLabelArr = [[NSMutableArray alloc]init];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    for (int i = 0; i < count; i++) {
        NSDictionary *dict = [dataArr objectAtIndex:i];
        TwoLabel *lab = [[TwoLabel alloc]init];
        lab.topLabel.textColor =topTextColor;
        lab.bottomLabel.textColor = bottomTextColor;
        lab.topLabel.font = tf;
        lab.bottomLabel.font = bf;
        lab.topLabel.text = [dict objectForKey:@"top"];
        lab.bottomLabel.text = [dict objectForKey:@"bottom"];
        lab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            twoClickBlock(i);
        }];
        [lab addGestureRecognizer:tap];
        [view addSubview:lab];
        [twoLabelArr addObject:lab];

    }
    CGFloat length = view.width/count;
    [twoLabelArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:0 tailSpacing:0];
    [twoLabelArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(view.mas_centerY);
        make.height.equalTo(@(theight));
    }];
    NSMutableArray *lineArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < count+1; i++) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:line];
        [lineArr addObject:line];
        if((i == 0)||(i == count))
        {
            line.hidden = YES;
        }
    }
    [lineArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:1 leadSpacing:0 tailSpacing:0];
    [lineArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(view.mas_centerY);
        make.height.equalTo(@(theight));
    }];
    return view;
}

@end
