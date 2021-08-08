//
//  ShowOrderNumberView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ShowOrderNumberView.h"
#import "ToPayView.h"
#import "YYTimer.h"
#import "EnrollGameObject.h"
@implementation ShowOrderNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"ShowOrderNumberView" owner:self options:nil] lastObject];
    if (self) {
        //        self.bounds = frame;
    }
    return self;
}
-(void)isOrder:(BOOL)isOrder order:(OrderApplyGame*)order vc:(nonnull UIViewController *)vc fvc:(UIViewController*)fvc type:(NSInteger)type
{
    self.fvc = fvc;
    self.type = type;
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@",order.applicationCode];
    self.timeLabel.text = [NSString stringWithFormat:@"创建时间：%@",[ToolClass dateToString:order.createTime]];
    self.orderApplyGame = order;
    [self.cancelBtn setBackgroundColor:NAVBGCOLOR];
    [self.payBtn setBackgroundColor:NAVBGCOLOR];
    self.timerLbael.backgroundColor = NAVBGCOLOR;
    //1已支付，0是未支付
    if(isOrder == 0)
    {
        self.showLabel.hidden = YES;
        self.bgSomeLocationLabel.hidden = YES;
        self.timerLbael.hidden = YES;
        
    }else
    {
        self.payBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        //如果没有座位号
        if([self.orderApplyGame.seatNumber isEqualToString:@""])
        {
            self.showLabel.hidden = YES;
            [self.bgSomeLocationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(20);
                make.height.mas_equalTo(@0);
            }];
        }else
        { //有座位号，则添加座位号
            NSArray *arr = [self.orderApplyGame.seatNumber componentsSeparatedByString:@","];
            int h = arr.count/4+(((arr.count%4)==0)?0:1);
            for (int j = 0; j<h; j++) {
                for (int i = 0; i<4; i++) {
                    if(j*4+i>=arr.count)
                    {
                        break;
                    }
                    UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake((i+1)*30+i*60, 10*(j+1)+30*j, 60, 30) name:arr[j*4+i] font:[UIFont systemFontOfSize:17] textColor:WHITECOLOR];
                    label.layer.borderColor = WHITECOLOR.CGColor;
                    label.layer.borderWidth = 1;
                    label.layer.cornerRadius = 5;
                    [self.bgSomeLocationLabel addSubview:label];
                }
            }
        }
        
        self.shiJianCha = [ToolClass timeToToday:self.orderApplyGame.endDate];
//        NSSLog(@"倒计时中 = %@",[ToolClass timeFormatted:self.shiJianCha]);
        self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(timerDaoJiShi:) repeats:YES];
        [self.timer fire];
    }
}
-(void)timerDaoJiShi:(YYTimer*)timer
{
    self.timerLbael.text = [ToolClass timeFormatted:self.shiJianCha];
    self.shiJianCha = self.shiJianCha - 1;
}
- (IBAction)toPay:(UIButton*)btn{
    //TODO 传递参数给订单页面
    [[[EnrollGameObject alloc]init]choosePayTypeSuperVC:self.viewController vc:self.fvc intoType:self.type or:self.orderApplyGame tranAmount:self.orderApplyGame.tranAmount enrollCount:self.orderApplyGame.count eventId:@(self.orderApplyGame.eventId).description];
    //         ToPayView *pay =[[[NSBundle mainBundle]loadNibNamed:@"ToPayView" owner:self options:nil]firstObject];
    //               pay.orderValue = self.orderApplyGame;
    //               pay.detailLabel.text =  [NSString stringWithFormat:@"您共需要支付%@f元",self.orderApplyGame.tranAmount];
    //                pay.enrollCount = self.orderApplyGame.count;
    //                [self.viewController.view addSubview:pay];
    //                [pay mas_makeConstraints:^(MASConstraintMaker *make) {
    //                       make.left.equalTo(self.viewController.view.mas_left);
    //                       make.right.equalTo(self.viewController.view.mas_right);
    //                       make.top.equalTo(self.viewController.view.mas_top);
    //                       make.bottom.equalTo(self.viewController.view.mas_bottom);
    //                   }];
    
}

- (IBAction)cancelOrder:(UIButton*)btn{
    //取消订单
    [[ApiFetch share]orderGetFetch:ORDER_DELETE query:@{@"applicationCode":self.orderApplyGame.applicationCode} holder:self.viewController dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        [self.viewController makeToask:@""];
        if(self.type == 1)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"订单取消成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.viewController.navigationController popViewControllerAnimated:YES];
                if ([self.fvc respondsToSelector:@selector(getPageData)]) {
                    [self.fvc performSelector:@selector(getPageData)];//刷新赛事报名活动
                }
            }];
            [alert addAction:sure];
            [self.viewController presentViewController:alert animated:NO completion:^{
            }];
        }else if(self.type == 2){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"订单取消成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.viewController.navigationController popToViewController:self.fvc animated:YES];
                if ([self.fvc respondsToSelector:@selector(getGameAndActDetail)]) {
                    [self.fvc performSelector:@selector(getGameAndActDetail)];//刷新赛事报名活动
                }
            }];
            [alert addAction:sure];
            [self.viewController presentViewController:alert animated:NO completion:^{
            }];
            
        }
    }];
}
@end
