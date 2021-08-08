//
//  ApiFetch+Spot.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch+Spot.h"



@implementation ApiFetch (Spot)
-(void)spotGetFetch:(NSString *)url
              query:(NSDictionary *)params
             holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
          dataModel:(Class)dataModel
          onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/spot%@",url];
[self getFetch:path
         query:params
        holder:hoderVc
     dataModel:dataModel
     onSuccess:onSuccess];
}

-(void)spotPostFetch:(NSString *)url
                body:(NSDictionary *)params
              holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
           dataModel:(Class)dataModel
           onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/spot%@",url];
[self postFetch:path
           body:params
         holder:hoderVc
      dataModel:dataModel
      onSuccess:onSuccess];
}
@end
