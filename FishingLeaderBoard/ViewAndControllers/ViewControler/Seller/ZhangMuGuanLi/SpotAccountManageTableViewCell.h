//
//  SpotAccountManageTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotAccountManageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *saishiTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *baomingrenshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *yupiaoshouruLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouyuzhichuLabel;
@property (weak, nonatomic) IBOutlet UILabel *cunyushouruLabel;
@property (weak, nonatomic) IBOutlet UILabel *gengxinTimeLabel;
-(void)bindData:(OrderEventListItem*)listsItem;
@end

NS_ASSUME_NONNULL_END
