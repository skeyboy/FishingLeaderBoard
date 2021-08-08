//
//  BuyFishObject.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YuQrViewController.h"
#import "SellerViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuyFishObject : NSObject<YuAliPayResponse,YuWXPayResponse>
@property(strong,nonatomic)UIViewController *vc;
-(void)buyFish:(YuQrViewController*)qrScanVC sellerID:(NSString*)sellerId vc:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
