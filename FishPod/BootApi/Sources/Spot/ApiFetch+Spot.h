//
//  ApiFetch+Spot.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//



#import "ApiFetch.h"

NS_ASSUME_NONNULL_BEGIN
//POST /commissioner/apply/add/info
#define SPOT_DAILIREN_ADD @"/commissioner/apply/add/info"
///GET  task/commissioner/info  查询代理人页面累计赚取金额/账目管理页面收入
#define SPOT_AGENT_TASK_INFO @"/task/commissioner/info"
//GET /task/by/user/id 根据钓场id查询代理人信息(内部使用
#define SPOT_TASK_BY_USER_ID @"/task/by/user/id"
//代理钓场
#define SPOT_DAILILIST @"/commissioner/list"

//钓场添加钓坑
#define SPOT_ADDPOND @"/fishpond/add"
//GET /fishpond/by/id
#define SPOT_PONDBYID @"/fishpond/by/id"
//GET /fishpond/by/user/id
#define SPOTPOND_BYUSERID @"/fishpond/by/user/id"
//GET /fishpond/delete
#define SPOT_PONDDELETE @"/fishpond/delete"
//POST /fishpond/update
#define SPOT_PONDUPDATE @"/fishpond/update"






//GET /getSpot/byUser
#define SPOTID_BYUSER @"/getSpot/byUser"
///GET 钓场收藏
#define SPOT_STORE @"/collect/focus"
//GET /collect/cancel
#define SPOT_STORE_CANCEL @"/collect/cancel"
//查询是否支持发布赛事或活动
#define SPOT_IS_PUBLISH  @"/is/publish"

/// POST add/info
#define SPOT_ADD_INFO @"/add/info"
//POST /update/info
#define SPOT_UPDATE_INFO @"/update/info"

//GET /api/byId 根据钓场id查询钓场信息
#define SPOT_DETAIL_BY_ID @"/api/byId"

// GET  /getEvent/byUserId 根据token查询钓场页面信息
#define SPOT_EVENT_USER  @"/getEvent/byUserId"

//周边钓场
#define SPOT_SURROUNDING_SPOTS @"/info"
//热门钓场
#define SPOT_HOT_SPOTS @"/hot/info"


//GET /lng/lat/list 当前定位查询30公里内钓场
#define SPOT_MAP @"/lng/lat/list"
@interface ApiFetch (Spot)
-(void)spotGetFetch:(NSString *)url
              query:(NSDictionary *)params
             holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
          dataModel:(Class)dataModel
          onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
-(void)spotPostFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
@end

NS_ASSUME_NONNULL_END
