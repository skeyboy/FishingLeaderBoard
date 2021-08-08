//
//  WalletViewController.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WalletViewController : FViewController
@property(nonatomic,strong)UIViewController *vc;
@property (weak, nonatomic) IBOutlet UIView *bgAccountView;
@property (weak, nonatomic) IBOutlet UIButton *chongZhiBtn;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;

@end

NS_ASSUME_NONNULL_END
