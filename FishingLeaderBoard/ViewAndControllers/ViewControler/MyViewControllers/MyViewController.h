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
NS_ASSUME_NONNULL_BEGIN

@interface MyViewController : FViewController

@property (nonatomic,strong) UITableView *userTableView;
@property (nonatomic,strong) MyHeadView *myHeadView;

@end

NS_ASSUME_NONNULL_END
