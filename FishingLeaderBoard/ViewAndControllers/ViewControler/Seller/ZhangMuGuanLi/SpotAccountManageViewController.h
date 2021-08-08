//
//  SpotAccountManageViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/17.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotAccountManageViewController : FViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property(assign,nonatomic)BOOL isFlash;//当页面重新显示时，是否需要刷新

@end

NS_ASSUME_NONNULL_END
