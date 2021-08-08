//
//  DiaoChangSearchTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangSearchTableViewCell.h"

@implementation DiaoChangSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(18, 18) margin:0 numberOfStars:5];
    self.starsView.frame = CGRectMake(0, 0, self.starBaseView.frame.size.width, self.starBaseView.frame.size.height);
    [self.starBaseView addSubview:self.starsView];
    self.starsView.allowSelect = YES;  // 默认可点击
    self.starsView.allowDecimal = YES;  //默认可显示小数
    self.starsView.allowDragSelect = NO;//默认不可拖动评分，可拖动下需可点击才有效
    self.starsView.score = 0;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
