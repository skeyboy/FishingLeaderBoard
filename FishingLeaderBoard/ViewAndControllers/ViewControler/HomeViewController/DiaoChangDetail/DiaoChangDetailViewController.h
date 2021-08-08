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
#import "BuHuoTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, FPageDCDCellType) {
    FPageDCDAct                 =0,                      //!<活动/赛事
    FPageDCDJianJie             =1,                      //!<简介
    FPageDCDFishGet             =2                       //!<渔获
};
@interface DiaoChangDetailViewController : FViewController

@property(strong,nonatomic)DiaoChangDetailHeadView *headView;
@property(strong,nonatomic)UITableView *tableView;
@property(assign,nonatomic)FPageDCDCellType cellType;
@property(nonatomic) NSInteger spotId;

@end

NS_ASSUME_NONNULL_END
