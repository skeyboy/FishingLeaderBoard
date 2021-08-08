//
//  ApiFetch+User.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//



#import "ApiFetch.h"

NS_ASSUME_NONNULL_BEGIN

/// 用户模块的数据请求
@interface ApiFetch (User)
//GET /select/city 市 县
#define USER_CITY @"/select/city"
//获取省份
#define USER_PROVINCE @"/select/province"
//绑定手机号GET
#define USER_BINDPHONE @"/userLogin/bindPhone"
//忘记密码POST
#define USER_FORGETPSD @"/userLogin/forgetPwd"
//获取验证码1:注册，2:绑定手机号，3:找回密码
#define USER_GETCODE @"/userLogin/sendCode"
//实名认证，绑定身份证号
#define USER_BINDIDCARD @"/userLogin/bindIdCard"
//用户信息修改
#define USER_EDITUSER @"/userLogin/editUser"
//微信授权登录，返回token和id
#define USER_WX_Login_URL @"/userLogin/wxLogin"
/// 手机号注册
#define USER_PHONE_REGIST_URL @"/userLogin/phoneRegist"
/// 用户手机号登陆
#define USER_PHONE_LOGIN @"/userLogin/phonePwd"
//GET /message/getBroadcast 首页获取广播消息
#define USER_BROADCAST @"/message/getBroadcast"

//我的页面信息
#define USER_GETMYPAGE @"/userInfo/getUserPage"
///积分页面
#define USER_SIGNPAGE @"/sign/getSeriesSign"
//-(void)userGetFetch:(NSString *_Nullable) url
//              query:(NSDictionary *_Nullable)params
//          onSuccess:(void (^)(AppModel  * _Nonnull modelValue, id _Nonnull responseObject))onSuccess
//          onFailure:(void(^)(NSString * message, NSString * shortLink)) onFailure ;


/// 根据给定的url 和模型返回制定的数据模型
/// @param url 短url
/// @param params 请求参数
/// @param hoderVc 网络请求所在的VC
/// @param dataModel 返回data转换后的模型
/// @param onSuccess w我们只关注数据成功，w内部处理失败
-(void)userGetFetch:(NSString *_Nullable) url
              query:(NSDictionary *_Nullable)params
             holder:(UIViewController<ApiFetchOptionalHandler>*) hoderVc
          dataModel:(Class) dataModel
          onSuccess:(void (^)(NSObject  * _Nonnull modelValue, id _Nonnull responseObject))onSuccess;
/// 根据给定的url 和模型返回制定的数据模型
/// @param url 短url
/// @param params 请求参数
/// @param hoderVc 网络请求所在的VC
/// @param dataModel 返回data转换后的模型
/// @param onSuccess w我们只关注数据成功，w内部处理失败
-(void)userPostFetch:(NSString *) url
     body:(NSDictionary *)params
holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
     dataModel:(Class)dataModel
onSuccess:(void (^)(NSObject * _Nonnull modelValue, id _Nonnull response))onSuccess;
@end

NS_ASSUME_NONNULL_END
