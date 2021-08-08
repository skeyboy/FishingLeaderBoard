//
//  IntegralMallHeaderView.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "IntegralMallHeaderView.h"
#import "GoodsOrderListViewController.h"
#import "FishingLeaderBoard-Swift.h"

@implementation IntegralMallHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgHeadView.backgroundColor= CLEARCOLOR;
    self.recodeBtn.layer.borderColor = WHITECOLOR.CGColor;
    self.recodeBtn.layer.cornerRadius = 15;
    self.recodeBtn.layer.borderWidth = 1;
}

- (IBAction)recoderClick:(id)sender {
    GoodsOrderListViewController*vc = [[GoodsOrderListViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
- (IBAction)integrailHistoryScan:(id)sender {
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = REWARDSCORE_SCORELOG;
    [self.viewController.navigationController pushViewController:h5Vc animated:YES];
}
@end
