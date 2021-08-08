//
//  OrderEventAllListItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderEventAllListItem : NSObject

@property(assign, nonatomic) NSInteger id;
@property(assign, nonatomic) NSInteger managementType;
@property(copy, nonatomic) NSString* remark;
@property(assign, nonatomic) NSInteger type;
@property(copy, nonatomic) NSString* tranCount;
@property(copy, nonatomic) NSString* tranAmount;
@property(copy, nonatomic) NSString* tranPrice;
@property(copy, nonatomic) NSDate* createTime;

@end

NS_ASSUME_NONNULL_END
