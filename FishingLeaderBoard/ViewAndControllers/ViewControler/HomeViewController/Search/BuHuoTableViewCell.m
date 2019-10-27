//
//  BuHuoTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BuHuoTableViewCell.h"

@implementation BuHuoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.button1.layer.borderColor = WHITEGRAY.CGColor;
    self.button2.layer.borderColor = WHITEGRAY.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btn1Click:(id)sender {
    UIButton *btn =sender;
    NSInteger tag = btn.tag-900;
    NSLog(@"行=%ld，列=%ld",tag/2,tag%2);
    
}

@end
