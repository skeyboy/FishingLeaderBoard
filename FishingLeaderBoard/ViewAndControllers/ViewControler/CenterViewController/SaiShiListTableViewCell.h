//
//  SaiShiListTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/23.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorLabel.h"
@class EventSpotGameItem;
NS_ASSUME_NONNULL_BEGIN

@interface SaiShiListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ColorLabel *colorLabel1;

@property (weak, nonatomic) IBOutlet ColorLabel *colorLabel2;

@property (weak, nonatomic) IBOutlet ColorLabel *colorLabel3;
@property (weak, nonatomic) IBOutlet UILabel *shangXianLabel;

@property (weak, nonatomic) IBOutlet UILabel *feiYongLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jifensaishiLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

-(void)bindValue:(EventSpotGameItem*)gameItem;
@end

NS_ASSUME_NONNULL_END
