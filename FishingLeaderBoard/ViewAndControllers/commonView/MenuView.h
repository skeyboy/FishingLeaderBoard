//
//  MenuView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/23.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonMenuClick) (int);

@interface MenuView : UIView

@property(nonatomic,strong)ButtonMenuClick menuClick;


//colorArr和nameArr都只支持3个数组，不能为空上面两个下标依次对应1，2，最下面对应0
-(instancetype)initWithFrame:(CGRect)frame name:(NSArray *)nameArr color:(NSArray *)colorArr;


@end

NS_ASSUME_NONNULL_END
