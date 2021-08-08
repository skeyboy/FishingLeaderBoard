//
//  SaiShiListTableViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaiShiListTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SaiShiListTableViewController : UITableViewController
@property(assign,nonatomic)NSInteger currentGamePage;
@property(strong,nonatomic)NSMutableArray *eventGames;
@property(strong,nonatomic)NSMutableDictionary *preRequest;
@property(assign,nonatomic)NSInteger GameOrAct;//1:活动，2赛事
@property(strong,nonatomic)NSString *chooseTimeS;
@property(strong,nonatomic)NSString *adCode;

-(void)changeTab;

@end

NS_ASSUME_NONNULL_END
