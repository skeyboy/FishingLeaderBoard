//
//  OrderEventAccountDetail.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderEventAccountDetail : NSObject
@property(assign, nonatomic) float biaoYuZhiChu;
@property(assign, nonatomic) NSInteger count;
@property(assign, nonatomic) float cunYu;
@property(assign, nonatomic) float cunYuShouRu;
@property(assign, nonatomic) float fangYu;
@property(assign, nonatomic) float fangYuZhiChu;
@property(assign, nonatomic) float qiTaShouRu;
@property(assign, nonatomic) float qiTaZhiChu;
@property(assign, nonatomic) float shouYu;
@property(assign, nonatomic) float shouYuZhiChu;
@property(assign, nonatomic) float thisInComeMoney;
@property(assign, nonatomic) float yuPiaoShouRu;

PropCopy(NSString, eventName)
PropCopy(NSDate, finishTime)
PropCopy(NSDate, startTime)

@end

NS_ASSUME_NONNULL_END
