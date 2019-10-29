//
//  SFWeChatShareManager.h
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
 */
+ (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(NSUInteger)type;
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options ;

@end
NS_ASSUME_NONNULL_END
