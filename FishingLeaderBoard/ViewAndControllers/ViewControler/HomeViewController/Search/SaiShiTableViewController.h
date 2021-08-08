//
//  SaiShiTableViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaiShiTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SaiShiTableViewController : UITableViewController<SearchViewDelegate>
//2:赛事 3：活动
@property(assign,nonatomic)NSInteger pageType;
@end

NS_ASSUME_NONNULL_END
