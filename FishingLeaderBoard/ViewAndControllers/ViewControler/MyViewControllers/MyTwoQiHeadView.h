//
//  MyTwoQiHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/3/23.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyTwoQiHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *xiugaiziliaoBtn;
- (IBAction)xiugaiziliaoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bgheadView;



@end

NS_ASSUME_NONNULL_END
