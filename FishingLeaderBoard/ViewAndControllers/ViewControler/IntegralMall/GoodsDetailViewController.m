//
//  GoodsDetailViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailContent;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavViewWithTitle:@"商品详情" isShowBack:YES];
    
 }

- (IBAction)toExchangeAction:(id)sender {
    
    PersonCountView *pcV= [[[NSBundle mainBundle]loadNibNamed:@"PersonCountView" owner:self options:nil]firstObject];
    [self.view addSubview:pcV];
    pcV.titleLabel.text = @"请选择兑换商品数量";
    pcV.detailLabel.text = @"您共需支付2000积分";
    [pcV.payBtn setTitle:@"确定" forState:UIControlStateNormal];
     pcV.toPageType = ToConfirmGoodsOrderPageType;
    [pcV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.view.mas_left);
           make.right.equalTo(self.view.mas_right);
           make.top.equalTo(self.view.mas_top);
           make.bottom.equalTo(self.view.mas_bottom);
       }];
    
}



@end
