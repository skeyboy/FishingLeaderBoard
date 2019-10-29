//
//  YuQrCreateHelper.h
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YuQrCreateHelper : NSObject
+(UIImage *)createQr:(NSString *) content  imageSize:(CGSize) imgSize withError:(NSError **) error;
@end

NS_ASSUME_NONNULL_END
