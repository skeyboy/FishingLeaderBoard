//
//  SpotAccountManageView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/17.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotAccountManageView : UIView
@property (weak, nonatomic) IBOutlet UIView *yearbgView;
- (IBAction)infoZongShouRu:(id)sender;

- (IBAction)infoZongZhiChu:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *zhongShouRuLabel;
@property (weak, nonatomic) IBOutlet UILabel *zongZhiChuLabel;
@property (weak, nonatomic) IBOutlet UIButton *weiKaiShiBtn;
@property (weak, nonatomic) IBOutlet UIButton *yiJieShuBtn;


@end

NS_ASSUME_NONNULL_END
