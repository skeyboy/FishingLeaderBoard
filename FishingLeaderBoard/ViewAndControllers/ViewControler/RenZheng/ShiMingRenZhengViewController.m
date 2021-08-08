//
//  ShiMingRenZhengViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ShiMingRenZhengViewController.h"

@interface ShiMingRenZhengViewController ()
{
    GreenLineTextField* nameGreenTF;//姓名
    GreenLineTextField* idNumberGreenTF;//身份证号
}
@end

@implementation ShiMingRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
}

-(void)initPageView
{
    [self setNavViewWithTitle:@"实名认证" isShowBack:YES];
    __weak __typeof(self) weakSelf = self;
    nameGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:nameGreenTF];
    [nameGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hkNavigationView.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    nameGreenTF.leftLabel.text = @"姓名";
    nameGreenTF.enterTextField.placeholder=@"请填写真实姓名";
    idNumberGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:idNumberGreenTF];
    [idNumberGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameGreenTF.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    idNumberGreenTF.leftLabel.text = @"身份证号";
    idNumberGreenTF.enterTextField.placeholder=@"请填写身份证号";
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor orangeColor]];
    [confirmBtn setTintColor:WHITECOLOR];
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idNumberGreenTF.mas_bottom).offset(30);
        make.height.equalTo(@40);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
}
-(void)confirmBtnClick
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@(1) forKey:@"idCardType"];
    [dict setValue:idNumberGreenTF.enterTextField.text forKey:@"idCard"];
    [dict setValue:nameGreenTF.enterTextField.text forKey:@"name"];
    [[ApiFetch share]userPostFetch:USER_BINDIDCARD body:dict holder:self dataModel:UserInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        UserInfo *userNewInfo = (UserInfo *)modelValue;
        [AppManager manager].userInfo.idCard = userNewInfo.idCard;
        [AppManager manager].userInfo.idCardType = userNewInfo.idCardType;
        [AppManager manager].userInfo.name = userNewInfo.name;
        NSDictionary *userInfoDict = [AppManager manager].userInfo.mj_keyValues;
        [[NSUserDefaults standardUserDefaults] setObject:userInfoDict forKey:fSessionUserInfoDic];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"实名认证成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:sure];
        [self presentViewController:alert animated:NO completion:^{
        }];
    }];
    
}
@end
