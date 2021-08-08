//
//  SearchViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"
#import "DiaoChangSearchTableViewController.h"
#import "SaiShiTableViewController.h"
#import "BuHuoTableViewController.h"
#import "UserTableViewController.h"
#import "SearchViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : FViewController

@property(weak,nonatomic)id<SearchViewDelegate>searchDelegate;

@end

NS_ASSUME_NONNULL_END
