//
//  SendDataClass.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SendDataClass.h"

@implementation SendDataClass
+(void)sendDataType:(int)flag count:(NSString*)count eventId:(NSInteger)eventId price:(NSString*)price money:(NSString*)money vc:(UIViewController*)vc back:(SuccessBlock)success
{//flag （1：新增收鱼支出，2：新增鱼票收入，3：减少鱼量，4：增加鱼量）
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
       [dict setValue:@(eventId) forKey:@"eventId"];
       [dict setValue:@(flag) forKey:@"flag"];
    [dict setValue:count forKey:@"count"];
    [dict setValue:price forKey:@"price"];
    [dict setValue:money forKey:@"money"];
    NSLog(@"canshuzhichu = %@",dict);
    
       [[ApiFetch share]orderGetFetch:ORDER_account_add_fishing query:dict holder:vc dataModel:[NSDictionary class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
           success();
       }];
}
+(void)sendDataType:(int)flag remark:(NSString*)remark eventId:(NSInteger)eventId money:(NSString*)money vc:(UIViewController*)vc back:(SuccessBlock)success
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
        [dict setValue:@(eventId) forKey:@"eventId"];
        [dict setValue:@(flag) forKey:@"flag"];
     [dict setValue:remark forKey:@"remark"];
     [dict setValue:money forKey:@"money"];
        [[ApiFetch share]orderGetFetch:ORDER_account_add_other query:dict holder:vc dataModel:[NSDictionary class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            success();
        }];
}
@end
