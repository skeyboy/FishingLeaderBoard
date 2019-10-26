//
//  UserInfoViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UserInfoViewController.h"
#import "IQKeyboardManager.h"
@interface UserInfoViewController ()
{
    UIImageView *_userHeadImageView;
    GreenLineTextField *userNameGreenTF;
    GreenLineTextField *phoneNumberGreenTF;
    GreenLineTextField *sexGreenTF;
    GreenLineTextField *areaGreenTF;
    GreenLineTextField *birthdayGreenTF;
    GreenLineTextField *qianMingGreenTF;
}

@end

@implementation UserInfoViewController
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = YES;
    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    de.tbc.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = NO;
    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    de.tbc.tabBar.hidden =NO;
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:@"信息编辑" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    
    [self initPageView];
}
-(void)initPageView
{
    __weak __typeof(self) weakSelf = self;
    _userHeadImageView = [FViewCreateFactory createImageViewWithImageName:@"avatar_none"];
    _userHeadImageView.contentMode = UIViewContentModeScaleToFill;
    _userHeadImageView.clipsToBounds = YES;
    [self.view addSubview:_userHeadImageView];
    [_userHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self->hkNavigationView.mas_bottom).mas_offset(20);
        make.left.equalTo(@((SCREEN_WIDTH-60)/2.0));
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPicture)];
    [_userHeadImageView addGestureRecognizer:tap];
    _userHeadImageView.layer.cornerRadius=30;
    _userHeadImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPicture)];
    UIImageView *photo = [FViewCreateFactory createImageViewWithImageName:@"camera"];
    [self.view addSubview:photo];
    [photo addGestureRecognizer:tap];
    [photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userHeadImageView.mas_bottom).offset(-22.5);
        make.left.equalTo(self->_userHeadImageView.mas_right).offset(-22.5);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];

    UILabel*label = [FViewCreateFactory createLabelWithName:@"上传头像" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self->_userHeadImageView.mas_bottom).offset(15);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@21);
    }];

    userNameGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:userNameGreenTF];
    [userNameGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    userNameGreenTF.leftLabel.text = @"昵称";
    userNameGreenTF.enterTextField.text = @"用户-13621019411";

    phoneNumberGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:phoneNumberGreenTF];
    [phoneNumberGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->userNameGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    phoneNumberGreenTF.leftLabel.text = @"手机号";
    phoneNumberGreenTF.enterTextField.text = @"13621019411";
    phoneNumberGreenTF.leftLabel.textColor = [UIColor lightGrayColor];
    phoneNumberGreenTF.enterTextField.enabled =NO;
    phoneNumberGreenTF.enterTextField.textColor=[UIColor lightGrayColor];

    sexGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:sexGreenTF];
    [sexGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->phoneNumberGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    sexGreenTF.leftLabel.text = @"性别";
    sexGreenTF.enterTextField.hidden = YES;
    sexGreenTF.rightButton.hidden = NO;
    [sexGreenTF.rightButton setTitle:@"请选择" forState:UIControlStateNormal];

    areaGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:areaGreenTF];
    [areaGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->sexGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    areaGreenTF.enterTextField.hidden = YES;
    areaGreenTF.leftLabel.text = @"地区";

    birthdayGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:birthdayGreenTF];
    [birthdayGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->areaGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    birthdayGreenTF.leftLabel.text = @"生日";
    birthdayGreenTF.enterTextField.hidden = YES;
    birthdayGreenTF.rightButton.hidden = NO;
    [birthdayGreenTF.rightButton setTitle:@"请选择日期" forState:UIControlStateNormal];

    qianMingGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:qianMingGreenTF];
    [qianMingGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->birthdayGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@120);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    qianMingGreenTF.leftLabel.hidden = YES;
    qianMingGreenTF.enterTextField.hidden =YES;
    qianMingGreenTF.textView.hidden = NO;
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor orangeColor]];
    [confirmBtn setTintColor:WHITECOLOR];
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-30);
        make.height.equalTo(@40);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
}
-(void)confirmBtnClick
{
    [self.view endEditing:YES];
}

-(void)selectPicture
{
    __weak __typeof(self) weakSelf = self;
    [SelectPhotosViewController checkPhotoLibraryAuthorization:^(BOOL isPermission) {
        NSLog(@"%d",isPermission);
        if (isPermission) {
        SelectPhotosViewController *vc=[[SelectPhotosViewController alloc]init];
        vc.selectPhoto = ^(UIImage * image) {
            if(image)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self->_userHeadImageView.image =image;
                });
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    NSLog(@"%s",__func__);
}


@end
