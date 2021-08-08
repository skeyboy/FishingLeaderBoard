//
//  ZhangMuGuanLiTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/28.
//  Copyright © 2020 yue. All rights reserved.
//

#import "ZhangMuGuanLiTableViewCell.h"
#import "AgentBill.h"
@implementation ZhangMuGuanLiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindBill:(AgentBill *)bill{
    self.biaoqianLabel.text = [bill typeInfo];
    self.nameLabel.text = bill.name;
    self.timeLabel.text = [bill.createTime description];
    self.moneyLabel.text = @(bill.money).description;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
