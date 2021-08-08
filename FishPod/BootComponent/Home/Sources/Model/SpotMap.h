//
//  SpotMap.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/7.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
//#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@class BMKMapView;

NS_ASSUME_NONNULL_BEGIN

@class Latlng;

@interface SpotMap : NSObject
@property(assign, nonatomic) NSInteger id;
@property(copy, nonatomic) Latlng * latLng;
@property(copy, nonatomic) NSString * distance;
@property(copy, nonatomic) NSString * name;
-(void)bindToMapView:(BMKMapView *)bmkMapView;

@end
@interface Latlng : NSObject
@property(copy, nonatomic) NSString * lng;
@property(copy, nonatomic) NSString * lat;
@end

//@interface BMKPointAnnotation (SpotInfo)
//@property(copy) SpotMap *spotInfo;
//
//@end

NS_ASSUME_NONNULL_END
