//
//  RankViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/2/23.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YingXiongBangViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface RankViewController : UIViewController
@property (weak, nonatomic) UIView *jieTuV;
@property(strong,nonatomic)NSArray *paimingLists;
@property(strong,nonatomic)NSString *nameStr;

@end

NS_ASSUME_NONNULL_END
