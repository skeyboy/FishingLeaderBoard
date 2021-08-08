//
//  AgentBill.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AgentBill;
NS_ASSUME_NONNULL_BEGIN
@interface AgentBillManage : NSObject
@property(copy, nonatomic) NSArray<AgentBill *> * list;
@property(copy, nonatomic) Page *page;
@end
@interface AgentBill : NSObject
@property(copy, nonatomic) NSString * name;
@property(assign, nonatomic) NSInteger status;
@property(assign, nonatomic) NSInteger userId;
@property(assign, nonatomic) NSInteger id;
@property(assign, nonatomic) NSInteger eventId;
@property(assign, nonatomic) NSInteger type;
@property(copy, nonatomic) NSDate * createTime;
@property(assign, nonatomic) NSInteger money;

-(NSString *)typeInfo;
@end

NS_ASSUME_NONNULL_END
