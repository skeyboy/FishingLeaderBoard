//
//  YuShareViewController.h
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuShareViewController : UIViewController
@property(copy) NSString * shareTittle;
@property(copy) NSString * shareContent;
@property(copy) UIImage * shareImage;
@property(copy) NSString * shareUrl;

@end

NS_ASSUME_NONNULL_END
