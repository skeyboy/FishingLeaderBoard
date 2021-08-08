//
//  DiaochangMapViewController.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/// 周边钓场地图模式
@interface DiaochangMapViewController : UIViewController

-(void)addSpots:(NSArray<SpotSurround*>*)spotInfos;
@end

NS_ASSUME_NONNULL_END
