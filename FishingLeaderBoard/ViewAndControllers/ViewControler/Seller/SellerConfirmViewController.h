//
//  SellerConfirmViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
///商家扫码确认商品兑换
NS_ASSUME_NONNULL_BEGIN

@interface SellerConfirmViewController : FViewController
@property(copy,nonatomic) NSString * code;///商品对应的二维码code
@end

NS_ASSUME_NONNULL_END
