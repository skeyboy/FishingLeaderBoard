//
//  ZhangMuGuanLiTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/28.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AgentBill;
NS_ASSUME_NONNULL_BEGIN

@interface ZhangMuGuanLiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaoqianLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
-(void)bindBill:(AgentBill *) bill;

@end

NS_ASSUME_NONNULL_END
