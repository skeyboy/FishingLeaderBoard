//
//  CategoryHeader.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

#ifndef CategoryHeader_h
#define CategoryHeader_h
#import "NSString+Empty.h"
#import "UIViewController+ShowHud.h"
#import "UIViewController+AppDelegate.h"
#import "NSArray+AsArray.h"
#import "UIImage+Upload.h"
#import "AlipaySDK+pay.h"

#define IMAGE_LOAD(imageView, urlStr) [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];

#endif /* CategoryHeader_h */
