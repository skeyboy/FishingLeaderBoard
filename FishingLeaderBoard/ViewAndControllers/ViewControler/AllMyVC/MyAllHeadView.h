//
//  MyAllHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAllHeadView : UIView
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UIButton *iconButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *idLabel;
@property(nonatomic,strong)UILabel *costomLabel;
@property(nonatomic,strong)UILabel *dengjiLbael;

@property(nonatomic,strong)UILabel *bCardTypeLabel;
@property(nonatomic,strong)UILabel *bCardNoLabel;
@property(nonatomic,strong)LPButton *brightButton;
@end

NS_ASSUME_NONNULL_END
