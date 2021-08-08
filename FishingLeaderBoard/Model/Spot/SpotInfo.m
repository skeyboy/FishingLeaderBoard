//
//  SpotInfo.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SpotInfo.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "BMKPointAnnotation+SpotInfo.h"
@implementation SpotInfo
YYModelCommon
POSTER_FISHES
YYModelDate((@[]))
YYModelContainerPropertyGenericClass((
@{
    @"spotFishponds":SpotPondInfo.class
}))
-(void)bindToMapView:(BMKMapView *)mapView{
    if (!(self.lat.length && self.lng.length)) {
        return;
    }
    
    
       BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc] init];
              annotation.coordinate =  CLLocationCoordinate2DMake([NSNumber numberWithString:self.lat].floatValue, [NSNumber numberWithString:self.lng].floatValue);
              //设置标注的经纬度坐标
               annotation.coordinate =  CLLocationCoordinate2DMake(39.915, 116.404);
               //设置标注的标题
               annotation.title = self.name;
               //副标题
               annotation.subtitle = self.address;
    annotation.spotInfo = self;
    [mapView addAnnotation:annotation];
}
@end
