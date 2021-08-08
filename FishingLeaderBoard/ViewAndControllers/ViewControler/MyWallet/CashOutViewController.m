//
//  CashOutViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "CashOutViewController.h"
#import "LeftViewBottomLineField.h"
@interface CashOutViewController ()<UITextFieldDelegate>

/// 提现金额
@property (weak, nonatomic) IBOutlet LeftViewBottomLineField *moneyTotalView;

/// 支付宝账号
@property (weak, nonatomic) IBOutlet LeftViewBottomLineField *aliAccountView;
//账号人姓名
@property (weak, nonatomic) IBOutlet LeftViewBottomLineField *accountOwnerView;
//联系人电话
@property (weak, nonatomic) IBOutlet LeftViewBottomLineField *ownerPhone;

@property (weak, nonatomic) IBOutlet UIButton *submitView;

@end

@implementation CashOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.moneyTotalView.delegate = self;
//    self.aliAccountView.delegate = self;
//    self.accountOwnerView.delegate = self;
//    self.ownerPhone.delegate = self;
    
    [self setNavViewWithTitle:@"提现" isShowBack:YES];
//    self.showZhiFuBaoLabel.backgroundColor = NAVBGCOLOR;
}
- (IBAction)gotoCashOut:(id)sender {
    @weakify(self)
//    UIAlertController *infoVc = [UIAlertController alertControllerWithTitle:@"提示"
//                                                                    message:@"请输入钱包密码" preferredStyle:UIAlertControllerStyleAlert];
//    [infoVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder =@"请输入钱包密码";
//        textField.secureTextEntry = YES;
//    }];
//    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定"
//                                                       style:0 handler:^(UIAlertAction * _Nonnull action) {
//        NSString * pwd = infoVc.textFields.firstObject.text;
//        [weak_self confirm:pwd];
//
//    }];
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消"
//                                                         style:0 handler:^(UIAlertAction * _Nonnull action) {
//
//      }];
//    [infoVc addAction:confirm];
//    [infoVc addAction:cancel];
//
//
//    [self presentViewController:infoVc
//                       animated:YES
//                     completion:^{
//
//    }];
    [self confirm:nil];
}
-(void)confirm:(NSString *) pwd{
//    [self.view endEditing: YES];
//    if([self.moneyTotalView.text intValue]<100)
//    {
//        [self showDefaultInfo:@"提现最低金额100元"];
//        return;
//    }else if(self.aliAccountView.text)
//    {
//        [self showDefaultInfo:@"请输入支付宝账号"];
//        return;
//    }else if(self.accountOwnerView.text)
//    {
//        [self showDefaultInfo:@"请输入姓名"];
//        return;
//    }else if(self.ownerPhone.text)
//    {
//        [self showDefaultInfo:@"请输入联系电话"];
//        return;
//    }
    NSDictionary * params = @{
        @"tranAmount":self.moneyTotalView.text,
        @"payAccount":self.aliAccountView.text,
        @"payName":self.accountOwnerView.text,
        @"payPhone":self.ownerPhone.text
    };
      [[ApiFetch share] orderGetFetch:ORDER_CASHOUT_MONEY
                                  query:params
                                holder:self
                             dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
          NSLog(@"mm = %@",modelValue);
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提现成功" message:@"等待审核" preferredStyle:UIAlertControllerStyleAlert];
                              
                              UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                              }];
                              [alert addAction:sure];
                              [self presentViewController:alert animated:NO completion:^{
                                  
                              }];
      }];
}

-(void)textFieldDidChangeSelection:(UITextField *)textField{
//    BOOL  isAllInput = NO;
//    for (UIView *aView in self.view.subviews) {
//        if ([aView isKindOfClass:[UITextField class]]) {
//            UITextField * field = aView;
//            if (!field.text) {
//                isAllInput = NO;
//            }
//        }
//    }
//    self.submitView.enabled = isAllInput;
    
}
@end
