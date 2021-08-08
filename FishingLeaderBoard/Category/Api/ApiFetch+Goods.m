//
//  ApiFetch+Exchange.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch+Goods.h"



@implementation ApiFetch (Goods)
-(void)goodsGetFetch:(NSString *)url query:(NSDictionary *)params holder:(UIViewController *)hoderVc dataModel:(Class)dataModel onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
         NSString * path = [NSString stringWithFormat:@"/goods%@",url];

 [self getFetch:path
          query:params
         holder:hoderVc
      dataModel:dataModel
      onSuccess:onSuccess];
}
-(void)goodsPostFetch:(NSString *)url
                 body:(NSDictionary *)params holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
            dataModel:(Class)dataModel
            onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
    NSString * path = [NSString stringWithFormat:@"/goods%@",url];

    [self postFetch:path
               body:params
             holder:hoderVc
          dataModel:dataModel
          onSuccess:onSuccess];
}
@end
