//
//  RegisterViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "RegisterViewController.h"
#import "IQKeyboardManager.h"
#import "FishingLeaderBoard-Swift.h"
@interface RegisterViewController ()<ApiFetchOptionalHandler>

@property(strong,nonatomic)    UIButton *verfiButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.pageType == FPageTypeForgetPassword)
    {
        [self setNavViewWithTitle:@"密码重置" isShowBack:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else if (self.pageType == FPageTypeBindPhone)
    {
        [self setNavViewWithTitle:@"绑定手机号" isShowBack:YES];
    }
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated
{
//    [IQKeyboardManager sharedManager].enable = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [IQKeyboardManager sharedManager].enable = NO;
}
-(void)initView
{
    float phoneHight = 20;
    if((self.pageType == FPageTypeForgetPassword)||(self.pageType == FPageTypeBindPhone))
    {
        phoneHight = CGRectGetMaxY(hkNavigationView.frame) + 20;
    }
    self.view.backgroundColor = WHITECOLOR;
    self.phoneTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, phoneHight, SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_PHONE_TAG fieldPlaceholder:@"请输入手机号" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"phone"];
    [self.view addSubview:self.phoneTextField];
    if(self.pageType != FPageTypeBindPhone)
    {
    self.psdTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_PWD_TAG fieldPlaceholder:@"请输入密码，数字或字母混合，5位以上" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    [self.view addSubview:self.psdTextField];
    self.psdTextField.textField.secureTextEntry = YES;
    
    self.comfirmPsdField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.psdTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_COMFPWDP_TAG fieldPlaceholder:@"再次输入密码确认" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    [self.view addSubview:self.comfirmPsdField];
    self.comfirmPsdField.textField.secureTextEntry = YES;
        self.verificationTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.comfirmPsdField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_VERFI_TAG fieldPlaceholder:@"请输入验证码" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
         self.verificationTextField.textField.frame = CGRectMake(self.verificationTextField.textField.frame.origin.x, self.verificationTextField.textField.frame.origin.y, self.verificationTextField.textField.frame.size.width - 150, self.verificationTextField.textField.frame.size.height);
         [self.view addSubview:self.verificationTextField];
    }else{
    self.verificationTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_VERFI_TAG fieldPlaceholder:@"请输入验证码" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
     self.verificationTextField.textField.frame = CGRectMake(self.verificationTextField.textField.frame.origin.x, self.verificationTextField.textField.frame.origin.y, self.verificationTextField.textField.frame.size.width - 150, self.verificationTextField.textField.frame.size.height);
     [self.view addSubview:self.verificationTextField];
    }
 
    
    //!<发送验证码
    self.verfiButton = [FViewCreateFactory createCustomButtonWithFrame:(CGRect){SCREEN_WIDTH - 70 - 16, CGRectGetHeight(self.verificationTextField.frame)/2-27.0/2, 50, 27.f}name:@"验证码"
                                                              delegate:self
                                                              selector:@selector(btnClick:)
                                                                   tag:0];
    self.verfiButton.backgroundColor = [UIColor clearColor];
    self.verfiButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [self.verfiButton setBackgroundImage:[UIImage imageNamed:@"reSendVerify"] forState:UIControlStateNormal];
    [self.verfiButton setBackgroundImage:[UIImage imageNamed:@"btn_gray_short"]forState:UIControlStateDisabled];
    self.verfiButton.layer.cornerRadius = 5.0;//2.0是圆角的弧度，根据需求自己更改
    self.verfiButton.layer.borderColor = NAVBGCOLOR.CGColor;//设置边框颜色
    self.verfiButton.layer.borderWidth = 1.0f;//设置边框颜色
    [self.verfiButton setTitleColor:NAVBGCOLOR forState:UIControlStateNormal];
    [self.verificationTextField addSubview:self.verfiButton];
    
    float lLabelHight = 0;
    if(self.pageType ==  FPageTypeRegist)
    {
        lLabelHight = 40;
    }
    UILabel * tLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.verificationTextField.frame),SCREEN_WIDTH, lLabelHight) name:@"注册即视为同意 用户使用条款" font:[UIFont systemFontOfSize:13] textColor:BLACKGRAY];
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.textColor = BLACKGRAY;
    [self.view addSubview:tLabel];
    tLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
          h5Vc.hidesBottomBarWhenPushed = YES;
          h5Vc.url = AGREEMENT;
          [self.navigationController pushViewController:h5Vc
                                               animated:YES];
    }];
    [tLabel addGestureRecognizer:tap];
    
    //注册
    NSString *btnName = @"注册";
    if(self.pageType == FPageTypeBindPhone)
    {
        btnName = @"绑定";
    }else if (self.pageType == FPageTypeForgetPassword)
    {
        btnName = @"确定";
    }
    UIButton *btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(tLabel.frame)+10, SCREEN_WIDTH - 20 *2, 40) name:btnName delegate:self selector:@selector(register:) tag:0];
    btn.backgroundColor = NAVBGCOLOR;
    btn.layer.cornerRadius = 5.0;
    [self.view addSubview:btn];
    
}
-(void)register:(UIButton *)btn
{
    [self.phoneTextField.textField resignFirstResponder];
    [self.psdTextField.textField resignFirstResponder];
    [self.comfirmPsdField.textField resignFirstResponder];
    [self.verificationTextField.textField resignFirstResponder];
    
    NSString *phone = self.phoneTextField.textField.text.description;
    NSString * psd = self.psdTextField.textField.text.description;
    NSString *confirm = self.comfirmPsdField.textField.text.description;
    NSString *code = self.verificationTextField.textField.text.description;
    if(self.pageType == FPageTypeRegist)
    {
    [self registAccount:phone
               password:psd
              reConfirm:confirm
                   code:code];
    }else if (self.pageType == FPageTypeForgetPassword)
    {
        [self forgetPasswordAccount:phone password:psd reConfirm:confirm code:code];
    }else if (self.pageType == FPageTypeBindPhone)
    {
        [self bindPhoneAccount:phone password:psd reConfirm:confirm code:code];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self.phoneTextField.textField resignFirstResponder];
     [self.psdTextField.textField resignFirstResponder];
     [self.comfirmPsdField.textField resignFirstResponder];
     [self.verificationTextField.textField resignFirstResponder];
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    LoginCostomTextField *cf = (LoginCostomTextField *)textField.superview;
    [cf setLineViewSelected];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    LoginCostomTextField *cf = (LoginCostomTextField *)textField.superview;
    [cf setLineViewUnSelected];
    return YES;
}

