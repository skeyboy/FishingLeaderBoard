//
//  QiDongFaBuSaiShiView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRStarsView.h"
#import "SelectView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QiDongFaBuSaiShiView : UIView

- (IBAction)cancelClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *spotLabel;

@property (weak, nonatomic) IBOutlet UILabel *leixingLabel;

@property (weak, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *saishiLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingjiaBialQianLabel;
@property (weak, nonatomic) IBOutlet UIView *bgStarView;
@property (weak, nonatomic) IBOutlet UILabel *pingjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhishaoxuanzheyigeLabel;

@property (weak, nonatomic) IBOutlet UIView *bgBiaoQianView;
- (IBAction)tijiaoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tijiaoButton;

@property (strong,nonatomic)GRStarsView*starsView;
@property (strong,nonatomic)SelectView *slView;

@end

NS_ASSUME_NONNULL_END
