//
//  MySectionHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/3/23.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySectionHeadView : UIView
- (IBAction)toQianBao:(id)sender;
- (IBAction)toDaiJinQuan:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *jiELabel;
@property (weak, nonatomic) IBOutlet UILabel *daiJinQuanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *daijinquanImageView;

@property (weak, nonatomic) IBOutlet UIImageView *qiaoBaoImageView;
@end

NS_ASSUME_NONNULL_END
