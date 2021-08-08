//
//  H5Header.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/7.
//  Copyright © 2019 yue. All rights reserved.
//

#ifndef H5Header_h
#define H5Header_h

#if DEBUG
#define H5HOST  @"http://39.101.216.255:9002/fishing"
#else
#define H5HOST @"https://fish.diaoyuphb.com/vue"
#endif

//首页消息：
#define HOME_MESSAGE  [NSString stringWithFormat:@"%@/message",H5HOST]

//首页文章详情、banner跳转链接
#define ARTICAL_DETAIL_URL(articleId) [NSString stringWithFormat:@"%@/article/articleDetails?articleId=%ld",H5HOST,articleId]

//渔获详情：
#define FISH_CATCH(fishCatchId) [NSString stringWithFormat:@"%@/userInfo/article?fishCatchId=%ld",H5HOST,fishCatchId]

//钓技课堂：
#define FISH_ClassRoom  [NSString stringWithFormat:@"%@/fishingClassroom",H5HOST]

//签到：http://47.94.139.201:8002/mine/signIn
#define MINE_SIGIN [NSString stringWithFormat:@"%@/mine/signIn",H5HOST]

//我的收藏：http://47.94.139.201:8002/mine/collection
#define MINE_COLLECTION  [NSString stringWithFormat:@"%@/mine/collection",H5HOST]

//账单明细：http://47.94.139.201:8002/mine/billDetails
#define MINE_BILL_DETAILS  [NSString stringWithFormat:@"%@/mine/billDetails",H5HOST]

//活动赛事更多列表：http://47.94.139.201:8002/business/activeList (1:更多 2:抽号)
#define BUSSINESS_ACTIVE_LIST(type) [NSString stringWithFormat:@"%@/business/activeList?type=%ld",H5HOST,type]
//用户注册协议
 #define AGREEMENT [NSString stringWithFormat:@"%@/agreement",H5HOST]
///addressManage 我的-地址管理
#define ADDRESS_MANAGE [NSString stringWithFormat:@"%@/addressManage?from=app",H5HOST]

//添加配送地址
#define ADDRESS_ADD [NSString stringWithFormat:@"%@/addressManage/addAddress?from=app",H5HOST]
///ranking  赛事排名页面
#define GAME_RANKING [NSString stringWithFormat:@"%@/ranking",H5HOST]

///business/activeDetails?id=9&from=app
/// 这个是报名详情的地址带个id 和 from，from=app写死就行
#define BUSSINESS_ACTIVEDETAILS(id) [NSString stringWithFormat:@"%@/business/activeDetails?id=%ld&from=app",H5HOST,id];
///rewardScore/scoreLog 积分历史
#define REWARDSCORE_SCORELOG [NSString stringWithFormat:@"%@/rewardScore/scoreLog",H5HOST];

//同行分析
#define ColleagueAnalysis [NSString stringWithFormat:@"%@/business/colleagueAnalysis",H5HOST];

//代理钓场数据
#define AgentAnalysis [NSString stringWithFormat:@"%@/agent/spotData",H5HOST];


//协议地址
#define CooperateAgreement [NSString stringWithFormat:@"%@/cooperateAgreement",H5HOST];
//积分地址
#define RewardScore [NSString stringWithFormat:@"%@/rewardScore/score",H5HOST];

//会员手册
#define ScoreRule [NSString stringWithFormat:@"%@/rewardScore/scoreRule?from=score",H5HOST];

//积分账单
#define ScoreLog [NSString stringWithFormat:@"%@/rewardScore/scoreLog?from=score",H5HOST];

// 收鱼管理
#define ShouYuManage [NSString stringWithFormat:@"%@/agentCollectFish/activeList",H5HOST];
 
#if DEGBU
#define Game_Brand @"http://47.94.139.201/app/img/brand.jpeg";
#else
#define Game_Brand @"https://app.diaoyuphb.com/apk/7501334.jpeg "
#endif
#endif /* H5Header_h */
