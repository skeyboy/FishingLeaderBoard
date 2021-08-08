//
//  FAgentViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAgentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UIView *headView1;
@property (weak, nonatomic) IBOutlet UIView *headView2;


@end

NS_ASSUME_NONNULL_END
