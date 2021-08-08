//
//  SellerConfirmViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SellerConfirmViewController.h"
#import "CurrencyOrder.h"
@interface SellerConfirmViewController ()
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

@property (weak, nonatomic) IBOutlet UILabel *spotNameView;

///自提留言
@property (weak, nonatomic) IBOutlet UILabel *remarkView;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusView;

@end

@implementation SellerConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"扫码提货" isShowBack:YES];
    [self fetch];
  
}
-(void)fetch{
    @weakify(self)
      [[ApiFetch share] goodsGetFetch:BUSSINESS_DETAIL_EXCHANGE
                                query:@{
                                    @"code":self.code
                                } holder:self
                            dataModel:CurrencyOrderItem.class
                            onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
          [weak_self bindValue:modelValue];
      }];
}
-(void)bindValue:(CurrencyOrderItem *) orderItem{
    if (orderItem.orderStatus != OrderStatusReady) {
        self.sellerSubmitView.hidden = YES;
    }
    switch (orderItem.orderStatus) {
        case OrderStatusReady:
            self.orderStatusView.text = @"待提货";
            break;
            case OrderStatusFinished:
           self.orderStatusView.text =  @"已提货";
            break;
             
        default:
            self.orderStatusView.text =  @"Unknown";
            break;
    }
    self.exchangeTotalView.text = @(orderItem.number).description;
    self.scoreView.text = [NSString stringWithFormat:@"%ld积分",orderItem.totalCurrency];
    self.selectSku.text = orderItem.selectSku;
    self.exchangeTimeView.text = [ToolClass dateToString1:orderItem.orderTime];
    IMAGE_LOAD(self.coverImgView, orderItem.coverImg)
    self.exchageUserView.text = orderItem.userName;
    self.goodsNameView.text = orderItem.goodsName;
    self.remarkView.text = orderItem.remark;
}
///确认提货
- (IBAction)confirmExchange:(id)sender {
    @weakify(self)
    [[ApiFetch share] goodsGetFetch:BUSSINESS_DETAIL_EXCHANGE
                              query:@{
                                  @"code":self.code
                              } holder:self
                          dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        [weak_self fetch];
        
    }];
}

@end
