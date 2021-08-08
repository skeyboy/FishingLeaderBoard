//
//  SpotAMDetailTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotAMDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@property (weak, nonatomic) IBOutlet UILabel *isZiTianJiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *jinELabel;

@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;

-(void)bindData:(OrderEventAllListItem*)item;
@end

NS_ASSUME_NONNULL_END
