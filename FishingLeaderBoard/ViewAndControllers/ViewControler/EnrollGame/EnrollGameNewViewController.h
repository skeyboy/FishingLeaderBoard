//
//  SaiShiBaoMingNewViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonCountView.h"
#import "IntegralRankTableViewController.h"
#import "JhFormTableViewVC.h"
#import "DetailCommonView.h"
NS_ASSUME_NONNULL_BEGIN

/// 赛事报名
@interface EnrollGameNewViewController : JhFormTableViewVC
@property(assign,nonatomic)NSInteger eventId;
@property(assign,nonatomic)BOOL isAct;
@property(assign,nonatomic)NSInteger isShenPi;//0,报名页面，1待审批，2已审批
@end

NS_ASSUME_NONNULL_END
