//
//  MySectionHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/3/23.
//  Copyright © 2020 yue. All rights reserved.
//

#import "MySectionHeadView.h"
#import "WalletViewController.h"
@implementation MySectionHeadView

- (instancetype)init {
    
    self = [super init];
    self = [[[NSBundle mainBundle] loadNibNamed:@"MySectionHeadView" owner:self options:nil] lastObject];
    if (self) {
        UITapGestureRecognizer *tap = [[ UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [self toWallet];
        }];
        [self.qiaoBaoImageView addGestureRecognizer:tap];
        tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [self myVoucher];
        }];
        [self.daijinquanImageView addGestureRecognizer:tap];
    }
    return self;
}

- (IBAction)toQianBao:(id)sender {
    [self toWallet];
}

- (IBAction)toDaiJinQuan:(id)sender {
    [self myVoucher];
}
-(void)toWallet
{
         WalletViewController *walletVc = [[WalletViewController alloc] init];
         walletVc.hidesBottomBarWhenPushed = YES;
         walletVc.vc = self.viewController;
         [self.viewController.navigationController pushViewController:walletVc
                                              animated:YES];
}
-(void)myVoucher
{
    [self.viewController showDefaultInfo:@"暂未开通，敬请期待"];
}
@end
