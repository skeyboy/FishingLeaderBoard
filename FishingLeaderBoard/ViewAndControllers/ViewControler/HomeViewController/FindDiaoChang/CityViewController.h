//
//  CityViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityViewController : FViewController
@property(copy, nonatomic) void(^CityResult)(NSString * cityName, NSString *cityId);
@property(copy, nonatomic) NSString *deafultCityName;
@end

NS_ASSUME_NONNULL_END
