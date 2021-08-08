//
//  AgentInfo.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 
 
 
 */
@interface AgentInfo : NSObject
//邀请码
@property(copy, nonatomic) NSString * inviteCode;
//任务时间
@property(copy, nonatomic) NSString * taskTime;
//赛事实际数
@property(assign, nonatomic) NSInteger actualGameCount;
//赛事报名人数
@property(assign, nonatomic) NSInteger  applicationCount;
//赛事服务费收入
@property(assign, nonatomic) float  feeCount;
//代理人id
@property(assign, nonatomic) NSInteger userId;
//赛事报名百分比
@property(assign, nonatomic) float applicationPercentage;
@end

NS_ASSUME_NONNULL_END
