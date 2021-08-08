//
//  HomeNewHeadTableView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSegmentTitleView.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^FSSegment) (int,int);
//typedef void(^ButtonCtrolClick) (UIButton *);

@interface HomeNewHeadTableView : UIView<FSSegmentTitleViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgWearthView;

@property (weak, nonatomic) IBOutlet UILabel *wCenterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wLeft1Label;
@property (weak, nonatomic) IBOutlet UILabel *wNewLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *cainixihuanLabel;

@property (weak, nonatomic) IBOutlet UILabel *wLeft2Label;

@property (weak, nonatomic) IBOutlet UILabel *wRight1Label;

@property (weak, nonatomic) IBOutlet UILabel *wRight2Label;

@property (weak, nonatomic) IBOutlet UIImageView *bgLunBoView;

@property (weak, nonatomic) IBOutlet UILabel *xiaoXiLabel;
@property (weak, nonatomic) IBOutlet UIView *grvidView;

@property (weak, nonatomic) IBOutlet UILabel *bgTabLabel;
@property (weak, nonatomic) IBOutlet UIImageView *saiShiBaoMingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *jiFenShangChengImageView;

@property (weak, nonatomic) IBOutlet UIImageView *woYaoMaiYuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pinPaiSaiShiImageView;

@property (nonatomic, copy) FSSegment   segmentCtrlClick;
//@property (nonatomic, copy) ButtonCtrolClick     btnCtrlClick;



@property (weak, nonatomic) IBOutlet UILabel *userNameView;
@property (weak, nonatomic) IBOutlet UILabel *jifenView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

//🏆
@property (weak, nonatomic) IBOutlet UIImageView *cupView;
-(void)refresh;
@end

//#define HomeNewsHeaderHeight 558//558
//#define HomeNewsBannerHeight 140
@interface HomeNewUserContainerView :UIView

@end

NS_ASSUME_NONNULL_END
