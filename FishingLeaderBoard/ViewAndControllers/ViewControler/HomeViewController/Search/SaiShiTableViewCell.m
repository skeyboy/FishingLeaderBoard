//
//  SaiShiTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SaiShiTableViewCell.h"

@implementation SaiShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bind:(EventGameDetail *)eventGameDetail
{
//    @property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
//    @property (weak, nonatomic) IBOutlet UILabel *firstLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *twoLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
    IMAGE_LOAD(self.bgImageView, eventGameDetail.coverImage);
    self.twoLabel.text = (eventGameDetail.type == 1)?@"活动":@"赛事";
    self.firstLabel.text = (eventGameDetail.eventTimes == 1)?@"日场":@"夜场";
    self.thirdLabel.text = (eventGameDetail.isPast ==0)?@"报名中":@"已过期";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
