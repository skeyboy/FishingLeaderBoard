//
//  YuQrViewController.h
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBXScanTypes.h"
@protocol YuQrViewControllerDelegate<NSObject>
@optional
- (void)yuQrScanResultWithArray:(NSArray<LBXScanResult*>*_Nullable)array;
@end
NS_ASSUME_NONNULL_BEGIN

@interface YuQrViewController : UIViewController
@property(assign, nonatomic) id<YuQrViewControllerDelegate> qrDelegate;
@end

NS_ASSUME_NONNULL_END
