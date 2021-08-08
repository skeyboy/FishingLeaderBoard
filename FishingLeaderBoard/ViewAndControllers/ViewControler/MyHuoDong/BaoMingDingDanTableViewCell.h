//
//  BaoMingDingDanTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaoMingDingDanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *zuoWeiLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;





@end

NS_ASSUME_NONNULL_END
