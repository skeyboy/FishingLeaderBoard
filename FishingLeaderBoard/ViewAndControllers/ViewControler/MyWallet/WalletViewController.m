//
//  WalletViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "WalletViewController.h"
#import "MaiYuViewController.h"
#import "ReChargeViewController.h"
#import "CashOutViewController.h"
@interface WalletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *accountTotalView;
@property (weak, nonatomic) IBOutlet UILabel *dongJieAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *keYongAccountLabel;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"" isShowBack:NO];
//    [hkNavigationView setNavBarViewRightBtnWithName:@"账单明细" target:self action:@selector(zhangdanmingxi:)];
      [hkNavigationView setNavLineHidden];
    self.bgAccountView.backgroundColor = NAVBGCOLOR;
    self.chongZhiBtn.backgroundColor = NAVBGCOLOR;
    [self.tixianBtn setTitleColor:NAVBGCOLOR forState:UIControlStateNormal];
     [hkNavigationView setNavBarViewLeftBtnWithTitle:@"钱包"
                                         normalImage:@"nav_back_nor"
                                    highlightedImage:@"nav_back_nor"
                                           titleFont:17
                                              target:self
                                              action:nil];
        
    [hkNavigationView setNavBarViewRightBtnWithTitle:@"账单明细"
                                         normalImage:@""
                                    highlightedImage:@""
                                           titleFont:17
                                              target:self
                                              action:@selector(zhangdanmingxi:)];
    [self getData];
}
-(void)getData
{
    @weakify(self)
    [[ApiFetch share]orderPostFetch:ORDER_ACCOUNT body:@{} holder:self dataModel:UserAccount.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        UserAccount* userAccount =(UserAccount*)modelValue;
        weak_self.accountTotalView.text = [NSString stringWithFormat:@"%.2f",userAccount.totalAmount];
        weak_self.dongJieAccountLabel.text =  [NSString stringWithFormat:@"%.2f",userAccount.frozenAmount];
        weak_self.keYongAccountLabel.text = [NSString stringWithFormat:@"%.2f",userAccount.amount];
        if ([self.vc respondsToSelector:@selector(frashData)]) {
            [self.vc performSelector:@selector(frashData)];//我的页面
        }
    }];
}

-(void)zhangdanmingxi:(UIButton*)btn
{
    H5ArticalDetailViewController *h5Vc  = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = MINE_BILL_DETAILS;
    [self.navigationController pushViewController:h5Vc
                                         animated:YES];
}
//提现
- (IBAction)crashOutAction:(id)sender {
    CashOutViewController *cashOutVc = [[CashOutViewController alloc] init];
    [self.navigationController pushViewController:cashOutVc
                                         animated:YES];
}
//充值
- (IBAction)toReCharge:(id)sender {
    ReChargeViewController *reChareVc = [[ReChargeViewController alloc] init];
    reChareVc.vc = self;
    [self.navigationController pushViewController:reChareVc animated:YES];
}

- (IBAction)showMaiYuQr:(id)sender {
    MaiYuViewController *maiYuVc = [[MaiYuViewController alloc] init];
    [self.navigationController pushViewController:maiYuVc
                                         animated:YES];
}

@end
