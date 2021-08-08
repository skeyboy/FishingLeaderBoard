//
//  MyDataObject.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyDataObject.h"

@implementation MyDataObject
+(NSArray *)getMyData
{
    NSString *leftName = @"切换至代理人";
     if([AppManager manager].barPageType ==FPageTypeDaiLiRenAndDiaochangZhu1)
     {
       leftName = @"切换至代理人";
     }else{
       leftName = @"切换至钓场主";
     }
    NSArray * myIconArr = nil;
    if([AppManager manager].userInfo.userType == 4)
    {
          myIconArr = @[@[    @{@"name":leftName,@"imageName":@"qiehuandailiIcon"},
                              @{@"name":@"协会赛事排名",@"imageName":@"xiehuipaimingIcon"},
                              @{@"name":@"我的订单",@"imageName":@"wodedingdanIcon"},
                              @{@"name":@"实名认证",@"imageName":@"shimingrenzhenIcon"},
                              @{@"name":@"钓场认证",@"imageName":@"diaochangrenzhengIcon"},
                              @{@"name":@"推广申请",@"imageName":@"tuiguangshenqingIcon"},
                              @{@"name":@"设置钓坑",@"imageName":@"shezhidiaokenIcon"},
                              @{@"name":@"收货地址管理",@"imageName":@"shouhuodizhiIcon"},
//                              @{@"name":@"收鱼管理",@"imageName":@""},


            ],@[@{@"name":@"版本信息",@"imageName":@""},
        //        @{@"name":@"隐私保护指引",@"imageName":@""},
                @{@"name":@"了解我们",@"imageName":@""},
            ]];
    }else{
        myIconArr = @[@[@{@"name":@"协会赛事排名",@"imageName":@"xiehuipaimingIcon"},
                              @{@"name":@"我的订单",@"imageName":@"wodedingdanIcon"},
                              @{@"name":@"实名认证",@"imageName":@"shimingrenzhenIcon"},
                              @{@"name":@"钓场认证",@"imageName":@"diaochangrenzhengIcon"},
                              @{@"name":@"推广申请",@"imageName":@"tuiguangshenqingIcon"},
                              @{@"name":@"设置钓坑",@"imageName":@"shezhidiaokenIcon"},
                              @{@"name":@"收货地址管理",@"imageName":@"shouhuodizhiIcon"},
                        @{@"name":@"收鱼管理",@"imageName":@"spot_manage"},


            ],@[@{@"name":@"版本信息",@"imageName":@""},
        //        @{@"name":@"隐私保护指引",@"imageName":@""},
                @{@"name":@"了解我们",@"imageName":@""},
            ]];
    }
  
//    NSArray * myIconArr = @[@[@{@"name":@"我的发布",@"imageName":@"my_wodefabu"},
//                      @{@"name":@"我的订单",@"imageName":@"my_wodedingdan"},
//                      @{@"name":@"我的钓场",@"imageName":@"my_wodediaochang"},
//                      @{@"name":@"我的赛事",@"imageName":@"my_wodesaishi"},
//                      @{@"name":@"我的活动",@"imageName":@"my_wodedingdan"},
//                      @{@"name":@"我的积分",@"imageName":@"my_wodejifen"},
//                      @{@"name":@"客服热线",@"imageName":@"my_kefurexian"},
//                      @{@"name":@"认证",@"imageName":@"my_renzheng"},
//                      @{@"name":@"设置",@"imageName":@"my_shezhi"},
//                      @{@"name":@"钱包",@"imageName":@"my_qianbao"},
//
//    ],@[@{@"name":@"钓场管理",@"imageName":@"back_diaochangguanli"},
//        @{@"name":@"赛事管理",@"imageName":@"back_saishiguanli"},
//        @{@"name":@"活动管理",@"imageName":@"back_huodongguanli"},
//        @{@"name":@"订单核销",@"imageName":@"back_dingdanhexiao"},
//    ]];
    return myIconArr;
}
@end
