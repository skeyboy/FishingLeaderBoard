//
//  BMKPinAnnotationView+SpotInfo.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
@class BMKPointAnnotation;
@class SpotInfo;
@class SpotMap;
NS_ASSUME_NONNULL_BEGIN

@interface BMKPointAnnotation (SpotInfo)
@property(copy) SpotMap *spotInfo;

@end

NS_ASSUME_NONNULL_END
