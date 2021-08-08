//
//  MyHDFaQiTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyHDFaQiTableViewCell.h"

@implementation MyHDFaQiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgImageView.layer.borderWidth = 1;
    self.bgImageView.layer.borderColor = WHITEGRAY.CGColor;
    self.bgImageView.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
