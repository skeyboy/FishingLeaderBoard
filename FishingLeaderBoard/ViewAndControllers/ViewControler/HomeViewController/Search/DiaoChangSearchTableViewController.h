//
//  DiaoChangSearchTableViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaoChangSearchTableViewCell.h"
#import "GRStarsView.h"
#import "SearchViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@interface DiaoChangSearchTableViewController : FViewController<SearchViewDelegate>
@property(nonatomic,strong)GRStarsView*starsView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)BOOL isDaiLiDiaoChang;
@end

NS_ASSUME_NONNULL_END
