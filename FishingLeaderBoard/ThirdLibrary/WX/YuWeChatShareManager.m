//
//  SFWeChatShareManager.m
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import "YuWeChatShareManager.h"
#import "WXApi.h"
#import <UIKit/UIKit.h>
#define WXAPPID @"wx960ffc9013212e88"
@interface YuWeChatShareManager()<WXApiDelegate>

@end

@implementation YuWeChatShareManager
-(void)registWX{
    
    [WXApi registerApp:WXAPPID universalLink:@""];
}
static YuWeChatShareManager *manager;
+(YuWeChatShareManager *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YuWeChatShareManager alloc] init];
    });
    return manager;
}

+ (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}

+ (void)shareToWechatWithText:(NSString *)content type:(NSUInteger)type
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.text = content;
    req.bText = YES;
    req.scene = (int)type;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

+ (void)shareToWechatWithImage:(UIImage *)image
                    thumbImage:(UIImage *)thumbImage
                          type:(NSUInteger)type
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:thumbImage];

    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = imageObject;

    [self sendToWechatWithBText:NO message:message scene:type];
}

+ (void)shareToWechatWithMusicTitle:(NSString *)title
                        description:(NSString *)description
                         thumbImage:(UIImage *)thumbImage
                           musicUrl:(NSString *)musicUrl
                       musicDataUrl:(NSString *)musicDataUrl
                               type:(NSUInteger)type
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];

    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = musicUrl;
    ext.musicLowBandUrl = ext.musicUrl;
    ext.musicDataUrl = musicDataUrl;
    ext.musicLowBandDataUrl = ext.musicDataUrl;
    message.mediaObject = ext;

    [self sendToWechatWithBText:NO message:message scene:type];
}

+ (void)shareToWechatWithVideoTitle:(NSString *)title
                        description:(NSString *)description
                         thumbImage:(UIImage *)thumbImage
                           videoUrl:(NSString *)videoUrl
                               type:(NSUInteger)type
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];

    WXVideoObject *videoObject = [WXVideoObject object];
    videoObject.videoUrl = videoUrl;
    videoObject.videoLowBandUrl = videoObject.videoUrl; //低分辨了的视频url

    [self sendToWechatWithBText:NO message:message scene:type];
}

//分享网页链接
+ (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(NSUInteger)type
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];

    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = webpageUrl;
    message.mediaObject = webpageObject;

    [self sendToWechatWithBText:NO message:message scene:type];
}

/**
 * 发送请求给微信
 * bText: 发送的消息类型
 * message: 多媒体消息结构体
 * scene: 分享的类型场景
 **/
+ (void)sendToWechatWithBText:(BOOL)bText message:(WXMediaMessage *)message scene:(NSUInteger)scene
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = bText;
    req.message = message;
    req.scene = (int)scene;

    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onReq:(BaseReq *)req
 {

}
// 从微信分享过后点击返回应用的时候调用
- (void)onResp:(BaseResp *)resp
{
    
}


@end

