//
//  YaoHaoTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YaoHaoTableViewCell.h"

@implementation YaoHaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.numberLabel.layer.borderColor=NAVBGCOLOR.CGColor;
    self.numberLabel.layer.borderWidth = 1;
    self.headBtn.imageView.layer.cornerRadius = 25;
    self.headBtn.imageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
