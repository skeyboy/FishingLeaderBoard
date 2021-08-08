//
//  PKYStepper+Default.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//



#import <PKYStepper/PKYStepper.h>

NS_ASSUME_NONNULL_BEGIN

@interface PKYStepper (Default)

/// 全局默认样式，需要每次手动调用一次
-(void)defaultConfig;

///  x全局统一样式，step不一样
/// @param stepInterval >0
-(void)defaultConfigStep:(float)stepInterval;
@end

NS_ASSUME_NONNULL_END
