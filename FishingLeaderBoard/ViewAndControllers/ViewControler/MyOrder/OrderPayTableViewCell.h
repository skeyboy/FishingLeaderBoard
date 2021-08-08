//
//  OrderPayTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class  OrderApplyGame;
@interface OrderPayTableViewCell : UITableViewCell
-(void)bind:(OrderApplyGame*)or;
-(void)bindForGoods:(GoodsOrderListItem*)gdOr;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *zuoWeiNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *zuiWeiBiaoQianLabel;


@end

NS_ASSUME_NONNULL_END
