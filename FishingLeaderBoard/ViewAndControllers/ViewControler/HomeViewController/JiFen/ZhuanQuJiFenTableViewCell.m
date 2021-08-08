//
//  ZhuanQuJiFenTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/9.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ZhuanQuJiFenTableViewCell.h"

@implementation ZhuanQuJiFenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.quRenButton.layer.borderColor = NAVBGCOLOR.CGColor;
    self.quRenButton.layer.borderWidth = 2;
    self.quRenButton.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
