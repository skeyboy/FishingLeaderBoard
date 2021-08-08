//
//  IntegralRankTableViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRankTableViewController : FViewController
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSArray *paimingLists;
@property(strong,nonatomic)NSString *nameStr;
@end

NS_ASSUME_NONNULL_END
