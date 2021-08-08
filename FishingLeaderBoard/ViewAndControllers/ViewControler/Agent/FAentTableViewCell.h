//
//  FAentTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *gameTitleView;
@property (weak, nonatomic) IBOutlet UILabel *gameStartTimeView;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusView;

@end

NS_ASSUME_NONNULL_END
