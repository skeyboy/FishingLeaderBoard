//
//  SFWeChatShareManager.h
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"

@class YuWeChatShareManager;

NS_ASSUME_NONNULL_BEGIN

@interface YuWeChatShareManager : NSObject
-(void)registWX;
+(YuWeChatShareManager *)manager;
+ (BOOL)isWXAppInstalled;

/**
 分享网页
 @param title 标题
 @param description 描述
 @param thumbImage 缩略图
 @param webpageUrl 链接
 @param type 分享类型 0：聊天界面 1：朋友圈 2：收藏
 @Declaration  https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Share_and_Favorites/iOS.html?utm_campaign=haruki&utm_content=note&utm_medium=reader_share&utm_source=weixin
 */
+ (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(NSUInteger)type;


/// 分享到小程序
/// @param title <#title description#>
/// @param description <#description description#>
/// @param userName <#userName description#>
/// @param webpageUrl <#webpageUrl description#>
/// @param path <#path description#>
/// @param hdImageData <#hdImageData description#>
/// @param withShareTicket bool用于用于信息采集
/// @param programType 区分开发还是测试版
+(void)shareToWxMinProgramWithTitle:(NSString *)title
    description:(NSString *) description
       userName:(NSString *)userName
     webpageUrl:(NSString *)webpageUrl
           path:(NSString *)path
    hdImageData:(NSData *) hdImageData
withShareTicket:(BOOL) withShareTicket miniProgramType:(int) programType;

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options ;

@end
NS_ASSUME_NONNULL_END
@interface YuWeChatShareManager (WxLogin)
-(void)loginFromVC:(UIViewController *_Nullable) holderController;

//内部调用不要手动调用
-(void)resoveWXLoginResponse:(BaseResp *_Nullable) resp;
@end
