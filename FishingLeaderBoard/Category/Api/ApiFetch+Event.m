//
//  ApiFetch+Event.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch+Event.h"

@implementation ApiFetch (Event)
-(void)eventGetFetch:(NSString *)url
               query:(NSDictionary *)params
              holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
           dataModel:(Class)dataModel
           onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/event%@",url];
    [self getFetch:path
             query:params
            holder:hoderVc
         dataModel:dataModel
         onSuccess:onSuccess];
}

-(void)eventPostFetch:(NSString *)url
                 body:(NSDictionary *)params
               holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
            dataModel:(Class)dataModel
            onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/event%@",url];
    [self postFetch:path
               body:params
             holder:hoderVc
          dataModel:dataModel
          onSuccess:onSuccess];
}
@end
