//
//  SendDataClass.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock) (void);  //回调block

NS_ASSUME_NONNULL_BEGIN

@interface SendDataClass : NSObject
+(void)sendDataType:(int)flag count:(NSString*)count eventId:(NSInteger)eventId price:(NSString*)price money:(NSString*)money vc:(UIViewController*)vc back:(SuccessBlock)success;
+(void)sendDataType:(int)flag remark:(NSString*)remark eventId:(NSInteger)eventId money:(NSString*)money vc:(UIViewController*)vc back:(SuccessBlock)success;
@end

NS_ASSUME_NONNULL_END
