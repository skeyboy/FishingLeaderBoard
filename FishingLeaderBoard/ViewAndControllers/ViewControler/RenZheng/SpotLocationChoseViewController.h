//
//  SpotLocationChoseViewController.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpotLocationChoseViewController : FViewController
@property(copy, nonatomic) void(^reverLocationResult)(NSString * address, CLLocationCoordinate2D coordinate , NSString *cityId);
@end

NS_ASSUME_NONNULL_END

@interface UIView (subViewOfClassName)
- (UIView*)subViewOfClassName:(NSString*)className ;
@end
