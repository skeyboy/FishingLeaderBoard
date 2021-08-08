//
//  GoodsOrderComfirmViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GoodsOrderComfirmViewController.h"
#import "PKYStepper+Default.h"
#import "ExchangeViewController.h"
#import "ExchangeBillViewController.h"
#import "ChoosePosionView.h"
#import "ToPayView.h"
@interface GoodsOrderComfirmViewController ()<ExchangeViewControllerDelegate/*,YuAliPayResponse,YuWXPayResponse*/>
@property (weak, nonatomic) IBOutlet UILabel *spotNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameView;
@property (weak, nonatomic) IBOutlet UILabel *enrollView;
@property (weak, nonatomic) IBOutlet PKYStepper *yuStepperView;

//定位图标
@property (weak, nonatomic) IBOutlet UIImageView *locationIndicator;

/// 底部实际支付标识
@property (weak, nonatomic) IBOutlet UILabel *realPayView;

/// 顶部用于显示配送地址
@property (weak, nonatomic) IBOutlet UIView *locationInfoView;

//配送方式和买家留言容器
@property (weak, nonatomic) IBOutlet UIView *goodsAppendInfo;


@property(strong,nonatomic)ToPayView *pay;
@end

@implementation GoodsOrderComfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"确认订单" isShowBack:YES];
    [self.lijihuangouBtn setBackgroundColor:NAVBGCOLOR];
    [self.yuStepperView defaultConfigStep:1];
    if (!self.isRealEnty) {
        [self.locationInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        self.locationIndicator.hidden = YES;
        self.goodsAppendInfo.hidden = !self.isRealEnty;
    }
    [self addDataToView];
}
-(void)addDataToView{
    if(self.isPeiSong == YES)
    {
        self.addressLabel.text = [NSString stringWithFormat:@"详细地址：%@", self.address];
        [self.moneyBtn setTitle:@"20元" forState:UIControlStateNormal];
        [self.getWayBtn setTitle:@"快递到家" forState:UIControlStateNormal];
        self.spotNameLabel.text = [NSString stringWithFormat:@"快递到家"];
    }else{
        self.spotNameLabel.text = [NSString stringWithFormat:@"自提钓场：%@", self.spotName];
        self.addressLabel.text = [NSString stringWithFormat:@"详细地址：%@", self.spotAddress];
        [self.moneyBtn setTitle:@"0元" forState:UIControlStateNormal];
        [self.getWayBtn setTitle:@"买家自提" forState:UIControlStateNormal];
    }
    IMAGE_LOAD(self.goodsImageView, self.coverImg)
    self.priceLabel.text = [NSString stringWithFormat:@"%ld积分", self.price];
    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.count];
    self.totalLabel.text = [NSString stringWithFormat:@"实支付：%ld积分",self.skuPrice*self.count];
    self.liuYanTextField.text = self.remark;
    NSLog(@"self.selectSku = %@",self.selectSku);
    self.guigeLabel.text = self.selectSku;
}
/// 去换购
/// @param sender <#sender description#>
- (IBAction)goToTrade:(id)sender {
    //TODO 发送积分兑换请求
    if(self.isPeiSong == NO)
    {
        [self ziTiPay];
    }else{
        [self peiSongPay];
    }
}
-(void)ziTiPay
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:self.orderStr forKey:@"code"];
    [dict setValue:self.liuYanTextField.text forKey:@"remark"];
    [[ApiFetch share]goodsGetFetch:GOODS_CONFIRMORDER query:dict holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        ExchangeViewController *exchangeVc = [[ExchangeViewController alloc] init];
        exchangeVc.definesPresentationContext = YES;
        exchangeVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        exchangeVc.exchangeVcDelegate = self;
        exchangeVc.fromVc = self;
        [self presentViewController:exchangeVc
                           animated:YES
                         completion:^{
            
        }];
    }];
    
}
//配送支付
-(void)peiSongPay
{
    self.pay =[[[NSBundle mainBundle]loadNibNamed:@"ToPayView" owner:self options:nil]firstObject];
    self.pay.toPage = 2;
    self.pay.detailLabel.text =  [NSString stringWithFormat:@"您共需要支付20元"];
    [self.view addSubview:self.pay];
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    @weakify(self)
    self.pay.confirmBtnClick = ^(PayType payType) {
        [weak_self payForOrder:payType];
    };
}
-(void)payForOrder:(PayType)payType
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:self.orderStr forKey:@"code"];
    [dict setValue:@(payType) forKey:@"payType"];
    [dict setValue:@(20) forKey:@"emsFee"];
    [dict setValue:self.liuYanTextField.text forKey:@"remark"];
    /*
    [ToolClass payGoods:dict shortUri:GOODS_CONFIRMORDER payType:payType holder:self isPost:NO aliResponse:self wxResponse:self
    walletCallback:^{
        [self.pay removeFromSuperview];
        ExchangeViewController *exchangeVc = [[ExchangeViewController alloc] init];
        exchangeVc.definesPresentationContext = YES;
        exchangeVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        exchangeVc.exchangeVcDelegate = self;
        exchangeVc.fromVc = self;
        [self presentViewController:exchangeVc
                           animated:YES
                         completion:^{
            
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
    [self.pay removeFromSuperview];

    switch (errCode) {
        case 0:
        {

            ExchangeViewController *exchangeVc = [[ExchangeViewController alloc] init];
            exchangeVc.definesPresentationContext = YES;
            exchangeVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            exchangeVc.exchangeVcDelegate = self;
            exchangeVc.fromVc = self;
            [self presentViewController:exchangeVc
                               animated:YES
                             completion:^{
                
            }];
            break;
        }
        default:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
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
        [self.pay removeFromSuperview];

        ExchangeViewController *exchangeVc = [[ExchangeViewController alloc] init];
        exchangeVc.definesPresentationContext = YES;
        exchangeVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        exchangeVc.exchangeVcDelegate = self;
        exchangeVc.fromVc = self;
        [self presentViewController:exchangeVc
                           animated:YES
                         completion:^{
            
        }];
        
    } else {
        [self.pay removeFromSuperview];

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sure];
        [self presentViewController:alert animated:NO completion:^{
        }];
        
    }
}
 */
//配送支付完成==========
//积分换购查看账单
-(void)scanExchangeBill{
    //TODO push查看账单页面
    
    ExchangeBillViewController *exchangeBillVc = [[ExchangeBillViewController alloc] init];
    exchangeBillVc.orderStr = self.orderStr;
    [self.navigationController pushViewController:exchangeBillVc
                                         animated:YES];
}

- (IBAction)chooseWayClick:(id)sender {
    //    ChoosePosionView *view = [[ChoosePosionView alloc]init];
    //    [self.view addSubview:view];
    //      [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //         make.top.equalTo(self.view.mas_top);
    //         make.bottom.equalTo(self.view.mas_bottom);
    //         make.left.equalTo(self.view.mas_left);
    //         make.right.equalTo(self.view.mas_right);
    //     }];
    
}
@end
