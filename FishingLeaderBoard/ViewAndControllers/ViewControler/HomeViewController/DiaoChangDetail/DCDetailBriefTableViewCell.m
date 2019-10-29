//
//  DCDetailBriefTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DCDetailBriefTableViewCell.h"
@interface DCDetailBriefTableViewCell()
{
    UILabel *titleLabel;
    NSMutableArray *titleLabelArr1;
    NSMutableArray *contextLabelArr1;
    NSMutableArray *titleLabelArr2;
    NSMutableArray *contextLabelArr2;
}

@end
@implementation DCDetailBriefTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLabel = [FViewCreateFactory createLabelWithName:@"钓场概况" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        [self.contentView addSubview:titleLabel];
       
        NSArray *titleArr = [NSArray arrayWithObjects:@"总面积",@"钓位数",@"平均水深", nil];
        titleLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
        for(int i =0;i<3;i++)
        {
            UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
            [self.contentView addSubview:label];
            label.layer.borderWidth=1;
            label.layer.borderColor=[UIColor darkTextColor].CGColor;
            [titleLabelArr1 addObject:label];
        }
        contextLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
        UILabel *label = [FViewCreateFactory createLabelWithName:@"3亩" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        label.layer.borderWidth=1;
        label.layer.borderColor=[UIColor darkTextColor].CGColor;
        [self.contentView addSubview:label];
        [contextLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:@"105个" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        label.layer.borderWidth=1;
        label.layer.borderColor=[UIColor darkTextColor].CGColor;
        [self.contentView addSubview:label];
        [contextLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:@"1.8米" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        label.layer.borderWidth=1;
        label.layer.borderColor=[UIColor darkTextColor].CGColor;
        [self.contentView addSubview:label];
        [contextLabelArr1 addObject:label];
     
        titleArr = [NSArray arrayWithObjects:@"池塘数",@"钓位间距",@"限杆长度", nil];
        titleLabelArr2 = [[NSMutableArray alloc]initWithCapacity:0];
        for(int i =0;i<3;i++)
        {
            UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
            [self.contentView addSubview:label];
            label.layer.borderWidth=1;
            label.layer.borderColor=[UIColor darkTextColor].CGColor;
            [titleLabelArr2 addObject:label];
        }
        contextLabelArr2 = [[NSMutableArray alloc]initWithCapacity:0];
        label = [FViewCreateFactory createLabelWithName:@"2个" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        label.layer.borderWidth=1;
        label.layer.borderColor=[UIColor darkTextColor].CGColor;
        [self.contentView addSubview:label];
        [contextLabelArr2 addObject:label];
        label = [FViewCreateFactory createLabelWithName:@"1.8米" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        [self.contentView addSubview:label];
        label.layer.borderWidth=1;
        label.layer.borderColor=[UIColor darkTextColor].CGColor;
        [contextLabelArr2 addObject:label];
        label = [FViewCreateFactory createLabelWithName:@"4.5米" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        label.layer.borderWidth=1;
        label.layer.borderColor=[UIColor darkTextColor].CGColor;
        [self.contentView addSubview:label];
        [contextLabelArr2 addObject:label];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.height.equalTo(@40);
    }];
    [titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:50 leadSpacing:0 tailSpacing:0];
    [titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self->titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.equalTo(@((SCREEN_WIDTH-30)/4));
    }];
    [contextLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:50 leadSpacing:0 tailSpacing:0];
    [contextLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self->titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset((SCREEN_WIDTH-30)/4+5);
        make.width.equalTo(@((SCREEN_WIDTH-30)/4));
    }];
    [titleLabelArr2 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:50 leadSpacing:0 tailSpacing:0];
    [titleLabelArr2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self->titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.equalTo(@((SCREEN_WIDTH-30)/4));
    }];
    [contextLabelArr2 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:50 leadSpacing:0 tailSpacing:0];
    [contextLabelArr2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self->titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset((SCREEN_WIDTH-30)/2+5);
        make.width.equalTo(@((SCREEN_WIDTH-30)/4));
    }];
}
@end
