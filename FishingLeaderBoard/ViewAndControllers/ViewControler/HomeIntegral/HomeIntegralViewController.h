//
//  HomeIntegralViewController.h
//  WKDemo
//
//  Created by 李雨龙 on 2020/4/6.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralMallViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeIntegralViewController : FViewController
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

IB_DESIGNABLE @interface HomeIntegralCirCleView : UIView
@property(nonatomic, assign)IBInspectable CGFloat gameUse;
@property(copy)IBInspectable UIColor* gameUseColor;

@property(assign)IBInspectable CGFloat gameRank;
@property(copy)IBInspectable UIColor* gameRankColor;

@property(assign)IBInspectable CGFloat activeUse;
@property(copy)IBInspectable UIColor* activeUseColor;

@property(copy)IBInspectable UIColor* angleDefaultColor;


@end
NS_ASSUME_NONNULL_END
