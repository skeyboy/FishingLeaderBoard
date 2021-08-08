//
//  ReChargeViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ReChargeViewController.h"
#import "LeftViewBottomLineField.h"

@interface ReChargeViewController ()/*<YuWXPayResponse,YuAliPayResponse>*/
@property (weak, nonatomic) IBOutlet UIButton *wxPayBtn;
@property (weak, nonatomic) IBOutlet LeftViewBottomLineField *tranAmountView;
@end

@implementation ReChargeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.payType = PayTypeWx;
   if (![YuWeChatShareManager isWXAppInstalled]) {
       self.wxPayBtn.hidden = YES;
       [self.wxPayBtn mas_updateConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(@(0));
           
       }];
       self.payType = PayTypeAli;
      }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"" isShowBack:NO];
    self.weiXinBtn.layer.borderColor = NAVBGCOLOR.CGColor;
    self.weiXinBtn.layer.borderWidth = 1;
    [hkNavigationView setNavBarViewLeftBtnWithTitle:@"钱包充值"
                                     normalImage:nil
                                highlightedImage:nil
                                       titleFont:17
                                          target:self
                                          action:nil];
    
[hkNavigationView setNavBarViewRightBtnWithTitle:@"取消充值"
                                     normalImage:nil
                                highlightedImage:nil
                                       titleFont:17
                                          target:self
                                          action:@selector(btnClickBack)];
    
}
//支付结果回调
-(void)wxPayResponseCode:(int)errCode
                  errStr:(NSString *)errStr
                    type:(int)type
           withReturnKey:(NSString *)returnKey{
    switch (errCode) {
        case 0:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值成功" message:@"可在 钱包-账单明细 中查看" preferredStyle:UIAlertControllerStyleAlert];
                              
                              UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                  [self flashData];
                              }];
                              [alert addAction:sure];
                              [self presentViewController:alert animated:NO completion:^{
                              }];
            break;
        }
        default:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                 
                                 UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                                 }];
                                 [alert addAction:sure];
                                 [self presentViewController:alert animated:NO completion:^{
                                 }];
        }
        break;
    }
}
#pragma 用户下单支付宝回调结果处理
-(void)aliPayResponse:(NSDictionary *)dic{
    NSInteger resultStatus = [NSNumber numberWithString: [dic valueForKey:@"resultStatus"]].integerValue;
    if (resultStatus == 9000) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值成功" message:@"可在 钱包-账单明细 中查看" preferredStyle:UIAlertControllerStyleAlert];
                      
                      UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                          [self flashData];

                      }];
                      [alert addAction:sure];
                      [self presentViewController:alert animated:NO completion:^{
                      }];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                      
                      UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                      }];
                      [alert addAction:sure];
                      [self presentViewController:alert animated:NO completion:^{
                      }];
        
    }
}
- (IBAction)enchargeMyWallet:(id)sender {
    if (!self.tranAmountView.text.length) {
        [self makeToask:@"请输入充值金额"];
        return;
    }
    NSDictionary * enChargeParams = @{
        @"tranAmount":self.tranAmountView.text,
        @"payType": @(self.payType)
    };
    [self.view endEditing:YES];
   /*
    [ToolClass pay:enChargeParams
          shortUri:Order_CHARGE_WALLET
           payType:self.payType
            holder:self
           isPost:YES
       aliResponse:self
        wxResponse:self
    walletCallback:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值成功" message:@"可在 钱包-账单明细 中查看" preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       
                         [self flashData];
                     }];
                     [alert addAction:sure];
                     [self presentViewController:alert animated:NO completion:^{
                         
                     }];
    }];
    */
}
-(void)flashData
{
      [self.navigationController popViewControllerAnimated:YES];
      if ([self.vc respondsToSelector:@selector(getData)]) {
               [self.vc performSelector:@selector(getData)];//刷新账户信息
           }
}
- (IBAction)weiXinClick:(id)sender {
      self.payType = PayTypeWx;
      self.weiXinBtn.layer.borderColor = NAVBGCOLOR.CGColor;
      self.weiXinBtn.layer.borderWidth = 1;
    self.zhiFuBaoBtn.layer.borderColor = WHITECOLOR.CGColor;
    self.zhiFuBaoBtn.layer.borderWidth = 1;
}

- (IBAction)zhiFuBaoClick:(id)sender {
       self.payType = PayTypeAli;
    self.weiXinBtn.layer.borderColor = WHITECOLOR.CGColor;
         self.weiXinBtn.layer.borderWidth = 1;
       self.zhiFuBaoBtn.layer.borderColor = NAVBGCOLOR.CGColor;
       self.zhiFuBaoBtn.layer.borderWidth = 1;
}
@end
