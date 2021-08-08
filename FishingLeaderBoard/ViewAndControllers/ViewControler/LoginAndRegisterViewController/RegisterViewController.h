//
//  RegisterViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"
#import "LoginCostomTextField.h"
NS_ASSUME_NONNULL_BEGIN


@interface RegisterViewController : FViewController

@property(nonatomic ,assign)FPageType pageType;
@property(nonatomic ,strong)LoginCostomTextField *phoneTextField;
@property(nonatomic ,strong)LoginCostomTextField *psdTextField;
@property(nonatomic ,strong)LoginCostomTextField *comfirmPsdField;
@property(nonatomic ,strong)LoginCostomTextField *verificationTextField;

@end
@interface RegisterViewController (AccountRegist)
/// 手机号注册
/// @param phone 手机
/// @param password 密码
/// @param reConfirm 确认密码
/// @param code 验证码
-(void)registAccount:(NSString *) phone
            password:(NSString *) password
           reConfirm:(NSString *) reConfirm code:(NSString *) code;

-(void)forgetPasswordAccount:(NSString *)phone password:(NSString *)password reConfirm:(NSString *)reConfirm code:(NSString *)code;
-(void)bindPhoneAccount:(NSString *)phone password:(NSString *)password reConfirm:(NSString *)reConfirm code:(NSString *)code;
@end
NS_ASSUME_NONNULL_END
