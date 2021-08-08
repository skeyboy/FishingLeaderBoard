//
//  FAentTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FAentTableViewCell.h"

@implementation FAentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgview.layer.cornerRadius = 5;
    self.bgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bgview.layer.borderWidth = 1;
    self.bgview.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
