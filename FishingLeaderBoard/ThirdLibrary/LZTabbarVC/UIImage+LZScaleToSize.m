//
//  LZScaleToSize.m
//  WebViewTest
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIImage+LZScaleToSize.h"

@implementation UIImage (LZScaleToSize)
+ (UIImage*) originImage:(UIImage*)image scaleToSize:(CGSize)size {
    //size为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
