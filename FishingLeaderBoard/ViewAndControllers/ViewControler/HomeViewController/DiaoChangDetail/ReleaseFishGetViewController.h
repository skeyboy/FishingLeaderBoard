//
//  ReleaseFishGetViewController.h
//  FishingLeaderBoard
//  发布渔获
//  Created by yue on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^FaBuSuccessBlock)();
@interface ReleaseFishGetViewController : FViewController
@property(assign,nonatomic)NSInteger spotId;
@property(copy,nonatomic)FaBuSuccessBlock faBuSuccessBlock;
@end

NS_ASSUME_NONNULL_END
