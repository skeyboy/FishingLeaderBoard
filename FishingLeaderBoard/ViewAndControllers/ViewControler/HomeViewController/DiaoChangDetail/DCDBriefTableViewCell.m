//
//  DCDBriefTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DCDBriefTableViewCell.h"
@interface DCDBriefTableViewCell()
{
    NSMutableArray *titleLabelArr1;
    NSMutableArray *contextLabelArr1;
    NSMutableArray *titleLabelArr2;
    NSMutableArray *contextLabelArr2;
}
@end

@implementation DCDBriefTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)addTypeFish
{
    NSMutableArray *labelArr = [[NSMutableArray alloc]initWithCapacity:0];
    int row = (int)_arr.count/5+((_arr.count%5==0)?0:1);
    NSLog(@"%s,%@",__func__, labelArr);
    [self.bgFishTypeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fishTypeLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.titleNoteLabel.mas_top).offset(5);
        make.left.equalTo(self.fishTypeLabel.mas_left);
        make.height.equalTo(@(20+40*row));
        make.width.equalTo(@(40*2+10));
    }];
    for(int i=0;i<_arr.count;i++)
    {
        row = (int)i/5;
        int colu = i%5;
        UILabel *label = [FViewCreateFactory createLabelWithName:[_arr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        [self.bgFishTypeView addSubview:label];
        label.layer.borderWidth=0.5;
        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [labelArr addObject:label];
        label.frame =CGRectMake(40*colu+10*colu, 10+40*row, 40, 21);
    }
    
   
    
}
-(void)addCharView{
    NSArray *titleArr = [NSArray arrayWithObjects:@"总面积",@"钓位数",@"平均水深", nil];
    titleLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i =0;i<3;i++)
    {
        UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        [self.bgCharView addSubview:label];
        label.layer.borderWidth=0.5;
        label.backgroundColor= [UIColor groupTableViewBackgroundColor];
        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [titleLabelArr1 addObject:label];
    }
    contextLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    UILabel *label = [FViewCreateFactory createLabelWithName:@"3亩" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    label.layer.borderWidth=0.5;
    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr1 addObject:label];
    label = [FViewCreateFactory createLabelWithName:@"105个" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    label.layer.borderWidth=0.5;
    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr1 addObject:label];
    label = [FViewCreateFactory createLabelWithName:@"1.8米" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    label.layer.borderWidth=0.5;
    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr1 addObject:label];
    
    float width = SCREEN_WIDTH - 20;
    
    titleArr = [NSArray arrayWithObjects:@"池塘数",@"钓位间距",@"限杆长度", nil];
    titleLabelArr2 = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i =0;i<3;i++)
    {
        UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        [self.bgCharView addSubview:label];
        label.layer.borderWidth=0.5;
        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [titleLabelArr2 addObject:label];
        label.backgroundColor= [UIColor groupTableViewBackgroundColor];
    }
    contextLabelArr2 = [[NSMutableArray alloc]initWithCapacity:0];
    label = [FViewCreateFactory createLabelWithName:@"2个" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    label.layer.borderWidth=0.5;
    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr2 addObject:label];
    label = [FViewCreateFactory createLabelWithName:@"1.8米" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [self.bgCharView addSubview:label];
    label.layer.borderWidth=0.5;
    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [contextLabelArr2 addObject:label];
    label = [FViewCreateFactory createLabelWithName:@"4.5米" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    label.layer.borderWidth=0.5;
    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr2 addObject:label];
    
    
    [titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:40 leadSpacing:0 tailSpacing:0];
    [titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.bgCharView.mas_left);
        make.width.equalTo(@(width/4));
    }];
    [contextLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:40 leadSpacing:0 tailSpacing:0];
    [contextLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){        make.left.equalTo(self.bgCharView.mas_left).offset(width/4);
        make.width.equalTo(@(width/4));
    }];
    [titleLabelArr2 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:40 leadSpacing:0 tailSpacing:0];
    [titleLabelArr2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.bgCharView.mas_left).offset(width/2);
        make.width.equalTo(@(width/4));
    }];
    [contextLabelArr2 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:40 leadSpacing:0 tailSpacing:0];
    [contextLabelArr2 mas_makeConstraints:^(MASConstraintMaker *make){        make.left.equalTo(self.bgCharView.mas_left).offset(width*3/4);
        make.width.equalTo(@(width/4));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sendFishGet:(id)sender {
}
@end