- (void)textFieldValueChange:(UITextField *)textField
{
    switch (textField.tag)
    {
        case TEXTFIELD_FORGET_PHONE_TAG: //手机号输入
        {
            if (textField.text.length > 11)
            {
                textField.text = [textField.text substringToIndex:11];
            }
            break;
        }
        case TEXTFIELD_FORGET_PWD_TAG: //密码输入
        {
            if (textField.text.length > 18)
            {
                textField.text = [textField.text substringToIndex:18];
            }
            break;
        }
        case TEXTFIELD_FORGET_COMFPWDP_TAG: //密码输入
        {
            if (textField.text.length > 18)
            {
                textField.text = [textField.text substringToIndex:18];
            }
            break;
        }
        case TEXTFIELD_FORGET_VERFI_TAG: //验证码
        {
            if (textField.text.length > 18)
            {
                textField.text = [textField.text substringToIndex:18];
            }
            break;
        }
        default:
            break;
    }
}


#pragma mark - 自定义方法
//获取验证码
-(void)btnClick:(UIButton *)btn
{
    [self.phoneTextField.textField resignFirstResponder];
    [self.psdTextField.textField resignFirstResponder];
    [self.comfirmPsdField.textField resignFirstResponder];
    [self.verificationTextField.textField resignFirstResponder];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:self.phoneTextField.textField.text forKey:@"phone"];
    if(self.pageType == FPageTypeRegist)
    {
       [dict setValue:@(1) forKey:@"type"];
    }else if (self.pageType == FPageTypeForgetPassword)
    {
        [dict setValue:@(3) forKey:@"type"];
    }else if (self.pageType == FPageTypeBindPhone)
    {
        [dict setValue:@(2) forKey:@"type"];
    }
    [[ApiFetch share]userGetFetch:USER_GETCODE query:dict holder:self dataModel:NSDictionary.class onSuccess:^(NSObject *modelValue, id responseObject) {
      [self startTiming];

    }];
}
/**
 *  重新发送按钮的倒计时
 */
