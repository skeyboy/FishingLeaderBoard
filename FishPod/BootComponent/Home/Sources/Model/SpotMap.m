//
//  SpotMap.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/7.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SpotMap.h"
#import "ModelConfig.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "SpotInfo.h"
#import <CoreLocation/CLLocation.h>
@implementation SpotMap
YYModelCommon
+(BOOL)asArray{
    return YES;
}
/// <#Description#>
/// @param mapView <#mapView description#>
-(void)bindToMapView:(BMKMapView *)mapView{
    if (!(self.latLng.lat.length && self.latLng.lng.length)) {
        return;
    }
    
    
//       BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc] init];
//              annotation.coordinate =  CLLocationCoordinate2DMake([NSNumber numberWithString:self.latLng.lat].floatValue, [NSNumber numberWithString:self.latLng.lng].floatValue);
//              //设置标注的经纬度坐标
//               annotation.coordinate =  CLLocationCoordinate2DMake(self.latLng.lat.floatValue, self.latLng.lng.floatValue);
//               //设置标注的标题
//               annotation.title = self.name;
//               //副标题
//    annotation.spotInfo = self;
//    [mapView addAnnotation:annotation];
}
@end

 
 @implementation Latlng
 YYModelCommon
  
 @end



//@implementation BMKPointAnnotation (SpotInfo)
//
#define kAnnSpotInfo @"BMKPointAnnotation"
//-(void)setSpotInfo:(SpotInfo *)spotInfo{
//    objc_setAssociatedObject(self,
//                             kAnnSpotInfo,
//                             spotInfo,
//                             OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//-(SpotInfo *)spotInfo{
//    return objc_getAssociatedObject(self, kAnnSpotInfo);
//}
//@end

