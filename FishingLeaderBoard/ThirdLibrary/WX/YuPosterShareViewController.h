//
//  YuPosterShareViewController.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuPosterShareViewController : UIViewController
@property(copy, nonatomic) NSString * title;
@property(copy, nonatomic) NSString *desc;
@property(copy, nonatomic) NSString *url;
@property(copy,nonatomic) SpotInfo *spotInfo;
@property (weak, nonatomic) IBOutlet UIImageView *qrImagView;


@end

NS_ASSUME_NONNULL_END
