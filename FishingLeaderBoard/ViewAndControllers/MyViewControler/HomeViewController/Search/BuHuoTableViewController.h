//
//  BuHuoTableViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuHuoTableViewCell.h"
#import "DiaoChangHeadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuHuoTableViewController : FViewController

@property(assign,nonatomic)FPageType pageType;
@property(strong,nonatomic)UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
