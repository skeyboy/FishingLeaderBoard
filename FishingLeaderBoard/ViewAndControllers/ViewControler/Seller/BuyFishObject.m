//
//  BuyFishObject.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BuyFishObject.h"
#import "ToPayView.h"
@implementation BuyFishObject
-(void)buyFish:(YuQrViewController*)qrScanVC sellerID:(NSString*)sellerId vc:(UIViewController*)vc
{
    NSArray *sellerArr = [sellerId componentsSeparatedByString:@"#"];
    //买鱼
    __block NSString *money = @"";
    __block  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入支付金额：" message:[NSString stringWithFormat:@"向 %@ 付款",[sellerArr objectAtIndex:2]] preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入单价" ;
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
           textField.placeholder = @"请输入重量(斤)" ;
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
       }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        float l = [alert.textFields[0].text floatValue];
        float w = [alert.textFields[1].text floatValue];
        NSLog(@"pay = %@",alert.textFields[0].text);
        float t = l * w;
        NSString *money = [NSString stringWithFormat:@"%.2f",t];
        [self choosePayWay:money sellerID:sellerId vc:vc];
        [qrScanVC dismissViewControllerAnimated:NO completion:nil];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [qrScanVC dismissViewControllerAnimated:NO completion:nil];
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [qrScanVC presentViewController:alert animated:NO completion:^{
        
    }];
}
-(void)choosePayWay:(NSString *)money sellerID:(NSString*)sellerId vc:(UIViewController*)vc
{
    AppDelegate *de = [AppDelegate appDelegate];
    
    ToPayView *pay =[[[NSBundle mainBundle]loadNibNamed:@"ToPayView" owner:self options:nil]firstObject];
    pay.detailLabel.text =  [NSString stringWithFormat:@"您共需要支付%@元",money];
    pay.toPage = 1;
    [vc.view addSubview:pay];
    @weakify(pay)
    pay.confirmBtnClick = ^(PayType payWay) {
        [self buyFish:money sellerID:sellerId payWay:payWay vc:vc];
        [pay removeFromSuperview];
    };
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.top.equalTo(vc.view.mas_top);
        make.bottom.equalTo(vc.view.mas_bottom);
    }];
}
-(void)buyFish:(NSString*)money sellerID:(NSString*)sellerId payWay:(PayType) payWay vc:(UIViewController*)vc
{
    self.vc = vc;
    NSArray *sellerArr = [sellerId componentsSeparatedByString:@"#"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:0];
     [params setValue:money forKey:@"tranAmount"];
     [params setValue:[sellerArr objectAtIndex:0] forKey:@"makeUserId"];
     [params setValue:@(payWay) forKey:@"payType"];
    /*
    [ToolClass pay:params shortUri:ORDER_BUYFISH payType:payWay holder:vc isPost:NO aliResponse:self wxResponse:self
    walletCallback:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"可在 钱包-账单明细 中查看" preferredStyle:UIAlertControllerStyleAlert];
               
               UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   
               }];
               [alert addAction:sure];
               [vc presentViewController:alert animated:NO completion:^{
                   
               }];
    }];
     */
}
/*
//支付结果回调
-(void)wxPayResponseCode:(int)errCode
                  errStr:(NSString *)errStr
                    type:(int)type
           withReturnKey:(NSString *)returnKey{
    switch (errCode) {
        case 0:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"可在 钱包-账单明细 中查看" preferredStyle:UIAlertControllerStyleAlert];
                              
                              UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                              }];
                              [alert addAction:sure];
                              [self.vc presentViewController:alert animated:NO completion:^{
                              }];
            break;
        }
        default:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                 
                                 UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                                 }];
                                 [alert addAction:sure];
                                 [self.vc presentViewController:alert animated:NO completion:^{
                                 }];
        }
        break;
    }
}
#pragma 用户下单支付宝回调结果处理
-(void)aliPayResponse:(NSDictionary *)dic{
    NSInteger resultStatus = [NSNumber numberWithString: [dic valueForKey:@"resultStatus"]].integerValue;
    if (resultStatus == 9000) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"可在 钱包-账单明细 中查看" preferredStyle:UIAlertControllerStyleAlert];
                      
                      UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                      }];
                      [alert addAction:sure];
                      [self.vc presentViewController:alert animated:NO completion:^{
                      }];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                      
                      UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                      }];
                      [alert addAction:sure];
                      [self.vc presentViewController:alert animated:NO completion:^{
                      }];
        
    }
}
 */
@end
