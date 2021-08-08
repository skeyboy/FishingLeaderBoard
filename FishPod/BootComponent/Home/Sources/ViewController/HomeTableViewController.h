//
//  HomeTableViewController.h
//  FishingLeaderBoard
//  首页
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FViewController.h"
//#import "SearchViewController.h"
#import "MainTableViewCell.h"
#import "MainOneTableViewCell.h"
#import "MainNoTableViewCell.h"
#import "HomeNewHeadTableView.h"
#import <BMKLocationKit/BMKLocation.h>
//#import "EnrollGameNewViewController.h"
//#import "IntegralMallViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewController : FViewController

@property(strong,nonatomic)HomeNewHeadTableView *headView;
@property(strong,nonatomic)UITableView *tableView;
@property(nonatomic)__block BMKLocationReGeocode * _Nullable rgcData;
@property(strong,nonatomic)__block CLLocation * _Nullable location;


@end

NS_ASSUME_NONNULL_END
