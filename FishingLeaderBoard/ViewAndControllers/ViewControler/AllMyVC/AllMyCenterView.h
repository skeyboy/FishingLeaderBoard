//
//  AllMyCenterView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllMyCenterView : UIView
-(instancetype)initWithFrame:(CGRect)frame typePage:(FTabBarTypePage)typePage  data:(UserPageInfo *)userPageInfo;
@property(strong,nonatomic)UserPageInfo *userPageInfo;
;
@end

NS_ASSUME_NONNULL_END
