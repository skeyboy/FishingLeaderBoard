//
//  ApiFetch.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch.h"
#import "YYModel.h"
#import "AFNetworking.h"
#import "AppManager.h"
#import "AppModel.h"
#define HOST @""
#define PORT 8080
@interface ApiFetch()

@end
@implementation ApiFetch
+(ApiFetch *)share{
    static dispatch_once_t onceToken;
    static ApiFetch *apiFetch  ;
    dispatch_once(&onceToken, ^{
        apiFetch = [[ApiFetch alloc] init];
    });
    return apiFetch;
}
-(void)postFetch:(NSString *)api
            body:(NSDictionary *)params
       onSuccess:(nonnull void (^)(AppModel  * _Nonnull modelValue, id responseObject)) success  onError:(nonnull void (^)(NSError * _Nonnull, NSString * _Nonnull))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:[AppManager manager].token
                     forHTTPHeaderField:@"token"];
    NSString * url = [NSString stringWithFormat:@"%@:%d%@",HOST,PORT,api];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AppModel *modelValue =   [AppModel yy_modelWithJSON:responseObject];
        if (success) {
            success(modelValue,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,api);
    }];
}

-(void)getFetch:(NSString *)api
          query:(NSDictionary *)queries
      onSuccess:(void (^)(AppModel  * _Nonnull modelValue, id _Nonnull))success
        onError:(void (^)(NSError * _Nonnull, NSString * _Nonnull))failure{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:[AppManager manager].token
                     forHTTPHeaderField:@"token"];
    NSString * url = [NSString stringWithFormat:@"%@:%d%@",HOST,PORT,api];
    [manager GET:url
      parameters:queries
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AppModel *modelValue =   [AppModel yy_modelWithJSON:responseObject];
        if (success) {
            success(modelValue,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,api);
        }
    }];
}
@end
