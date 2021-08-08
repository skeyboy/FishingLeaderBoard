//
//  UserInfoViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UserInfoViewController.h"
#import "IQKeyboardManager.h"
#import "JJImagePicker.h"
#import "SpotLocationChoseViewController.h"
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
@property(strong,nonatomic)NSString *strImg;
@end

@implementation UserInfoViewController
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = YES;
    //    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    //    de.tbc.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = NO;
    //    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    //    de.tbc.tabBar.hidden =NO;
    //    [self.view endEditing:YES];
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
    UserInfo *userInfo = [AppManager manager].userInfo;
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
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headImg]  placeholderImage:[UIImage imageNamed:@"avatar_none"]];
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
    userNameGreenTF.enterTextField.text = userInfo.nickName;
    
    phoneNumberGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:phoneNumberGreenTF];
    [phoneNumberGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->userNameGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    phoneNumberGreenTF.leftLabel.text = @"手机号";
    phoneNumberGreenTF.enterTextField.text = userInfo.phone;
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
    sexGreenTF.textFieldClick = ^(UITextField * t) {
    
    };
    [sexGreenTF.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [sexGreenTF.rightButton setTitle:@"请选择" forState:UIControlStateNormal];
    if(userInfo.gender!=0)
    {
        [sexGreenTF.rightButton setTitle:(userInfo.gender==1)?@"男":@"女" forState:UIControlStateNormal];
    }
    [sexGreenTF.rightButton addTarget:self action:@selector(chooseSex) forControlEvents:UIControlEventTouchUpInside];
    areaGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:areaGreenTF];
    [areaGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->sexGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    if(userInfo.address)
    {
        areaGreenTF.enterTextField.text = userInfo.address;
    }else{
        areaGreenTF.enterTextField.hidden = YES;
    }
    areaGreenTF.leftLabel.text = @"地区";
    areaGreenTF.enterTextField.enabled = NO;
    areaGreenTF.enterTextField.tag = TEXTFIELD_SAISHISHIJIAN_TAG;
    areaGreenTF.textFieldClick = ^(UITextField * textField) {
        [self locationClick];
    };
    [areaGreenTF.rightButton setTintColor:[UIColor lightGrayColor]];
    [areaGreenTF.rightButton setImage:[UIImage imageNamed:@"rightInto_b"] forState:UIControlStateNormal];
    
    areaGreenTF.rightButton.hidden = NO;
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
    if(userInfo.birthday)
    {
        NSString *birS = [ToolClass dateSByShiJianChuo:userInfo.birthday];
        [birthdayGreenTF.rightButton setTitle: birS forState:UIControlStateNormal];
    }else{
        [birthdayGreenTF.rightButton setTitle:@"请选择日期" forState:UIControlStateNormal];
    }
    birthdayGreenTF.textFieldClick = ^(UITextField * t) {
       
       };
    [birthdayGreenTF.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [birthdayGreenTF.rightButton addTarget:self action:@selector(chooseBirthday) forControlEvents:UIControlEventTouchUpInside];
    
    qianMingGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:qianMingGreenTF];
    if(userInfo.sign)
    {
        qianMingGreenTF.textView.text = userInfo.sign;
    }
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
-(void)chooseSex{
    [self.view endEditing:YES];
    UserInfo *userInfo = [AppManager manager].userInfo;
    SexChooseView* sexChooseView = [[SexChooseView alloc]initWith:(userInfo.gender==2)?NO:YES];
    sexChooseView.btnYesClick = ^(BOOL isNan) {
        if(isNan)
        {
            [self->sexGreenTF.rightButton setTitle:@"男" forState:UIControlStateNormal];
        }else{
            [self->sexGreenTF.rightButton setTitle:@"女" forState:UIControlStateNormal];
        }
    };
    [self.view addSubview:sexChooseView];
    [sexChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
-(void)chooseBirthday{
    [self.view endEditing:YES];
    UserInfo *userInfo = [AppManager manager].userInfo;
    NSDate *date = [ToolClass dateByShiJianChuo:userInfo.birthday];
    //年-月-日
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"选择的日期：%@",dateString);
        [self->birthdayGreenTF.rightButton setTitle:dateString forState:UIControlStateNormal];
    }];
    datepicker.dateLabelColor = [UIColor blackColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
    datepicker.cancelButtonColor = datepicker.doneButtonColor;
    datepicker.headerViewColor = [UIColor groupTableViewBackgroundColor];
    datepicker.hideSegmentedLine=YES;
    datepicker.hideBackgroundYearLabel=YES;
    [datepicker show];
}
-(void)confirmBtnClick
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:userNameGreenTF.enterTextField.text forKey:@"nickName"];
    NSString *sex = [sexGreenTF.rightButton titleForState:UIControlStateNormal];
    if([sex isEqualToString:@"请选择"])
    {
        [dict setValue:@(0) forKey:@"gender"];
        
    }else{
        if([sex isEqualToString:@"男"])
        {
            [dict setValue:@(1) forKey:@"gender"];
        }else{
            [dict setValue:@(2) forKey:@"gender"];
        }
    }
    NSString *birday = [birthdayGreenTF.rightButton titleForState:UIControlStateNormal];
    if(![birday isEqualToString:@"请选择日期"])
    {
        [dict setValue:birday forKey:@"birthday"];
    }
    [dict setValue:qianMingGreenTF.textView.text forKey:@"sign"];
    [dict setValue:areaGreenTF.enterTextField.text forKey:@"address"];
    if(self.strImg)
    {
        [dict setValue:self.strImg forKey:@"headImg"];
    }
    
    [[ApiFetch share] userPostFetch:USER_EDITUSER body:dict holder:self dataModel:UserInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        UserInfo *userNewInfo = (UserInfo *)modelValue;
        [AppManager manager].userInfo.address = userNewInfo.address;
        [AppManager manager].userInfo.sign = userNewInfo.sign;
        [AppManager manager].userInfo.gender = userNewInfo.gender;
        [AppManager manager].userInfo.nickName = userNewInfo.nickName;
        [AppManager manager].userInfo.birthday = userNewInfo.birthday;
        [AppManager manager].userInfo.headImg = userNewInfo.headImg;
        NSDictionary *userInfoDict = [AppManager manager].userInfo.mj_keyValues;
        [[NSUserDefaults standardUserDefaults] setObject:userInfoDict forKey:fSessionUserInfoDic];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if([self.vc respondsToSelector:@selector(frashData)])
        {
            [self.vc performSelector:@selector(frashData)];
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息修改成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                         
                         UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                             [self.navigationController popViewControllerAnimated:YES];
                         }];
                         [alert addAction:sure];
                         [self.vc presentViewController:alert animated:NO completion:^{
                         }];
    }];
    
    
}

-(void)selectPicture
{
    
    JJImagePicker *picker = [ToolView selectImageFromAlbum];
    [picker actionSheetWithTakePhotoTitle:@"" albumTitle:@"从相册选择一张图片" cancelTitle:@"取消" InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
        [[ApiFetch share]upload:image success:^(NSString *msg) {
            [self hideHud];
            self->_userHeadImageView.image = image;
            self.strImg = msg;
        } failure:^{
            [self hideHud];
        }];
    }];
}

-(void)locationClick
{
    SpotLocationChoseViewController * spotLocationChoseVc = [[SpotLocationChoseViewController alloc] init];
    spotLocationChoseVc.reverLocationResult = ^(NSString * _Nonnull address, CLLocationCoordinate2D coordinate,NSString *cityId) {
        self->areaGreenTF.enterTextField.text = address;
    };
    
    [self.navigationController pushViewController:spotLocationChoseVc
                                         animated:YES];
}
@end
