//
//  IntegralRankHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRankHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@end

NS_ASSUME_NONNULL_END
