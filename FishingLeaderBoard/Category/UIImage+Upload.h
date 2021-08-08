//
//  UIImage+Upload.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/23.
//  Copyright © 2019 yue. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Upload)
@property(copy,readonly) NSString * networkURL;
-(void)uploadSelf:(void(^)(void))onSuccess failure:(void(^)()) onFailure;
@end

NS_ASSUME_NONNULL_END
