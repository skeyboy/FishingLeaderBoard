//
//  AddDiaoKengTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/6.
//  Copyright © 2020 yue. All rights reserved.
//

#import "AddDiaoKengTableViewCell.h"

@implementation AddDiaoKengTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgCharView removeAllSubviews];
    self.bgView.layer.cornerRadius = 5;
    NSArray *titleArr = [NSArray arrayWithObjects:@"面积",@"钓位数",@"钓位间距",@"平均水深",@"限杆长度", nil];
    self.titleLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i =0;i<5;i++)
    {
        UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
        [self.bgCharView addSubview:label];
        label.backgroundColor= [UIColor groupTableViewBackgroundColor];
        [self.titleLabelArr1 addObject:label];
    }
   self.contextLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    UILabel *label = [FViewCreateFactory createLabelWithName:@"0亩" font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
    [self.bgCharView addSubview:label];
    [self.contextLabelArr1 addObject:label];
    self.mianjiLabel = label;
    label = [FViewCreateFactory createLabelWithName:@"0个" font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
    [self.bgCharView addSubview:label];
    [self.contextLabelArr1 addObject:label];
    self.diaoweishuLabel = label;
    label = [FViewCreateFactory createLabelWithName:@"0米" font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
    [self.bgCharView addSubview:label];
    [self.contextLabelArr1 addObject:label];
    self.diaoweijianjuLabel = label;
    label = [FViewCreateFactory createLabelWithName:@"0米" font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
     [self.bgCharView addSubview:label];
     [self.contextLabelArr1 addObject:label];
     self.pingjunshuishenLabel = label;
    label = [FViewCreateFactory createLabelWithName:@"0米" font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
        [self.bgCharView addSubview:label];
        [self.contextLabelArr1 addObject:label];
        self.xianganchangduLabel = label;
    float width = (SCREEN_WIDTH-40-20)/5.0;
    [self.titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:width leadSpacing:0 tailSpacing:0];
     [self.titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
         make.top.equalTo(self.bgCharView.mas_top);
         make.height.equalTo(@(40));
     }];
     [self.contextLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:width leadSpacing:0 tailSpacing:0];
     [self.contextLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){        make.top.equalTo(self.bgCharView.mas_top).offset(40);
         make.height.equalTo(@(40));
     }];
}
-(void)bindData:(SpotPondInfo *)spotInfo
{
    if(spotInfo == nil)
    {
        return;
    }
    self.nameLabel.text = spotInfo.name;
    self.mianjiLabel.text = [NSString stringWithFormat:@"%.1f亩",spotInfo.waterSquare];
    self.diaoweishuLabel.text = [NSString stringWithFormat:@"%ld个",spotInfo.spotCount];
    self.diaoweijianjuLabel.text = [NSString stringWithFormat:@"%.1lf米",spotInfo.spotDistance];
    self.pingjunshuishenLabel.text = [NSString stringWithFormat:@"%.1lf米",spotInfo.waterDepth];
    self.xianganchangduLabel.text = [NSString stringWithFormat:@"%.1lf米",spotInfo.rodLong];
   
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteBtnClick:(id)sender {
    self.deleteBtnClick();
}
@end
