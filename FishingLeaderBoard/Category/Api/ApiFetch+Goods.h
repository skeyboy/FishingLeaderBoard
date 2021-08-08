//
//  ApiFetch+Exchange.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//



#import "ApiFetch.h"
NS_ASSUME_NONNULL_BEGIN
#define GOODS_GETTYPE @"/exchange/getType"//获取商品分类
#define GOODS_GETLIST @"/exchange/getList"//获取商品列表
#define GOODS_GEDETAIL @"/exchange/getDetail"//获取商品详情
#define GOODS_GETLISTSPOT @"/exchange/listSpot" //获取钓场列表
#define GOODS_PREORDER @"/buy/preOrder"//商品预下单
#define GOODS_ORDERDETAIL @"/buy/detailOrder"//获取订单详情
#define GOODS_ORDERLISTS @"/buy/listOrder"//订单列表
#define GOODS_GETADRESS @"/exchange/getAddress"//获取地址
#define GOODS_CONFIRMORDER @"/buy/confirmOrder"//确认订单支付
#define GOODS_COLLECT @"/exchange/collect"//收藏和取消商品
#define BUSSINESS_CURRENCY_ORDER @"/business/currencyOrder"   //查询商户积分订单列表
#define BUSSINESS_CONFIRM_EXCHANGE  @"/business/confirmExchange" //商户确认积分订单提货
#define BUSSINESS_DETAIL_EXCHANGE  @"/business/detailExchange" //商户查看积分订单提货状态详情
#define BUSSINESS_LISTSTOCK @"/business/listStock" //GET 查看商户库存
@interface ApiFetch (Goods)
-(void)goodsGetFetch:(NSString *_Nullable) url
              query:(NSDictionary *_Nullable)params
             holder:(UIViewController<ApiFetchOptionalHandler>*) hoderVc
          dataModel:(Class) dataModel
          onSuccess:(void (^)(NSObject  * _Nonnull modelValue, id _Nonnull responseObject))onSuccess;
-(void)goodsPostFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
@end

NS_ASSUME_NONNULL_END
