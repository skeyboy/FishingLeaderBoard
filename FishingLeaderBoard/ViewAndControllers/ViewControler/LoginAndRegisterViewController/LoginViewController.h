//
//  LoginViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"
#import "LoginCostomTextField.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : FViewController<ApiFetchOptionalHandler>
@property(strong,nonatomic)LoginCostomTextField *accountTextField;
@property(strong,nonatomic)LoginCostomTextField *psdTextField;
@end
@interface LoginViewController (UserAccount)

/// 手机号登陆
/// @param account 手机号
/// @param password 密码
-(void)loginAccount:(NSString *) account
           password:(NSString *) password;


@end
NS_ASSUME_NONNULL_END
