//
//  AppModel.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AppModel.h"
#import <YYKit/YYKit.h>
//#import "AppDelegate.h"
#import "ApiFetch.h"
#import "NSArray+YYModelStr.h"
@implementation AppModel

YYModelCommon

-(id)dataFor:(Class)modelClass{
    
    id modelValue =  nil;
    if ([modelClass respondsToSelector:@selector(asArray)]) {
        NSArray * items = self.data;
         if([modelClass isKindOfClass:NSArray.class] || [items.firstObject isKindOfClass:NSString.class]) {
            modelValue = [NSArray modelArrayWithClass:modelClass onlyStrArray:self.data];
        }else{
            modelValue = [NSArray modelArrayWithClass:modelClass json:self.data];
        }
    }else{
        modelValue =     [modelClass modelWithDictionary:self.data];
    }
    return modelValue;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        
    };
}
-(BOOL)isSuccess{
    return self.code == ApiResultOK;
}
-(BOOL)isFailure{
    return  ![self isSuccess];
}
-(void)showError:(void (^)(NSString * _Nonnull))show{
    if ([self isFailure]) {
        id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.window.rootViewController performSelectorWithArgs:@selector(showWithInfo:delayToHideAfter:), self.message, @(1)];
        
//        [appDelegate.window.rootViewController showWithInfo:self.message
//                                           delayToHideAfter:1];
    }
}
@end

@implementation ModelResult



@end
@implementation ModelMessage


@end
