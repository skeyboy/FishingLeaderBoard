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
    NSMutableArray *contextLabelArr2;//多组
}
@end

@implementation DCDBriefTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addCharView];
    [self addTypeFish];
}
-(void)addTypeFish
{
    [self.bgFishTypeView removeAllSubviews];
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
    [self.bgCharView removeAllSubviews];
    NSArray *titleArr = [NSArray arrayWithObjects:@"总面积",@"钓坑数", nil];
    titleLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i =0;i<2;i++)
    {
        UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
        [self.bgCharView addSubview:label];
//        label.layer.borderWidth=0.5;
        label.backgroundColor= [UIColor groupTableViewBackgroundColor];
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [titleLabelArr1 addObject:label];
    }
    contextLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    UILabel *label = [FViewCreateFactory createLabelWithName:@"0亩" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
//    label.layer.borderWidth=0.5;
//    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr1 addObject:label];
    self.areaLabel = label;
    label = [FViewCreateFactory createLabelWithName:@"0个" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
//    label.layer.borderWidth=0.5;
//    label.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.bgCharView addSubview:label];
    [contextLabelArr1 addObject:label];
    self.diaokengshuLabel = label;
    [titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((SCREEN_WIDTH-20-10)/2.0) leadSpacing:0 tailSpacing:0];
    [titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.bgCharView.mas_top);
        make.height.equalTo(@(40));
    }];
    [contextLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((SCREEN_WIDTH-20)/2.0) leadSpacing:0 tailSpacing:0];
    [contextLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){        make.top.equalTo(self.bgCharView.mas_top).offset(40);
        make.height.equalTo(@(30));
    }];
}

-(void)bindData:(SpotInfo *)spotInfo
{
    if(spotInfo == nil)
    {
        return;
    }
    self.areaLabel.text = [NSString stringWithFormat:@"%ld亩",spotInfo.waterSquare];
    self.diaokengshuLabel.text = [NSString stringWithFormat:@"%ld个",spotInfo.spotFishponds.count];
    
    if(spotInfo.spotFishponds.count==0)
    {
        self.detailLabel.hidden = YES;
        self.bgDetailCharView.hidden = YES;
        self.bgDetailCharView.backgroundColor = [UIColor redColor];
        [self.bgDetailCharView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
            make.bottom.equalTo(self.fishTypeLabel.mas_top).offset(5);
            make.left.equalTo(self.fishTypeLabel.mas_left);
            make.height.equalTo(@(0));
            make.width.equalTo(@(SCREEN_WIDTH-20));
        }];
    }else{
        self.detailLabel.hidden = NO;
        self.bgDetailCharView.hidden = NO;
        [self addDetailCharView:spotInfo.spotFishponds];
    }
    self.arr =[spotInfo.fishes componentsSeparatedByString:@","];
    [self addTypeFish];
    self.noteLabel.text = spotInfo.content;
    
    
}
-(void)addDetailCharView:(NSArray *)spotFishPonds
{
    [self.bgDetailCharView removeAllSubviews];
    [self.bgDetailCharView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.fishTypeLabel.mas_top).offset(-5);
        make.left.equalTo(self.fishTypeLabel.mas_left);
        make.height.equalTo(@(spotFishPonds.count*40+50));
        make.width.equalTo(@(SCREEN_WIDTH-20));
    }];
    
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"名称",@"面积",@"钓位数",@"钓位间距",@"水深",@"限杆", nil];
    titleLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i =0;i<6;i++)
    {
        UILabel *label = [FViewCreateFactory createLabelWithName:[titleArr objectAtIndex:i] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
        [self.bgDetailCharView addSubview:label];
//        label.layer.borderWidth=0.5;
        label.backgroundColor= [UIColor groupTableViewBackgroundColor];
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [titleLabelArr1 addObject:label];
    }
    [titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((SCREEN_WIDTH-20-20)/6.0) leadSpacing:0 tailSpacing:0];
    [titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.bgDetailCharView.mas_top).offset(5);
        make.height.equalTo(@(50));
    }];
    for(int i =0;i<spotFishPonds.count;i++)
    {
        SpotPondInfo* pondInfo = [spotFishPonds objectAtIndex:i];
        [titleLabelArr1 removeAllObjects];
        UILabel *label = [FViewCreateFactory createLabelWithName:pondInfo.name font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
//        label.layer.borderWidth=0.5;
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.bgDetailCharView addSubview:label];
        [titleLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"%.1f亩",pondInfo.waterSquare] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
//        label.layer.borderWidth=0.5;
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.bgDetailCharView addSubview:label];
        [titleLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"%ld个",pondInfo.spotCount] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
//        label.layer.borderWidth=0.5;
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.bgDetailCharView addSubview:label];
        [titleLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"%.1f米",pondInfo.spotDistance] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
//        label.layer.borderWidth=0.5;
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.bgDetailCharView addSubview:label];
        [titleLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"%.1f米",pondInfo.waterDepth] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
//        label.layer.borderWidth=0.5;
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.bgDetailCharView addSubview:label];
        [titleLabelArr1 addObject:label];
        label = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"%.1f米",pondInfo.rodLong] font:[UIFont systemFontOfSize:12] textColor:BLACKCOLOR];
//        label.layer.borderWidth=0.5;
//        label.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.bgDetailCharView addSubview:label];
        [titleLabelArr1 addObject:label];
          [titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((SCREEN_WIDTH-20-20)/6.0) leadSpacing:0 tailSpacing:0];
          [titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
              make.top.equalTo(self.bgDetailCharView.mas_top).offset(50+i*40);
              make.height.equalTo(@(40));
          }];
    }
    
}
- (IBAction)sendFishGet:(UIButton*)btn {
    self.btnClick(btn);
}
@end
