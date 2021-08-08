//
//  AlipaySDK+pay.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import <AlipaySDK/AlipaySDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlipaySDK (pay)
@property(nonatomic) id<YuAliPayResponse> payResponse;
- (void)payOrder:(NSString *)orderStr
fromScheme:(NSString *)schemeStr
        callback:(CompletionBlock)completionBlock
        withResp:(id<YuAliPayResponse>) resp;
@end

NS_ASSUME_NONNULL_END
