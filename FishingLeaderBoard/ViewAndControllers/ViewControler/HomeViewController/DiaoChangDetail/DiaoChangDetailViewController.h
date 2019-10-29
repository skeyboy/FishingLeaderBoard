//
//  DiaoChangDetailViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaoChangDetailHeadView.h"
#import "DiaoChangDetailTableViewCell.h"
#import "DCDBriefTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface DiaoChangDetailViewController : FViewController

@property(strong,nonatomic)DiaoChangDetailHeadView *headView;
@property(strong,nonatomic)UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
