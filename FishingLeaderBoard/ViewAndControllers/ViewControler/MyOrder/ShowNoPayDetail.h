//
//  ShowNoPayDetail.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowNoPayDetail : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *actNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *spotNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *enrollTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *enrollNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;

- (IBAction)WXPay:(id)sender;

- (IBAction)zhifubaoPay:(id)sender;

- (IBAction)walletPay:(id)sender;

- (IBAction)deleteOrder:(id)sender;

@end

NS_ASSUME_NONNULL_END
