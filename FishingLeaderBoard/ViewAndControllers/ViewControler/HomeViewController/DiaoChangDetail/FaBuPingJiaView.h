//
//  FaBuPingJiaView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/12.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectView.h"
#import "GRStarsView.h"
NS_ASSUME_NONNULL_BEGIN
@interface FaBuPingJiaView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgStarView;

@property (weak, nonatomic) IBOutlet UILabel *pingjiaLeftLabel;

@property (weak, nonatomic) IBOutlet UILabel *pingjiabiaoqianLeftLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *starLabel;

- (IBAction)cancelAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bgBiaoQianView;

- (IBAction)tijiaoAction:(id)sender;


@property (strong,nonatomic)GRStarsView*starsView;
@property (strong,nonatomic)SelectView *slView;
@end

NS_ASSUME_NONNULL_END
