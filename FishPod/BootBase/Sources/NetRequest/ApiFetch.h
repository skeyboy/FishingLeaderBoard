//
//  ApiFetch.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ApiResult) {
    ApiResultOK = 200
    
};
@protocol ApiFetchOptionalHandler <NSObject>
@optional
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri;
-(BOOL)autoHudForLink:(NSString *) link;

@end

@class AppModel;
NS_ASSUME_NONNULL_BEGIN

@interface ApiFetch : NSObject
+(ApiFetch *)share;
-(void)postFetch:(NSString *) url
            body:(NSDictionary *)params
       onSuccess:(void(^)(AppModel * model, id responseObject  )) success
               onFailure:(void(^)(NSString * message, NSString * shortLink)) onFailure;
-(void)postFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess;

-(void)getFetch:(NSString *)url
          query:(NSDictionary *)params
         holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
      dataModel:(Class)dataModel
      onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess;
-(void)getFetch:(NSString *)api
          query:(NSDictionary *)queries
      onSuccess:(void (^)(AppModel  * _Nonnull modelValue, id _Nonnull))onSuccess
      onFailure:(void(^)(NSString * message, NSString * shortLink)) onFailure ;
-(void)upload:(UIImage *) image success:(void(^)(NSString *)) fileUrl failure:(void(^)(void)) failure;
@end
NS_ASSUME_NONNULL_END

