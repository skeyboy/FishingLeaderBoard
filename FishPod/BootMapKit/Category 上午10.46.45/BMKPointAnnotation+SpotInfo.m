//
//  BMKPinAnnotationView+SpotInfo.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BMKPointAnnotation+SpotInfo.h"
#import <objc/runtime.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

//#import "SpotInfo.h"
//#import "SpotMap.h"

@implementation BMKPointAnnotation (SpotInfo)

#define kAnnSpotInfo @"BMKPointAnnotation"
-(void)setSpotInfo:(SpotInfo *)spotInfo{
    objc_setAssociatedObject(self,
                             kAnnSpotInfo,
                             spotInfo,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(SpotInfo *)spotInfo{
    return objc_getAssociatedObject(self, kAnnSpotInfo);
}
@end
