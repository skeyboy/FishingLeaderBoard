//
//  MyTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RightBtnClick)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (copy, nonatomic) RightBtnClick rightBtnClick;
- (IBAction)rightClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
