//
//  IntegralMallHeaderView.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralMallHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (weak, nonatomic) IBOutlet UIView *bgHeadView;

@property (weak, nonatomic) IBOutlet UIButton *recodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *sortBtn;

@property (weak, nonatomic) IBOutlet UIView *bgZiTiChooseView;



- (IBAction)recoderClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;

@end

NS_ASSUME_NONNULL_END
