//
//  YuShareGameViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuShareGameViewController : UIViewController
@property(assign,nonatomic)BOOL isOrder;
@property(copy, nonatomic) EventGameDetail *eventGameDetail;

@property (weak, nonatomic) IBOutlet UIImageView *min_appImg;

@end

NS_ASSUME_NONNULL_END
