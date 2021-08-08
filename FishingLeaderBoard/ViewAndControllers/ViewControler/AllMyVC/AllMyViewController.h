//
//  AllMyViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JhFormTableViewVC.h"
NS_ASSUME_NONNULL_BEGIN

/// 我的页面 ，（游客商家代理）
@interface AllMyViewController : JhFormTableViewVC

@property(assign,nonatomic)FTabBarTypePage typePage;
@property(strong,nonatomic)UserPageInfo *userPageInfo;

@end

NS_ASSUME_NONNULL_END
