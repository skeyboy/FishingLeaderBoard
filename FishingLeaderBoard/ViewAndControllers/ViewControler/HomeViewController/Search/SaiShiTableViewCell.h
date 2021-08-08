//
//  SaiShiTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventGameDetail;
NS_ASSUME_NONNULL_BEGIN

@interface SaiShiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet ColorLabel *firstLabel;
@property (weak, nonatomic) IBOutlet ColorLabel *twoLabel;
@property (weak, nonatomic) IBOutlet ColorLabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

-(void)bind:(EventGameDetail *)eventGameDetail;

@end

NS_ASSUME_NONNULL_END
