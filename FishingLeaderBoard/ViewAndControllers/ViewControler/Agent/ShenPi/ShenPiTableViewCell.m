//
//  ShenPiTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/26.
//  Copyright © 2020 yue. All rights reserved.
//

#import "ShenPiTableViewCell.h"

@implementation ShenPiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)fuxuanBtnClick:(LPButton*)btn {
    self.fuXuanBtnClick(btn);
}
@end
