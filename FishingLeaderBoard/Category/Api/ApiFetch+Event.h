//
//  ApiFetch+Event.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/24.
//  Copyright © 2019 yue. All rights reserved.
//



#import "ApiFetch.h"

NS_ASSUME_NONNULL_BEGIN


#define EVENT_DAILISHENPI @"/approval/idList"
//GET /searchEvent/commissioner
#define EVENT_DAILISAISHI @"/searchEvent/commissioner"


//GET /searchEvent/model
#define EVENT_EVENTMODEL @"/searchEvent/model"
//GET /searchEvent/canUse
#define EVENT_GETTYPE @"/searchEvent/canUse"

//GET /searchEvent/model
#define EVENT_BY_USERID @"/searchEvent/model"
//GET /collect/focus
#define EVENT_STORE @"/collect/focus"
#define EVENT_STORE_CANCEL @"/collect/cancel"
/// POST add/info
#define EVENT_ADD_INFO @"/saveEvent/addNew"
//通过钓场获取活动和赛事
#define EVENT_SEARCHEVENT_BYSPOTID  @"/searchEvent/getBySpotId"
//通过USERID 获取当前用户的总金额
#define EVENT_GETMONEY_FOR_MYPAGE @"/currency/getByUserId"
//根据城市获取赛事列表
#define EVENT_GETLIST_BYCITY @"/searchEvent/getByCity"
//根据赛事活动ID 显示详情页
#define EVENT_DETAIL_BYID @"/searchEvent/getByEventId"

//GET /currency/refresh 首页刷新会员卡及积分
#define  EVENT_CURRENCY_REFRESH @"/currency/refresh"

//GET 首页积分列表数据
#define EVENT_RECOMMEND @"/currency/recommend"
#define EVENT_CARD_LEVEL  @"/currency/cardLevel"
@interface ApiFetch (Event)
-(void)eventGetFetch:(NSString *)url
              query:(NSDictionary *)params
             holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
          dataModel:(Class)dataModel
          onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
-(void)eventPostFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
@end

NS_ASSUME_NONNULL_END
