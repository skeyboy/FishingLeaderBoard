//
//  LoginViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import "YuWeChatShareManager.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<YuWXResponse,ApiFetchOptionalHandler>

@end

@implementation LoginViewController
-(void)wxLoginResponse:(YuWeChatShareManager *)chatManager result:(YuWxResponseValue *)wxDataInfo{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
}
- (void)wxLoginFetchCode:(NSString *)wxCode withManager:(YuWeChatShareManager *)chatManager{
    @weakify(self)
    [[ApiFetch share] userGetFetch:USER_WX_Login_URL
                             query:@{@"wxCode":wxCode}
                            holder:self
                         dataModel:UserInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        [AppManager manager].userInfo = (UserInfo*)modelValue;
        if([AppManager manager].userInfo.phone)
        {
            [SignSuccessClass loginSuccessWithUserInfo:modelValue];
        }else{
            RegisterViewController *forgetPwdViewCtrl = [[RegisterViewController alloc]init];
            forgetPwdViewCtrl.hidesBottomBarWhenPushed = YES;
            forgetPwdViewCtrl.pageType = FPageTypeBindPhone;
            [self.navigationController pushViewController:forgetPwdViewCtrl animated:YES];
        }
    }];
    
}
-(void)subcity:(NSString *) parentId dict:(NSMutableDictionary *) province{
  __block  NSMutableArray * subCities = [NSMutableArray arrayWithCapacity:0];
    [[ApiFetch share] userGetFetch:USER_CITY
                             query:@{@"parentId":parentId}
                            holder:nil
                         dataModel:NSDictionary.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSArray * provinces = [responseObject valueForKey:@"data"];
               
               for (NSDictionary * item in provinces) {
                   
                   NSMutableDictionary * city = [NSMutableDictionary dictionary];
                   [city setValue: [@([item longValueForKey:@"id" default:0]) description] forKey:@"code"];
                   [city setValue: [item[@"name"] description] forKey:@"name"];
                   if (!([[item[@"name"] description] containsString:@"区"] || [[item[@"name"] description] containsString:@"县"])) {
                       [self subcity:[item[@"id"] description] dict:city];
                   }
                   [subCities addObject:city];
                   
               }
        province[@"children"] = subCities;
        NSString * path = [NSHomeDirectory()  stringByAppendingPathComponent:@"Documents/json.txt"];
        [[items jsonStringEncoded] writeToFile:path
                                    atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",[items jsonStringEncoded]);
    }];
}
static NSMutableArray * items;

-(void)recodeArea{
    items    = [NSMutableArray arrayWithCapacity:0];
    
    [[ApiFetch share] userGetFetch:USER_PROVINCE
                             query:@{} holder:nil
                         dataModel:NSDictionary.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSArray * provinces = [responseObject valueForKey:@"data"];
        
        for (NSDictionary * item in provinces) {
            
            NSMutableDictionary * province = [NSMutableDictionary dictionary];
            [province setValue: [@([item longValueForKey:@"id" default:0]) description] forKey:@"code"];
            [province setValue: [item[@"name"] description] forKey:@"name"];
            [self subcity:[item[@"id"] description] dict:province];
            [items addObject:province];
            
        }
    }];
//    [[ApiFetch share] getFetch:USER_PROVINCE
//                         query:@{}
//                     onSuccess:^(AppModel * _Nonnull modelValue, id _Nonnull v) {
//
//    } onFailure:^(NSString * _Nonnull message, NSString * _Nonnull shortLink) {
//
//    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    //    [IQKeyboardManager sharedManager].enable = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    //    [IQKeyboardManager sharedManager].enable = NO;
}
- (void)initView
{
    self.view.backgroundColor = WHITECOLOR;
    self.accountTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_ACCOUNT_TAG fieldPlaceholder:@"请输入账号" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"user"];
    [self.view addSubview:self.accountTextField];
    
    self.psdTextField = [[LoginCostomTextField alloc]initLoginCostomTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.accountTextField.frame), SCREEN_WIDTH, 60) fieldTag:TEXTFIELD_PWD_TAG fieldPlaceholder:@"请输入密码" fieldTarget:self action:@selector(textFieldValueChange:)imageName:@"pwd"];
    self.psdTextField.textField.secureTextEntry = YES;
    [self.view addSubview:self.psdTextField];
    
    //登录
    UIButton *btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(self.psdTextField.frame)+25, CGRectGetWidth(self.view.frame)-20*2, 40) name:@"登录" delegate:self selector:@selector(login:) tag:BUTTON_LOGIN_TAG];
    btn.backgroundColor = NAVBGCOLOR;
    btn.layer.cornerRadius = 5.0;
    [self.view addSubview:btn];
    //忘记密码
    btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(btn.frame)+ 10, SCREEN_WIDTH - 20 *2, 40) name:@"忘记密码？" delegate:self selector:@selector(login:) tag:BUTTON_FORGET_PWD_TAG];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:BLACKGRAY forState:UIControlStateNormal];
    [self.view addSubview:btn];
    if ([YuWeChatShareManager isWXAppInstalled]) {
        UILabel * tLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2.0, CGRectGetMaxY(btn.frame) +30, 120, 40) name:@"第三方账号登录" font:[UIFont systemFontOfSize:13] textColor:BLACKGRAY];
        [self.view addSubview:tLabel];
        //微信登录
        btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake((SCREEN_WIDTH -50)/2.0, CGRectGetMaxY(tLabel.frame), 50, 50) name:@"" delegate:self selector:@selector(login:) tag:BUTTON_THIRD_LOGIN_TAG];
        [btn setImage:[UIImage imageNamed:@"weixinIcon"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:fSessionUser];
        NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:fSessionUserPassword];
        if(phone)
        {
            self.accountTextField.textField.text = phone;
        }
        if(password)
        {
            self.self.psdTextField.textField.text = password;
        }
    }
    


}
-(void)login:(UIButton *)btn
{
    [self.accountTextField.textField resignFirstResponder];
    [self.psdTextField.textField resignFirstResponder];
    if(btn.tag == BUTTON_THIRD_LOGIN_TAG)//第三方登录
    {
        
        [[YuWeChatShareManager manager] loginFromVC:self];
        //         [AppDelegate appDelegate].window.rootViewController = [FTabBarClass initTabBarControll:FPageTypeDiaoChangZhu];
    }else if(btn.tag == BUTTON_LOGIN_TAG)//登录
    {
        NSString * account = self.accountTextField.textField.text.description;
        NSString *password = self.psdTextField.textField.text.description;
        if (account.isEmpty || password.isEmpty) {
            [self makeToask:@"请输入正确的账号和密码"];
            return;
        }
        [self loginAccount:account
                  password:password];
        //        [AppDelegate appDelegate].window.rootViewController = [FTabBarClass intoTabBarControll:FPageTypeDaiLiRen];
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


@end
@implementation LoginViewController (UserAccount)

-(void)loginAccount:(NSString *)account password:(NSString *)password{
    
    NSDictionary * params = @{@"phone":account,
                              @"password":[password md5String]
    };
    @weakify(self)
    [[ApiFetch share] userGetFetch:USER_PHONE_LOGIN
                             query:params
                            holder:self
                         dataModel:UserInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        //将用户登录信息存入本地沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:account forKey:fSessionUser];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:fSessionUserPassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        [self recodeArea];

        [SignSuccessClass loginSuccessWithUserInfo:modelValue];
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
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
