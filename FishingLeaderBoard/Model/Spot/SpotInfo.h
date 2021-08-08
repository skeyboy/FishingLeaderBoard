//
//  SpotInfo.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BMKMapView;
@class SpotPondInfo;
NS_ASSUME_NONNULL_BEGIN

/// x钓场详情
@interface SpotInfo : NSObject
PropAssign(BOOL, collectHave)
PropAssign(NSInteger, id)
PropCopy(NSString, mongoUuid)
PropCopy(NSString, name)
PropAssign(NSInteger, userId)
PropCopy(NSString, lng)
PropCopy(NSString, lat)
PropCopy(NSString, address)
PropAssign(NSInteger, top)
PropAssign(NSInteger, weight)
PropAssign(NSInteger, money)
PropCopy(NSString, phone)
PropAssign(float, star)
PropAssign(float, activity)//2 显示活动，1不显示活动
PropAssign(NSInteger, game)//2 显示赛事 ，1不显示赛事
// 鱼塘类型（1：黑坑，2：路亚，3：杂淡，4：海钓，5：装备，6：野钓，7：欢乐塘，8：练竿塘，9：竞技池
PropCopy(NSString, spotType)//1 黑坑 2 路亚 3 自然水域 4 海钓
PropAssign(NSInteger, waterCount)
PropAssign(NSInteger, waterSquare)
PropAssign(double, spotDistance)
PropAssign(double, rodLong)
PropAssign(double, waterDepth)
PropCopy(NSString, posters)//，隔开的多张图片
PropCopy(NSString, icon)
PropAssign(NSInteger, status)//待审核 2： 通过 1：未通过
PropAssign(NSInteger, attestation)//1 未认证 2认证
PropAssign(NSInteger, removed)
PropCopy(NSString, leaderName)
PropCopy(NSString, leaderPhone)
PropCopy(NSDate, createTime)
PropCopy(NSDate, updateTime)
PropCopy(NSString, content)

PropAssign(NSInteger, activityCount)// 活动场次数

PropAssign(NSInteger, enrollCount)//报名人数

PropAssign(NSInteger, collectCount)//关注人数

PropCopy(NSString, distance)
PropCopy(NSString, fishes)//,隔开的多张图片
PropAssign(NSInteger, spotCount)
PropCopy(NSString, miniShare)

PropCopy(NSArray<SpotPondInfo*>, spotFishponds)

PropCopy(NSString, inviteCode)

PropCopy(NSString, commissionerName)


-(void)bindToMapView:(BMKMapView *)bmkMapView;

@end

NS_ASSUME_NONNULL_END
