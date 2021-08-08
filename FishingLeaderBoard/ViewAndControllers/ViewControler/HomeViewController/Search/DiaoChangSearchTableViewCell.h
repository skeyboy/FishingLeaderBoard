//
//  DiaoChangSearchTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRStarsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DiaoChangSearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *starBaseView;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong,nonatomic)GRStarsView *starsView;

@property (weak, nonatomic) IBOutlet ColorLabel *renZhengLabel;


@end

NS_ASSUME_NONNULL_END
