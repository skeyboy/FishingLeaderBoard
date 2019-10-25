//
//  RegisterViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "RegisterViewController.h"
#import "IQKeyboardManager.h"
@interface RegisterViewController ()

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
    }
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = NO;
}
-(void)initView
{
    float phoneHight = 20;
    if(self.pageType == FPageTypeForgetPassword)
    {
        phoneHight = CGRectGetMaxY(hkNavigationView.frame) + 20;
    }
    self.view.backgroundColor = WHITECOLOR;
    self.phoneTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, phoneHight, SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_PHONE_TAG fieldPlaceholder:@"请输入手机号" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"phone"];
    [self.view addSubview:self.phoneTextField];
    
    self.psdTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_PWD_TAG fieldPlaceholder:@"请输入密码，数字或字母混合，5位以上" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    [self.view addSubview:self.psdTextField];
    
    self.comfirmPsdField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.psdTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_COMFPWDP_TAG fieldPlaceholder:@"再次输入密码确认" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    [self.view addSubview:self.comfirmPsdField];
    
    self.verificationTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.comfirmPsdField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_FORGET_VERFI_TAG fieldPlaceholder:@"请输入验证码" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    self.verificationTextField.textField.frame = CGRectMake(self.verificationTextField.textField.frame.origin.x, self.verificationTextField.textField.frame.origin.y, self.verificationTextField.textField.frame.size.width - 150, self.verificationTextField.textField.frame.size.height);
    [self.view addSubview:self.verificationTextField];
    
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
    
    //注册
    UIButton *btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(tLabel.frame)+10, SCREEN_WIDTH - 20 *2, 40) name:@"注册" delegate:self selector:@selector(register:) tag:0];
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
    [self startTiming];
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
