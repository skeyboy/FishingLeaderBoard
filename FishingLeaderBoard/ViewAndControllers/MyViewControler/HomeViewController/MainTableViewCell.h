//
//  MainTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeLabel;

@end

NS_ASSUME_NONNULL_END
