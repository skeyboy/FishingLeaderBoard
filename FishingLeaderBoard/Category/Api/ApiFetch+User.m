//
//  ApiFetch+User.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch+User.h"

#import "UIView+Toast.h"
#import "UIViewController+ShowHud.h"

@implementation ApiFetch (User)

-(void)userGetFetch:(NSString *)url
               query:(NSDictionary *)query
           onSuccess:(void (^)(AppModel  * _Nonnull modelValue, id _Nonnull responseObject))onSuccess
               onFailure:(void(^)(NSString * message, NSString * shortLink)) onFailure{
    NSString * path = [NSString stringWithFormat:@"/user%@",url];
    [self getFetch:path
             query:query
         onSuccess:onSuccess
           onFailure:onFailure];
}
-(void)userGetFetch:(NSString *)url
              query:(NSDictionary *)params
             holder:(UIViewController *)hoderVc
          dataModel:(nonnull Class)dataModel
          onSuccess:(nonnull void (^)(NSObject * _Nonnull dataModel, id _Nonnull responseObject))onSuccess{
    @weakify(hoderVc)
    
    [weak_hoderVc showDefaultLoading];
    [self userGetFetch:url query:params
             onSuccess:^(AppModel * _Nonnull modelValue, id  _Nonnull responseObject) {
        [weak_hoderVc hideHud];
        NSObject * dataValue = [modelValue dataFor:dataModel];
 
        onSuccess(dataValue , responseObject);
        NSLog(@"%@",responseObject);
        NSLog(@"model = %@",dataValue.mj_keyValues);
    } onFailure:^(NSString * _Nonnull message, NSString * _Nonnull shortLink) {
        [weak_hoderVc hideHud];
//        [weak_hoderVc.view makeToast:message];
    }];
}
/// 根据给定的url 和模型返回制定的数据模型
/// @param url 短url
/// @param params 请求参数
/// @param hoderVc 网络请求所在的VC
/// @param dataModel 返回data转换后的模型
/// @param onSuccess w我们只关注数据成功，w内部处理失败
-(void)userPostFetch:(NSString *)url
                 body:(NSDictionary *)params holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
            dataModel:(Class)dataModel
            onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/user%@",url];

    [self postFetch:path
               body:params
             holder:hoderVc
          dataModel:dataModel
          onSuccess:onSuccess];
}
@end
