//
//  SelectPhotosViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionViewCell.h"
#import <Photos/Photos.h>
#import "AppDelegate.h"
#import "PhotoHeadView.h"
#import "EditView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectPhotosViewController : UIViewController
+ (void)checkPhotoLibraryAuthorization:(void (^)(BOOL))completion;
@property (nonatomic, copy) void (^selectPhoto)(UIImage *);
@property (nonatomic, copy) EditView* cropImageView ;

@end

NS_ASSUME_NONNULL_END
