//
//  ApiFetch+Info.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

 

#import "ApiFetch.h"

NS_ASSUME_NONNULL_BEGIN

//POST /search/byType 首页搜索
#define INFO_SEARCH @"/search/byType"

//POST /pub/fishCatch 发布渔获
#define INFO_FISHGET @"/pub/fishCatch"
//GET 首页轮播图
#define INFO_HOME_BANNER @"/homepage/getBanner"
//get 首页获取地理位置[首页显示天气]
#define INFO_HOME_GEOGRAPHY @"/homepage/getGeography"
//GET /list/fishCatchBySpot 根据钓场id获取鱼获
#define INFO_FISH_CATCH @"/list/fishCatchBySpot"
//GET 分页获取最新/最热资讯
#define  INFO_NEW_HOT @"/shortInfo/getNewHot" //添加参数
//根据钓场ID 获取渔获
#define INFO_FISHGET_BYSPOTID @"/list/fishCatchBySpot"
//资讯
@interface ApiFetch (Info)
-(void)infoGetFetch:(NSString *_Nullable) url
    query:(NSDictionary *_Nullable)params
   holder:(UIViewController<ApiFetchOptionalHandler>*) hoderVc
dataModel:(Class) dataModel
onSuccess:(void (^)(NSObject  * _Nonnull modelValue, id _Nonnull responseObject))onSuccess;
-(void)infoPostFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
@end

NS_ASSUME_NONNULL_END
