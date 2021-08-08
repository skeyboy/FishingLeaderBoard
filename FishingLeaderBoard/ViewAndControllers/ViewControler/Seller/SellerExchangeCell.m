//
//  SellerExchangeCell.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/16.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SellerExchangeCell.h"
#import "CurrencyOrder.h"
@interface SellerExchangeCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *selectSku;
///兑换数量
@property (weak, nonatomic) IBOutlet UILabel *exchangeTotalView;
///积分数量
@property (weak, nonatomic) IBOutlet UILabel *scoreView;
///兑换人
@property (weak, nonatomic) IBOutlet UILabel *exchageUserView;
///兑换时间
@property (weak, nonatomic) IBOutlet UILabel *exchangeTimeView;
@property (weak, nonatomic) IBOutlet UIButton *sellerSubmitView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameView;

@end
@implementation SellerExchangeCell
- (IBAction)sellerSubmitExchange:(id)sender {
//    [self.viewController makeToask:@"兑换"];
    if (self.sellerExchangeResult) {
        UIAlertController * infoVc = [UIAlertController
                                      alertControllerWithTitle:@""
                                                                         message:@"确认用户已提货"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        @weakify(self)
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
                  weak_self.sellerExchangeResult(weak_self.indexPath);
              }];
              
        [infoVc addAction:cancelAction];
        [infoVc addAction:confirmAction];
        [self.viewController presentViewController:infoVc
                                          animated:YES
                                        completion:^{
            
        }];
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sellerSubmitView.backgroundColor = NAVBGCOLOR;
    self.sellerSubmitView.layer.cornerRadius = 5;

    
}
-(void)setFinished:(BOOL)finished{
    if (finished) {
        [self.sellerSubmitView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.height.equalTo(@(0));
           }];
        self.sellerSubmitView.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindValue:(CurrencyOrderItem *)orderItem{
    self.exchangeTotalView.text = @(orderItem.number).description;
    self.scoreView.text = [NSString stringWithFormat:@"%ld积分",orderItem.totalCurrency];
    self.selectSku.text = orderItem.selectSku;
    self.exchangeTimeView.text = [ToolClass dateToString1:orderItem.orderTime];
    IMAGE_LOAD(self.coverImgView, orderItem.coverImg)
    self.exchageUserView.text = orderItem.userName;
    self.goodsNameView.text = orderItem.goodsName;
}
@end
