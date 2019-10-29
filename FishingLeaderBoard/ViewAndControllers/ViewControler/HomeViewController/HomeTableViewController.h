//
//  HomeTableViewController.h
//  FishingLeaderBoard
//  首页
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeadTableView.h"
#import "FViewController.h"
#import "SearchViewController.h"
#import "MainTableViewCell.h"
#import "MainOneTableViewCell.h"
#import "MainNoTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewController : FViewController

@property(strong,nonatomic)HomeHeadTableView *headView;
@property(strong,nonatomic)UITableView *tableView;

@property(assign,nonatomic)FPageHeadViewType headType;

@end

NS_ASSUME_NONNULL_END
