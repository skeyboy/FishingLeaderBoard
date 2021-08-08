//
//  SaiShiShenPiViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/26.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaiShiShenPiViewController : FViewController

@property (weak, nonatomic) IBOutlet UIView *bgDaiShenPiView;
@property (weak, nonatomic) IBOutlet UIButton *tongguoBtn;
@property (weak, nonatomic) IBOutlet UIView *bgTongGuoView;

@property (weak, nonatomic) IBOutlet LPButton *butongguoBtn;

- (IBAction)tongguoClick:(id)sender;
- (IBAction)butongguoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UILabel *wuneirongLabel;

@end

NS_ASSUME_NONNULL_END
