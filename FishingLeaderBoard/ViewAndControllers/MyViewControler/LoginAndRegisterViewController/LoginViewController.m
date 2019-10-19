//
//  LoginViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
}

- (void)initView
{
    self.view.backgroundColor = WHITECOLOR;
    self.accountTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_ACCOUNT_TAG fieldPlaceholder:@"请输入账号" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"user"];
    [self.view addSubview:self.accountTextField];
    
    self.psdTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.accountTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_PWD_TAG fieldPlaceholder:@"请输入密码" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    [self.view addSubview:self.psdTextField];

    //登录
    UIButton *btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(self.psdTextField.frame)+25, SCREEN_WIDTH - 20 *2, 40) name:@"登录" delegate:self selector:@selector(login:) tag:BUTTON_LOGIN_TAG];
    btn.backgroundColor = NAVBGCOLOR;
    btn.layer.cornerRadius = 5.0;
    [self.view addSubview:btn];
    //忘记密码
    btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(btn.frame)+ 10, SCREEN_WIDTH - 20 *2, 40) name:@"忘记密码？" delegate:self selector:@selector(login:) tag:BUTTON_FORGET_PWD_TAG];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:BLACKGRAY forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UILabel * tLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2.0, CGRectGetMaxY(btn.frame) +30, 120, 40) name:@"第三方账号登录" font:[UIFont systemFontOfSize:13] textColor:BLACKGRAY];
    [self.view addSubview:tLabel];
    //微信登录
    btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake((SCREEN_WIDTH -50)/2.0, CGRectGetMaxY(tLabel.frame), 50, 50) name:@"" delegate:self selector:@selector(login:) tag:BUTTON_THIRD_LOGIN_TAG];
    [btn setImage:[UIImage imageNamed:@"weixinIcon"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
}
-(void)login:(UIButton *)btn
{
    [self.accountTextField.textField resignFirstResponder];
    [self.psdTextField.textField resignFirstResponder];
    if(btn.tag == BUTTON_THIRD_LOGIN_TAG)//第三方登录
    {
        
    }else if(btn.tag == BUTTON_LOGIN_TAG)//登录
    {
        
    }else{//忘记密码
        RegisterViewController *forgetPwdViewCtrl = [[RegisterViewController alloc]init];
        forgetPwdViewCtrl.pageType = FPageTypeForgetPassword;
        [self.navigationController pushViewController:forgetPwdViewCtrl animated:YES];
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.accountTextField.textField resignFirstResponder];
    [self.psdTextField.textField resignFirstResponder];
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
        case TEXTFIELD_ACCOUNT_TAG: //用户名输入
        {
            if (textField.text.length > 11)
            {
                textField.text = [textField.text substringToIndex:11];
            }
            break;
        }
        case TEXTFIELD_PWD_TAG: //密码输入
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
