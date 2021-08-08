//
//  CostomProgressView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CostomProgressView : UIView

@property(strong,nonatomic)UIProgressView *progressView;

-(void)setProgressView:(float)progress arr:(NSArray *)arrLabelTexts;

@end

NS_ASSUME_NONNULL_END
