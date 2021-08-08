//
//  YuRankShareViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/16.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuRankShareViewController : UIViewController
@property(copy, nonatomic) UIImage *rankImage;
@property(copy, nonatomic) NSString * downloadUrl;
@property(strong,nonatomic)NSArray *paimingLists;
@property(strong,nonatomic)NSString *nameStr;

@end

NS_ASSUME_NONNULL_END
