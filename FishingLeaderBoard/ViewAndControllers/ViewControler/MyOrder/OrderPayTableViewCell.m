//
//  OrderPayTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "OrderPayTableViewCell.h"

@implementation OrderPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bind:(OrderApplyGame*)or
{
    //金额，名称拼接
    self.nameLabel.text = or.eventName;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@:%@元",((or.status==1)?@"待付款":@"实付款"),or.tranAmount];
    self.orderLabel.text = [NSString stringWithFormat:@"订单号:%@",or.applicationCode];
    IMAGE_LOAD(self.iconImageView,or.icon);
    if(or.status == 1)
    {
        self.zuoWeiNumberLabel.hidden =YES;
        self.zuiWeiBiaoQianLabel.hidden = YES;
    }else{
    self.zuoWeiNumberLabel.text = ([or.seatNumber isEqualToString:@""])?@"未分配座位号":or.seatNumber;
    }
}
-(void)bindForGoods:(GoodsOrderListItem*)gdOr
{
    self.nameLabel.text = gdOr.goodsName;
    self.guigeLabel.hidden = NO;
    self.guigeLabel.text = gdOr.selectSku;
    self.moneyLabel.text =[NSString stringWithFormat:@"%@:%@积分",((gdOr.status==1)?@"待付款":@"实付款"),gdOr.currency];
    self.orderLabel.text = [NSString stringWithFormat:@"订单号:%@",gdOr.code];
    IMAGE_LOAD(self.iconImageView,gdOr.coverImg)
    self.zuoWeiNumberLabel.hidden =YES;
    self.zuiWeiBiaoQianLabel.hidden = YES;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
