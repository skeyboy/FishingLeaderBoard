//
//  AlipaySDK+pay.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AlipaySDK+pay.h"
#import <objc/runtime.h>
@implementation AlipaySDK (pay)
#define ALI_Response_KEY @"YuAliPayResponse"
-(void)setPayResponse:(id<YuAliPayResponse>)payResponse{
    objc_setAssociatedObject(self, ALI_SCHEME, payResponse, OBJC_ASSOCIATION_ASSIGN);
}
-(id<YuAliPayResponse>)payResponse{
    id<YuAliPayResponse> response = objc_getAssociatedObject(self, ALI_SCHEME);
//    objc_removeAssociatedObjects(self);
    return response;
    
}
-(void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr callback:(CompletionBlock)completionBlock withResp:(id<YuAliPayResponse>)resp{
    self.payResponse = resp;
    [self payOrder:orderStr
        fromScheme:schemeStr
          callback:completionBlock];
}
@end
