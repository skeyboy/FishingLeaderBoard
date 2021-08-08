//
//  ApiFetch+Order.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

 

#import "ApiFetch.h"

NS_ASSUME_NONNULL_BEGIN
//钓场主账目管理
//查询修改放鱼量时查询的鱼种信息和单价
#define ORDER_account_fish_price @"/account/fish/and/price"

//钓场主账目管理页(总收入和总支出
 #define ORDER_account_elist_total @"/account/event/list/total"
//钓场主账目管理页下面列表
#define ORDER_account_elist @"/account/event/list"

//赛事活动账目详情下部分（收支记录）
#define ORDER_account_all_list @"/account/all/list"
//赛事活动账目详情上部分（除收支记录）
#define ORDER_account_all_detail @"/account/all/detail"
//新增其它收入/新增其它支出
#define ORDER_account_add_other @"/account/add/other"

//新增鱼票收入/新增收鱼支出/减少鱼量/增加鱼量
#define ORDER_account_add_fishing @"/account/add/fishing"

//GET /manager/info/list 代理人账目管理列表
#define ORDER_AGENT_MANAGER_INFO @"/manager/info/list"
//GET
#define EVENT_CURRENTLIST @"/event/current/list"
#define EVENT_NEWCURRENTLIST @"/event/current/new/list"

//POST /balance/select/info个人账户信息
#define ORDER_ACCOUNT @"/balance/select/info"
//POST /balance/transfer/money买鱼
#define ORDER_BUYFISH @"/balance/transfer/money"
//GET /application/delete/enroll订单删除
#define ORDER_DELETE @"/application/delete/enroll"
///application/enroll/list报名订单列表
#define ORDER_ENROLL_LIST  @"/application/enroll/list"

// POST /balance/withdraw/money 提现
#define ORDER_CASHOUT_MONEY @"/balance/withdraw/money"
//POST /application/enroll/pay 报名付款
#define ORDER_ENROLL_PAY @"/application/enroll/pay"

//POST 报名下单
#define ORDER_APPLY_GAME @"/application/apply/game"

//POST /balance/recharge/money 钱包充值
#define Order_CHARGE_WALLET @"/balance/recharge/money"
//支付宝schem
@interface ApiFetch (Order)
-(void)orderGetFetch:(NSString *_Nullable) url
              query:(NSDictionary *_Nullable)params
             holder:(UIViewController<ApiFetchOptionalHandler>*) hoderVc
          dataModel:(Class) dataModel
          onSuccess:(void (^)(NSObject  * _Nonnull modelValue, id _Nonnull responseObject))onSuccess;
-(void)orderPostFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
@end

NS_ASSUME_NONNULL_END
