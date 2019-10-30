//
//  SFWeChatShareManager.m
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import "YuWeChatShareManager.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define WXAPPID @"wx960ffc9013212e88"
#define WXAppSecret @""
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
+(void)shareToWxMinProgramWithTitle:(NSString *)title
                        description:(NSString *) description
                           userName:(NSString *)userName
                         webpageUrl:(NSString *)webpageUrl
                               path:(NSString *)path
                        hdImageData:(NSData *) hdImageData
                    withShareTicket:(BOOL) withShareTicket miniProgramType:(int) programType{
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = webpageUrl;
    object.userName = userName;
    object.path = path;
    object.hdImageData = hdImageData;
    object.withShareTicket = withShareTicket;
    object.miniProgramType = programType;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
                              //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req
        completion:^(BOOL success) {
        
    }];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma 微信操作结果提示
-(void)showMessage:(NSString *) msg{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
             MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:appDelegate.window.rootViewController.view animated:YES];
             hud.label.text = msg;
             [hud hideAnimated:YES afterDelay:0.25];
}
-(void)onReq:(BaseReq *)req
 {

}
// 从微信分享过后点击返回应用的时候调用
- (void)onResp:(BaseResp *)resp
{
    // =============== 获得的微信登录授权回调 ============
    if ([resp isMemberOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");
        
        [self resoveWXLoginResponse:resp];
    }
    // =============== 获得的微信支付回调 ============
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
    }
}

@end



//登陆管理
@implementation YuWeChatShareManager (WxLogin)

#pragma 微信登录
-(void)loginFromVC:(UIViewController *)holderController{
    //判断微信是否安装
       if([WXApi isWXAppInstalled]){
           SendAuthReq *req = [[SendAuthReq alloc] init];
           req.scope = @"snsapi_userinfo";
           req.state = @"App";
           [WXApi sendAuthReq:req
               viewController:holderController
                     delegate:self
                   completion:^(BOOL success) {
               
           }];
           
       }else{
         
           [self showMessage:@"您未安装微信客户端"];
       }
}
-(void)resoveWXLoginResponse:(BaseResp *)resp{
    SendAuthResp *aresp = (SendAuthResp *)resp;
          if (aresp.errCode != 0 ) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self showMessage:@"微信授权失败"];
              });
              return;
          }
          //授权成功获取 OpenId
          NSString *code = aresp.code;
          [self getWeiXinOpenId:code];
}
//通过code获取access_token，openid，unionid
- (void)getWeiXinOpenId:(NSString *)code{
    /*
     appid    是    应用唯一标识，在微信开放平台提交应用审核通过后获得
     secret    是    应用密钥AppSecret，在微信开放平台提交应用审核通过后获得
     code    是    填写第一步获取的code参数
     grant_type    是    填authorization_code
     */
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAPPID,WXAppSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data1 = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (!data1) {
            [self showMessage:@"微信授权失败"];
            return ;
        }
        
        // 授权成功，获取token、openID字典
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"token、openID字典===%@",dic);
        NSString *access_token = dic[@"access_token"];
        NSString *openid= dic[@"openid"];
        
        //         获取微信用户信息
        [self getUserInfoWithAccessToken:access_token WithOpenid:openid];
        
    });
}
-(void)getUserInfoWithAccessToken:(NSString *)access_token WithOpenid:(NSString *)openid
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 获取用户信息失败
            if (!data) {
                [self showMessage:@"微信授权失败"];
                return ;
            }
            
            // 获取用户信息字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //用户信息中没有access_token 我将其添加在字典中
            [dic setValue:access_token forKey:@"token"];
            NSLog(@"用户信息字典:===%@",dic);
            //保存改用户信息(我用单例保存)

            //微信返回信息后,会跳到登录页面,添加通知进行其他逻辑操作
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiChatOK" object:nil];
            
        });
        
    });
    
}


@end
