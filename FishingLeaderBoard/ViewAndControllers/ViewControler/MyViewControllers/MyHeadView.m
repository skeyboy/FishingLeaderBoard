//
//  MyHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyHeadView.h"
@interface MyHeadView()
{
    FViewController *vcCtr;
}
@end
@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame vc:(FViewController *)vc
{
    self = [super initWithFrame:frame];
    if(self)
    {
        vcCtr = vc;
        [self initView];
    }
    return self;
}
-(void)initView
{
    self.backgroundColor = WHITECOLOR;
    self.topView = [FViewCreateFactory createViewWithBgColor:NAVBGCOLOR];
    [self addSubview:_topView];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserInfo)];
    [self.topView addGestureRecognizer:tap];
    self.userNameLabel = [FViewCreateFactory createLabelWithName:@"用户-再无用户名" font:FONT_2 textColor:WHITECOLOR];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.userNameLabel];
    
    self.idLabel = [FViewCreateFactory createLabelWithName:@"ID：再无ID" font:FONT_3 textColor:WHITECOLOR];
    self.idLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.idLabel];
    
    self.costomLabel = [FViewCreateFactory createLabelWithName:@"个性签名：暂无签名斤斤计较军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军" font:FONT_3 textColor:WHITECOLOR];
    self.costomLabel.numberOfLines = 0;
    self.costomLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.costomLabel];
    
    self.iconButton = [FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(tapUserInfo) tag:0];
    [self.iconButton setImage:[UIImage imageNamed:@"user_my"] forState:UIControlStateNormal];
    
    [self.iconButton.imageView setContentMode:UIViewContentModeCenter];
    [self addSubview:self.iconButton];
    
    self.rightButton = [FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(tapUserInfo) tag:0];
    [self.rightButton setImage:[UIImage imageNamed:@"rightInto_w"] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(@(Height_StatusBar +110));
    }];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topView.mas_left).mas_offset(90);
        make.right.mas_equalTo(self.topView.mas_right).mas_offset(-40);
        make.top.mas_equalTo(self.topView.mas_top).mas_offset(Height_StatusBar+20);
            make.height.mas_equalTo(@30);
    }];
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.userNameLabel.mas_right);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom);
        make.height.mas_equalTo(@20);
    }];
    [self.costomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.userNameLabel.mas_right);
        make.top.mas_equalTo(self.idLabel.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topView.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(self.idLabel.mas_centerY);
        make.height.mas_equalTo(@80);
        make.width.mas_equalTo(@80);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topView.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.idLabel.mas_centerY);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@20);
    }];
    
    
    
    //关注和粉丝
    self.guanZhuLabel = [[TwoLabel alloc]init];
    [self addSubview:self.guanZhuLabel];
    self.fenSiLabel = [[TwoLabel alloc]init];
    [self addSubview:self.fenSiLabel];
    
    self.qianDaoLabel = [FViewCreateFactory createLabelWithName:@"签到领取积分" font:FONT_3_bold textColor:WHITECOLOR];
    self.qianDaoLabel.backgroundColor = NAVBGCOLOR;
    [self addSubview:self.qianDaoLabel];
    float space = (SCREEN_WIDTH - 80 - 80 - 90)/4.0;
    [self.guanZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(20);
             make.height.mas_equalTo(@40);
        make.left.mas_equalTo(self.mas_left).mas_offset(space);
            make.width.mas_equalTo(@80);
    }];
    [self.fenSiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.guanZhuLabel.mas_centerY);
        make.height.mas_equalTo(@40);
        make.left.mas_equalTo(self.guanZhuLabel.mas_right).mas_offset(space);
        make.width.mas_equalTo(@80);
    }];
    [self.qianDaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.guanZhuLabel.mas_centerY);
        make.height.mas_equalTo(@30);
        make.left.mas_equalTo(self.fenSiLabel.mas_right).mas_offset(space);
        make.width.mas_equalTo(@90);
    }];
   
    
    
}
-(void)tapUserInfo
{
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
    [vcCtr.navigationController pushViewController:vc animated:NO];
}
@end
