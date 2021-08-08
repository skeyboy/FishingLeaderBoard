//
//  ExchangeBillViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ExchangeBillViewController.h"
#import "YuQrCreateHelper.h"
#import "UIImageView+QR.h"
@interface ExchangeBillViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

/// 取货二维码
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

/// 物流信息
@property (weak, nonatomic) IBOutlet UILabel *logisticsInfo;

/// 配送位置
@property (weak, nonatomic) IBOutlet UILabel *fishSpotInfo;

/// 物流状态
@property (weak, nonatomic) IBOutlet UILabel *logisticsState;

/// 地理定位
@property (weak, nonatomic) IBOutlet UILabel *locationInfo;


@property (weak, nonatomic) IBOutlet UILabel *goodsNameView;

/// 积分花费
@property (weak, nonatomic) IBOutlet UILabel *enrollCostView;
//兑换数量
@property (weak, nonatomic) IBOutlet UILabel *exchangeTotalView;

/// 配送方式
@property (weak, nonatomic) IBOutlet UILabel *deliveryType;

/// 买家留言
@property (weak, nonatomic) IBOutlet UILabel *userMarkView;
@property (weak, nonatomic) IBOutlet UILabel *deliveryMoney;

/// 实付积分
@property (weak, nonatomic) IBOutlet UILabel *realCostView;
//订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderSerial;

/// 订单创建时间
@property (weak, nonatomic) IBOutlet UILabel *orderCreateTime;

@property(strong,nonatomic)GoodsOrderDetail *goodsOrderDetail;

@end

@implementation ExchangeBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"商品订单详情" isShowBack:NO];
    self.bgHeadView.backgroundColor = NAVBGCOLOR;
    [hkNavigationView setNavBarViewLeftBtnWithNormalImage:@"nav_back_nor"
                                                highlightedImage:@"nav_back_nor"
                                                          target:self
                                                   action:@selector(btnClickBack:)];
  
    [self getOrderData];
}
-(void)getOrderData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:self.orderStr forKey:@"code"];
    [[ApiFetch share]goodsGetFetch:GOODS_ORDERDETAIL query:dict holder:self dataModel:GoodsOrderDetail.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        GoodsOrderDetail *goodsOrderDetail = (GoodsOrderDetail *) modelValue;
        self.goodsOrderDetail = goodsOrderDetail;
        [self addDataToView];
    }];
    
}
-(void)addDataToView
{
    Order *order = self.goodsOrderDetail.order;
    Goods *goods = self.goodsOrderDetail.goods;
    if(order.receiveType == 1)//自提
    {
        self.fishSpotInfo.text = [NSString stringWithFormat:@"自提钓场：%@",self.goodsOrderDetail.spotName];
//        `status` int(4) DEFAULT NULL COMMENT '订单状态（1：待支付，2：待提货，3：已完成，4：交易失败）'
        self.logisticsState.text = [NSString stringWithFormat:@"订单状态：%@",(order.status ==1)?@"待支付":(order.status == 2)?@"待提货":(order.status == 3)?@"已完成":@"h交易失败"];
        self.deliveryType.text =@"买家自提";
        self.deliveryMoney.text = @"免费";

    }else{//快递到家
        self.fishSpotInfo.text = [NSString stringWithFormat:@"快递到家"];
        self.logisticsState.text = [NSString stringWithFormat:@"订单状态：%@",(order.status ==1)?@"待支付":(order.status == 2)?@"待提货":(order.status == 3)?@"已完成":@"h交易失败"];
        self.deliveryType.text =@"快递到家";
        self.deliveryMoney.text = @"20元";

    }
    self.locationInfo.text = [NSString stringWithFormat:@"详细地址：%@",self.goodsOrderDetail.address];
    IMAGE_LOAD(self.imageView, goods.coverImg);
    self.goodsNameView.text = goods.name;
    self.enrollCostView.text = [NSString stringWithFormat:@"%ld积分",goods.price];
    self.exchangeTotalView.text = @(order.number).description;
    self.userMarkView.text = order.remark;
    self.realCostView.text = [NSString stringWithFormat:@"%ld积分",order.currency];
    self.orderSerial.text =[NSString stringWithFormat:@"订单编号：%@", order.code];
    self.orderCreateTime.text =[NSString stringWithFormat:@"创建时间：%@", [ToolClass dateToString:order.createTime]];
    NSError *qrCreateError = nil;
      self.qrImageView.image =  [YuQrCreateHelper createQr:order.code imageSize:self.qrImageView.frame.size
                          withError:&qrCreateError];
      if (NSCoreDataError==nil) {
             [self showWithInfo:@"二维码生成出错" delayToHideAfter:0.75];
         }
    self.guiGeLabel.text = self.goodsOrderDetail.selectSku;
}
-(void)btnClickBack:(UIButton*)btn
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



@end
