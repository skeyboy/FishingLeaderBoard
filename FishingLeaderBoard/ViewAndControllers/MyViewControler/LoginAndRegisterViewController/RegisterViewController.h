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

NS_ASSUME_NONNULL_END
