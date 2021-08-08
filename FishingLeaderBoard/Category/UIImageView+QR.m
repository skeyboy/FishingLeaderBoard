//
//  UIImageView+QR.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIImageView+QR.h"
#import "UIView+Toast.h"
#import "YuQrCreateHelper.h"

@implementation UIImageView (QR)
-(void)createQr:(NSString *) message {
    NSError *error = nil;
    self.image = [YuQrCreateHelper createQr:message
                                  imageSize:self.size
                                  withError:&error];
    if (error) {
        [self makeToast:@"二维码生成错误"];
    }
}
@end
