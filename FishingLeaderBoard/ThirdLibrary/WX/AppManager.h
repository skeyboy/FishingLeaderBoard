//
//  AppManager.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject
+(AppManager *)manager;
@property(copy) NSString * token;
@end

NS_ASSUME_NONNULL_END
