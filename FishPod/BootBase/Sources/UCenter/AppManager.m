//
//  AppManager.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AppManager.h"
#import "UserInfo.h"
@interface AppManager()

@end
@implementation AppManager
+(AppManager *)manager{
    static dispatch_once_t onceToken;
    static AppManager * appManager = nil;
    dispatch_once(&onceToken, ^{
        appManager = [[AppManager alloc] init];
    });
    return appManager;
}
- (BOOL)userHasLogin{
    return  self.token != nil && self.token.length>0;
}
-(NSString *)userToken{
    return self.userInfo.token;
//    return @"AAv6SaQKiUafuAhHzJTedA";
}
@end
