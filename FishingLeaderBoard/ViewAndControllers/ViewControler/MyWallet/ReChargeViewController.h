//
//  ReChargeViewController.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReChargeViewController : FViewController
@property(nonatomic,strong)UIViewController *vc;

@property (weak, nonatomic) IBOutlet UIButton *weiXinBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhiFuBaoBtn;
@property (assign,nonatomic)PayType payType;
- (IBAction)weiXinClick:(id)sender;

- (IBAction)zhiFuBaoClick:(id)sender;



@end

NS_ASSUME_NONNULL_END
