//
//  LeftViewBottomLineField.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface LeftViewBottomLineField : UITextField
@property(copy, nonatomic)IBInspectable NSString * leftTitle;
@property(copy,nonatomic)IBInspectable UIColor* bottomLineColor;
@property(nonatomic, nonatomic) IBInspectable NSInteger  lineWeight;
@end

NS_ASSUME_NONNULL_END
