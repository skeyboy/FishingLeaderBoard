//
//  MyHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPButton.h"
#import "TwoLabel.h"
#import "UserInfoViewController.h"
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyHeadView : UIView

-(instancetype)initWithFrame:(CGRect)frame vc:(FViewController *)vc;
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UIButton *iconButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *idLabel;
@property(nonatomic,strong)UILabel *costomLabel;

@property(nonatomic,strong)TwoLabel *fenSiLabel;
@property(nonatomic,strong)TwoLabel *guanZhuLabel;

@property(nonatomic,strong)UILabel *qianDaoLabel;


@end

NS_ASSUME_NONNULL_END
