//
//  FaBuSaiShiViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/8.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreenLineTextField.h"
#import "XieYiViewController.h"
NS_ASSUME_NONNULL_BEGIN

/// 发布活动或者赛事
@interface FaBuSaiShiViewController : FViewController

@property(nonatomic,assign)BOOL isSaiShi;
@property(nonatomic,assign)BOOL isPublish;//是否支持发布赛事

@end

NS_ASSUME_NONNULL_END
