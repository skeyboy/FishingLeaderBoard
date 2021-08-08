//
//  UserInfo.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeAll = 0,//全部用户
    UserTypeFriend = 1,//钓友
    UsetTypeSpot = 2,//商家
    UsetTypeAgent = 3//代理商
};
NS_ASSUME_NONNULL_BEGIN

/// 登录之后的用户模型
@interface UserInfo : NSObject
PropAssign(NSInteger, id)
PropCopy(NSString, nickName)
PropCopy(NSString, name)

PropCopy(NSString, token)

PropAssign(NSInteger, gender)
PropCopy(NSString, headImg)
PropCopy(NSString, sign)
PropCopy(NSString, address)
PropCopy(NSString, phone)
PropCopy(NSString, password)
PropCopy(NSString, wechat)

PropAssign(NSInteger, idCardType)
PropAssign(NSInteger, idCard)

PropAssign(NSInteger, fans)
PropAssign(NSInteger, userType)
PropAssign(NSInteger, cityId)
PropCopy(NSString, city)
PropAssign(NSInteger, provinceId)
PropCopy(NSString, province)

PropAssign(NSInteger, areaId)
PropCopy(NSString, area)

PropAssign(NSInteger, favorate)
PropAssign(NSInteger, forbiddenWords)
PropCopy(NSString, createTime)
PropCopy(NSString, updateTime)
PropCopy(NSString, birthday)

@end

NS_ASSUME_NONNULL_END
