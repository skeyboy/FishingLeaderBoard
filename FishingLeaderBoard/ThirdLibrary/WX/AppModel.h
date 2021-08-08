//
//  AppModel.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ModelResult;
@class ModelMessage;
NS_ASSUME_NONNULL_BEGIN



///参考 https://github.com/ibireme/YYModel
@interface AppModel : NSObject
@property(nonatomic) ModelResult * result;
@property(nonatomic) id data;
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
