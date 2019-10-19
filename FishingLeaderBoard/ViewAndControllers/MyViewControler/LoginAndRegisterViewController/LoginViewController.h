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
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : FViewController
@property(strong,nonatomic)LoginCostomTextField *accountTextField;
@property(strong,nonatomic)LoginCostomTextField *psdTextField;
@end

NS_ASSUME_NONNULL_END
