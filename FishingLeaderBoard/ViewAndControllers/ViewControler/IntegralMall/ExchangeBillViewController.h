//
//  ExchangeBillViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExchangeBillViewController : FViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *bgHeadView;
@property (weak, nonatomic) IBOutlet UILabel *guiGeLabel;


@property(strong,nonatomic)NSString *orderStr;
@end

NS_ASSUME_NONNULL_END
