//
//  DiaoChangDetailTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailTableViewCell.h"

@implementation DiaoChangDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bindValue:(EventSpotGameItem *)eventItem{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:eventItem.coverImage] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",eventItem.name];
    self.typeLabel.text = [NSString stringWithFormat:@"类型：%@",eventItem.type==1?@"活动":@"赛事"];
    self.timeLabel.text = [NSString stringWithFormat:@"时间:%@",[ToolClass dateToString:eventItem.startTime]];
   NSArray* arr =@[@"排名赛事",@"抽奖赛事",@"普通活动",@"积分活动"];
       if((eventItem.pattern-1)>=0)
       {
           self.jifensaishiLabel.text = [arr objectAtIndex: eventItem.pattern-1];
           self.jifensaishiLabel.textColor = [UIColor redColor];
           self.jifensaishiLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
       }else{
           self.jifensaishiLabel.text = @"";
           self.jifensaishiLabel.backgroundColor = WHITECOLOR;
       }
}
@end
