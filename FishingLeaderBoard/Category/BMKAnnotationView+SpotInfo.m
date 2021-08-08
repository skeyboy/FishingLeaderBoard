//
//  BMKAnnotationView+SpotInfo.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BMKAnnotationView+SpotInfo.h"


@implementation BMKAnnotationView (SpotInfo)

#define kAnnSpotInfo @"BMKAnnotationView"
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
