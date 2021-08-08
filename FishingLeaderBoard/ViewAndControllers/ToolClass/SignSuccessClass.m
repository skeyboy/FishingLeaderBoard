//
//  SignSuccessClass.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/7.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SignSuccessClass.h"

@implementation SignSuccessClass
/// 登录成功做用户切换
+(void)loginSuccessWithUserInfo:(UserInfo *)userInfo{
    
    [AppManager manager].userInfo = userInfo;
    //将用户登录信息存入本地沙盒中
    NSDictionary *userInfoDict = userInfo.mj_keyValues;
      [[NSUserDefaults standardUserDefaults] setObject:userInfoDict forKey:fSessionUserInfoDic];
      [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"login1 = %@",[AppManager manager].userInfo.mj_keyValues);
    //TODO 此处做用户状态切换
  
    //登录成功，根据类型切换tab
    [FTabBarClass intoTabBarControll];
   
   
}
@end
