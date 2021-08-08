//
//  ApiFetch+Order.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch+Order.h"



@implementation ApiFetch (Order)
-(void)orderGetFetch:(NSString *)url query:(NSDictionary *)params holder:(UIViewController *)hoderVc dataModel:(Class)dataModel onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
         NSString * path = [NSString stringWithFormat:@"/order%@",url];

 [self getFetch:path
          query:params
         holder:hoderVc
      dataModel:dataModel
      onSuccess:onSuccess];
}
-(void)orderPostFetch:(NSString *)url
                 body:(NSDictionary *)params holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
            dataModel:(Class)dataModel
            onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/order%@",url];

    [self postFetch:path
               body:params
             holder:hoderVc
          dataModel:dataModel
          onSuccess:onSuccess];
}
@end
