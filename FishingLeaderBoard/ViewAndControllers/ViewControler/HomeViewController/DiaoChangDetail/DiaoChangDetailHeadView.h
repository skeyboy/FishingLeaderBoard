//
//  DiaoChangHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailPingJiaViewController.h"
#import "TwoLabel.h"
@class SpotInfo;
NS_ASSUME_NONNULL_BEGIN

@interface DiaoChangDetailHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgLunBoTuImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgStarImageView;

@property (weak, nonatomic) IBOutlet UILabel *right0Label;
@property (weak, nonatomic) IBOutlet UILabel *right1Label;

@property (weak, nonatomic) IBOutlet UILabel *right2Label;


@property (weak, nonatomic) IBOutlet UILabel *right3Label;

@property (weak, nonatomic) IBOutlet UILabel *bgActLabel;
@property (weak, nonatomic) IBOutlet UILabel *bgBaoMingLabel;


@property (weak, nonatomic) IBOutlet UILabel *bgGuanzhuLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) IBOutlet UIButton *callBtn;


@property (weak, nonatomic) IBOutlet UIImageView *bgChooseCardView;

@property (strong,nonatomic)GRStarsView*starsView;
@property (strong,nonatomic)TwoLabel *actLabel;
@property (strong,nonatomic)TwoLabel *baoMingLabel;
@property (strong,nonatomic)TwoLabel *guanZhuLabel;
- (IBAction)phoneClick:(id)sender;
- (IBAction)locationClick:(id)sender;

-(void)addAllViewDelegate:(id)de;
-(void)bindDataToView:(SpotInfo *)spotInfo;

- (IBAction)faBuPingJiaAction:(id)sender;

- (IBAction)pingJiaDetailAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
