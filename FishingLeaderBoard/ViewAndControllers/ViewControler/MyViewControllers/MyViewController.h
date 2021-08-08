//
//  MyViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FViewController.h"
#import "MyHeadView.h"
#import "MyTableViewCell.h"
#import "UserInfoViewController.h"
#import "MyDataObject.h"
#import "MyHuoDongViewController.h"
#import "MySectionHeadView.h"
#import "MyTwoQiHeadView.h"
#import "MyAllBottomView.h"
NS_ASSUME_NONNULL_BEGIN
@class UserPageInfo;
@interface MyViewController : FViewController

@property (nonatomic,strong) UITableView *userTableView;
@property (nonatomic,strong) MyHeadView *myHeadView;

@property(assign,nonatomic)FTabBarTypePage typePage;
@property(strong,nonatomic)UserPageInfo *userPageInfo;

@end

NS_ASSUME_NONNULL_END
