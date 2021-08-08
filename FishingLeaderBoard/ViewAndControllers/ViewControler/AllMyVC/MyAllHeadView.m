//
//  MyAllHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyAllHeadView.h"

@implementation MyAllHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initView];
    }
    return self;
}
-(void)initView
{
    UserInfo *userInfo = [AppManager manager].userInfo;
//    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.backgroundColor = NAVBGCOLOR;

    self.topView = [FViewCreateFactory createViewWithBgColor:NAVBGCOLOR];
    [self addSubview:_topView];
    self.userNameLabel = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"%@",userInfo.nickName] font:FONT_2 textColor:WHITECOLOR];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.userNameLabel];
    
    self.idLabel = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"ID-%ld",userInfo.id] font:FONT_3 textColor:WHITECOLOR];
    self.idLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.idLabel];
    
    NSString *nickName = [userInfo.sign isEqualToString:@""]?@"暂无":userInfo.sign;
    self.costomLabel = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"个性签名-%@",nickName] font:FONT_3 textColor:WHITECOLOR];
    if(nickName == nil)
    {
        self.costomLabel.text = @"个性签名：暂无签名";
    }
    self.costomLabel.numberOfLines = 0;
    self.costomLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.costomLabel];
    
//     self.dengjiLbael = [FViewCreateFactory createLabelWithName:[NSString stringWithFormat:@"等级：银卡会员"] font:[UIFont boldSystemFontOfSize:14] textColor:WHITECOLOR];
//     self.dengjiLbael.numberOfLines = 0;
//     self.dengjiLbael.font = [UIFont boldSystemFontOfSize:14];
//     self.dengjiLbael.textAlignment = NSTextAlignmentLeft;
//     [self addSubview:self.dengjiLbael];
    
    self.iconButton = [FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(tapUserInfo) tag:0];
//    [self.iconButton setImage:[UIImage imageNamed:@"user_my"] forState:UIControlStateNormal];
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:[AppManager manager].userInfo.headImg]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user_my"]];
    [self.iconButton.imageView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.iconButton];
    self.iconButton.layer.cornerRadius = 40;
    self.iconButton.clipsToBounds = YES;
    
    self.rightButton = [FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(tapUserInfo) tag:0];
    [self.rightButton setImage:[UIImage imageNamed:@"rightInto_w"] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserInfo)];
    [self.userNameLabel addGestureRecognizer:tap];
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserInfo)];
    [self.idLabel addGestureRecognizer:tap];
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserInfo)];
    [self.costomLabel addGestureRecognizer:tap];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
//        make.height.mas_equalTo(@(Height_StatusBar +130));
        make.height.mas_equalTo(@(Height_StatusBar +150));

    }];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topView.mas_left).mas_offset(100);
        make.right.mas_equalTo(self.topView.mas_right).mas_offset(-40);
//       make.top.mas_equalTo(self.topView.mas_top).mas_offset(Height_StatusBar+20);
        make.top.mas_equalTo(self.topView.mas_top).mas_offset(Height_StatusBar+20+30);
            make.height.mas_equalTo(@(30));
    }];
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
//        make.right.mas_equalTo(self.userNameLabel.mas_right);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom);
        make.height.mas_equalTo(@20);
    }];
    [self.costomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.userNameLabel.mas_right);
        make.top.mas_equalTo(self.idLabel.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
//    [self.dengjiLbael mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.idLabel.mas_right).offset(15);
//        make.centerY.mas_equalTo(self.idLabel.mas_centerY);
//        make.height.mas_equalTo(@30);
//    }];
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
    
//    self.bCardTypeLabel = [FViewCreateFactory createLabelWithName:@"当前权益:" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
//    [self addSubview:self.bCardTypeLabel];
//    self.bCardNoLabel = [FViewCreateFactory createLabelWithName:@"1.1倍积分奖励，专属商品兑换" font:[UIFont systemFontOfSize:13] textColor:BLACKCOLOR];
//    [self addSubview:self.bCardNoLabel];
//    self.brightButton = [ToolView btnTitle:@"查看会员权益" image:@"arrow_primary" tag:0 superView:self sel:@selector(huiyuanquanyi) targer:self setStyle:LPButtonStyleRight font:10];
//    [self.brightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.bCardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.iconButton.mas_left);
//        make.bottom.equalTo(self.mas_bottom).offset(-15);
//        make.height.equalTo(@(21));
//    }];
//    [self.bCardNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bCardTypeLabel.mas_right).offset(10);
//               make.bottom.equalTo(self.mas_bottom).offset(-15);
//               make.height.equalTo(@(21));
//    }];
//    [self.brightButton mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.right.equalTo(self.mas_right).offset(-10);
//                      make.height.equalTo(@(30));
//        make.right.width.equalTo(@120);
//        make.centerY.equalTo(self.bCardNoLabel.mas_centerY);
//    }];
    
    
}
-(void)tapUserInfo
{
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.vc = self.viewController;
    [self.viewController.navigationController pushViewController:vc animated:NO];
}
-(void)huiyuanquanyi
{
    //TODO会员权益查看
    [self.viewController makeToask:@"暂无服务"];
}
@end
