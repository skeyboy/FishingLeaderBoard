//
//  PARingView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PARingView : UIView
-(instancetype)initWithFrame:(CGRect)frame scales:(NSArray *)scales colors:(NSArray*)colors radius:(CGFloat)radius colorCenter:(UIColor*)color isFill:(BOOL)isFill;
@end

NS_ASSUME_NONNULL_END
