//
//  LZCustomTabbar.h
//  WebViewTest
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickBlock)(UIButton* btn);
NS_ASSUME_NONNULL_BEGIN

@interface LZCustomTabbar : UITabBar
@property (nonatomic, copy) ClickBlock btnClickBlock;
+(void)setTabBarUI:(NSArray*)views tabBar:(UITabBar*)tabBar topLineColor:(UIColor*)lineColor backgroundColor:(UIColor*)backgroundColor;
@end

NS_ASSUME_NONNULL_END
