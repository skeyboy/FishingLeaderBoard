//
//  MySelButton.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySelButton : UIButton
@property(assign,nonatomic)BOOL isChoosed;
@property(strong,nonatomic)NSString *str;
@end

NS_ASSUME_NONNULL_END
