//
//  AFHTTPSessionManager+Network.m
//  BootBase
//
//  Created by sk on 2021/8/7.
//
#import "AFHTTPSessionManager+Network.h"

@implementation AFHTTPSessionManager (Network)


- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    return   [self POST:URLString
    parameters:parameters
       headers:nil
      progress:uploadProgress
       success:success
       failure:failure];
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    return [self POST:URLString
    parameters:parameters
       headers:nil
constructingBodyWithBlock:block
      progress:uploadProgress
       success:success failure:failure];
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                     progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    return  [self GET:URLString parameters:parameters
       headers:nil progress:downloadProgress success:success failure:failure];
}
@end
