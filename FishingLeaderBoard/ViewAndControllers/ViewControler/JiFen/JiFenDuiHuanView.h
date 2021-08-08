//
//  JiFenDuiHuanView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JiFenDuiHuanView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgjiFenLabelView;

@property (weak, nonatomic) IBOutlet UILabel *jiFenLabel;
@property (weak, nonatomic) IBOutlet UIView *bgLunBoView;
@property (weak, nonatomic) IBOutlet UILabel *yiQianDaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *quQianDaoButton;
@property (weak, nonatomic) IBOutlet UIView *bgQianDaoView;
@property (weak, nonatomic) IBOutlet UIImageView *jifenChouJIangImageView;
@property (weak, nonatomic) IBOutlet UIImageView *jiFenShangChengImageView;

@property (weak, nonatomic) IBOutlet UIImageView *saiShiBaoMingView;

@property (weak, nonatomic) IBOutlet UIImageView *diaoJiKeTangImageView;
- (IBAction)toIntegallLottery:(id)sender;
- (IBAction)toIntegallMall:(id)sender;

- (IBAction)toEnrollGame:(id)sender;

- (IBAction)toFishClass:(id)sender;


@end

NS_ASSUME_NONNULL_END
