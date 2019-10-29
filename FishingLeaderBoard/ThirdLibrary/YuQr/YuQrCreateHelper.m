//
//  YuQrCreateHelper.m
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import "YuQrCreateHelper.h"
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@implementation YuQrCreateHelper
+(UIImage *)createQr:(NSString *) content
           imageSize:(CGSize) imgSize
           withError:(NSError **) error{
//    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:content
                                  format:kBarcodeFormatQRCode
                                   width:imgSize.width
                                  height:imgSize.height
                                   error:&error];
     if (result) {
        ZXImage *image = [ZXImage imageWithMatrix:result];

      // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
      
         UIImage *qrImage = [UIImage imageWithCGImage:image.cgimage];;
         return qrImage;
     }  
    return nil;
}
@end
