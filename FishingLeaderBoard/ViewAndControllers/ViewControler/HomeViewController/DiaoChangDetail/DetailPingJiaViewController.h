//
//  DetailPingJiaViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/12.
//  Copyright © 2020 yue. All rights reserved.
//

#import "FViewController.h"
#import "FaBuPingJiaView.h"
#import "GRStarsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailPingJiaViewController : FViewController
@property (weak, nonatomic) IBOutlet UIImageView *fengMianImageView;
@property (weak, nonatomic) IBOutlet UIView *bgStarView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *renShuLabel;

@property (strong,nonatomic)GRStarsView*starsView;
@property (strong,nonatomic)SelectView *slView;

@property (weak, nonatomic) IBOutlet UIView *bgBiaoQianView;
- (IBAction)woyaodianpingAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
