//
//  SpotAccountManageTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SpotAccountManageTableViewCell.h"

@implementation SpotAccountManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindData:(OrderEventListItem*)listsItem
{
//    @property (weak, nonatomic) IBOutlet UILabel *saishiTimeLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//    @property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
//    @property (weak, nonatomic) IBOutlet UILabel *baomingrenshuLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *yupiaoshouruLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *shouyuzhichuLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *cunyushouruLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *gengxinTimeLabel;
    self.saishiTimeLabel.text= [NSString stringWithFormat:@"%@~%@",[ToolClass dateToString4:listsItem.startTime],[[[ToolClass dateToString4:listsItem.finishTime]componentsSeparatedByString:@" "]objectAtIndex:1]];
    _titleLabel.text = listsItem.eventName;
    IMAGE_LOAD(self.leftImageView, listsItem.coverImage);
    self.baomingrenshuLabel.text = [NSString stringWithFormat:@"报名人数：%ld人",listsItem.count] ;
    self.yupiaoshouruLabel.text=[NSString stringWithFormat:@"鱼票收入：%.2f元",listsItem.yuPiaoShouRu];
    self.shouyuzhichuLabel.text=[NSString stringWithFormat:@"收鱼支出：%.2f元",listsItem.shouYuZhiChu];
    self.cunyushouruLabel.text =[NSString stringWithFormat:@"存鱼收入：%.2f元",listsItem.cunYuShouRu];
    self.gengxinTimeLabel.text =[NSString stringWithFormat:@"%@",[ToolClass dateToString4:listsItem.updateTime]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
