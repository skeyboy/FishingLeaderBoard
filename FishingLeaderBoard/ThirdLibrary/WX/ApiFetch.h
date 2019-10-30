//
//  ApiFetch.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class AppModel;
NS_ASSUME_NONNULL_BEGIN

@interface ApiFetch : NSObject
+(ApiFetch *)share;
-(void)postFetch:(NSString *) url
            body:(NSDictionary *)params
        onSuccess:(void(^)(AppModel * model, id responseObject  )) success onError:(void(^)(NSError * error, NSString * api)) failure;
-(void)getFetch:(NSString *) url
          query:(NSDictionary *) queries
       onSuccess:(void(^)(AppModel * model, id responseObject  )) success onError:(void(^)(NSError * error, NSString * api)) failure;
@end

NS_ASSUME_NONNULL_END
