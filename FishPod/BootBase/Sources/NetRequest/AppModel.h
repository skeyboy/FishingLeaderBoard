//
//  AppModel.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConfig.h"
@class ModelResult;
@class ModelMessage;
NS_ASSUME_NONNULL_BEGIN



///参考 https://github.com/ibireme/YYModel
@interface AppModel : NSObject
@property(nonatomic) int  code;
@property(copy, nonatomic) NSString * message;
@property(nonatomic) id data;
-(BOOL)isSuccess;
-(BOOL)isFailure;
-(void)showError:(void(^)(NSString * message)) show;
-(id)dataFor:(Class) modelClass;
+ (NSDictionary *)modelCustomPropertyMapper ;
@end

@interface ModelResult : NSObject
@property(nonatomic) NSString * status;
@end

@interface ModelMessage : NSObject
@property(nonatomic) NSString * code;
@property(nonatomic) NSString *desc;
@end


NS_ASSUME_NONNULL_END
