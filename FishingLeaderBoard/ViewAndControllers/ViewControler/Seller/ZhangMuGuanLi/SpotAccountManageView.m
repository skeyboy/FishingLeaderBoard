//
//  SpotAccountManageView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/17.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SpotAccountManageView.h"

@implementation SpotAccountManageView

- (IBAction)infoZongShouRu:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"总收入=时间段内赛事和活动收益的总金额" preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction *sure = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     }];
     [alert addAction:sure];
     [self.viewController presentViewController:alert animated:YES completion:^{
         
     }];
}

- (IBAction)infoZongZhiChu:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"总支出=时间段内赛事和活动支出的总金额" preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction *sure = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     }];
     [alert addAction:sure];
     [self.viewController presentViewController:alert animated:YES completion:^{
         
     }];
}

@end
