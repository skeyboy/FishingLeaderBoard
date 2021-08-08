//
//  DiaoChangListViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiaoChangListViewController : UIViewController
@property(strong,nonatomic)UITableView*tableView;
-(void)userSelect:(NSString *) cityName cityId:(NSString *) cityId;
@end

NS_ASSUME_NONNULL_END
