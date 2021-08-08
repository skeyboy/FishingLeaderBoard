//
//  IntegralRankTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *chengjiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mingCiImgView;



@end

NS_ASSUME_NONNULL_END
