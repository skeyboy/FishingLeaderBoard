//
//  AppModel.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AppModel.h"
#import <YYKit/YYKit.h>

@implementation AppModel
-(id)dataFor:(Class)modelClass{
    id modelValue =   [modelClass modelWithJSON:self.data];
    return modelValue;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        
    };
}
@end

@implementation ModelResult



@end
@implementation ModelMessage


@end