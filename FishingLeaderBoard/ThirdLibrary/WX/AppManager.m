//
//  AppManager.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AppManager.h"
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
    return  self.token != nil;
}

@end