- (void)startTiming
{
     WEAKSELF_SC;
    [self startTimingWithTotalTime:60
                  intervalRetBlock:^(int iRemainTime) {
                      weakSelf_SC.verfiButton.enabled = NO;
                      NSMutableAttributedString *attStrAge = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d秒后重新获取",iRemainTime]];
                      NSRange rangeAge = (NSRange){iRemainTime < 10  ? 1 :2, 6};
                      [attStrAge addAttribute:(NSString *)NSForegroundColorAttributeName value: UIColorFromRGB(0xcdcdcd) range:rangeAge];
                      [weakSelf_SC.verfiButton setAttributedTitle:attStrAge forState:UIControlStateNormal];
                      weakSelf_SC.verfiButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
                      weakSelf_SC.verfiButton.frame = (CGRect){SCREEN_WIDTH - 70 - 16 - 30, CGRectGetHeight(weakSelf_SC.verificationTextField.frame)/2-27.0/2, 110, 27.f};
                  } completeRetBlock:^{
                      [weakSelf_SC.verfiButton setAttributedTitle:nil forState:UIControlStateNormal];
                      [weakSelf_SC.verfiButton setTitle:@"重新发送" forState:UIControlStateNormal];
                      weakSelf_SC.verfiButton.enabled = YES;
                  }];
}

- (void)stopTiming
{
    [self.verfiButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.verfiButton setTitle:@"重新发送" forState:UIControlStateNormal];
    self.verfiButton.enabled = YES;
}
@end
@implementation RegisterViewController (AccountRegist)

-(void)registAccount:(NSString *)phone password:(NSString *)password reConfirm:(NSString *)reConfirm code:(NSString *)code{
    if (![password isEqualToString:reConfirm]) {
        [self makeToask:@"两次输入的密码不一致，请重新输入"];
        return;
    }
    if (code.isEmpty) {
        [self makeToask:@"请输入验证码"];
        return;
    }
    NSDictionary * params = @{@"phone":phone,
                              @"code":code,
                              @"password":[password md5String]
    };
    [[ApiFetch share] userGetFetch:USER_PHONE_REGIST_URL
                             query:params
                            holder:self
                         dataModel:UserInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        [SignSuccessClass loginSuccessWithUserInfo:modelValue];
        NSLog(@"注册接口获取的数据：%@",modelValue.description);
    }];
}
-(void)forgetPasswordAccount:(NSString *)phone password:(NSString *)password reConfirm:(NSString *)reConfirm code:(NSString *)code{
    if (![password isEqualToString:reConfirm]) {
        [self makeToask:@"两次输入的密码不一致，请重新输入"];
        return;
    }
    if (code.isEmpty) {
        [self makeToask:@"请输入验证码"];
        return;
    }
    NSDictionary * params = @{@"phone":phone,
                              @"code":code,
                              @"password":[password md5String]
    };
    [[ApiFetch share] userPostFetch:USER_FORGETPSD
                             body:params
                            holder:self
                         dataModel:UserInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码找回成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [self.navigationController popViewControllerAnimated:YES];
                  }];
                  [alert addAction:sure];
                  [self presentViewController:alert animated:NO completion:^{
                  }];
    }];
}
-(void)bindPhoneAccount:(NSString *)phone password:(NSString *)password reConfirm:(NSString *)reConfirm code:(NSString *)code{

    if (code.isEmpty) {
        [self makeToask:@"请输入验证码"];
        return;
    }
    NSDictionary * params = @{@"phone":phone,
                              @"code":code,
    };
    [[ApiFetch share] userGetFetch:USER_BINDPHONE
                             query:params
                            holder:self
                         dataModel:UserInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"model USER_BINDPHONE= %@",modelValue);
        [SignSuccessClass loginSuccessWithUserInfo:modelValue];
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [AppManager manager].userInfo = nil;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
                       UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                           [self.navigationController popViewControllerAnimated:YES];
                       }];
                       [alert addAction:sure];
                       [self presentViewController:alert animated:NO completion:^{
                       }];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
@end
