//
//  FConstont.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#ifndef FConstont_h
#define FConstont_h

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

//#import "FishingLeaderBoard-Swift.h"

/*******************************Config********************************************/

#if DEBUG
#define SERVER  2 // 1!< 测试版后台 2!<正式版后台
#else
#define SERVER  2
#endif
//#define SERVER  1

#if(SERVER == 1)  //!< 测试版后台
//const static NSString * SERVER_ADDRESS = @"http://47.94.139.201:9000";
//const static NSString * SERVER_ADDRESS = @"https://fish.diaoyuphb.com";

//const static NSString * SERVER_ADDRESS = @"http://47.92.169.47:9000";
//39.101.216.255:9000
const static NSString * SERVER_ADDRESS = @"http://39.101.216.255:9000";

#define APP_DOWNLOAD_URL @"http://39.101.216.255:9002/fishing"
#define betaSign
#elif(SERVER == 2)  //!<正式版后台
const static NSString * SERVER_ADDRESS = @"https://fish.diaoyuphb.com";
#define APP_DOWNLOAD_URL @"http://47.92.169.47:9002/fishing"

#endif

/*************************************适配**************************************/
// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define Height_StatusBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.0 : 20.0)
#define Height_NavBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.0 : 49.0)
#define Height_BottomLine ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 10.0 : 0)


#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)


//本地图标赋值简写
#define IMAGE(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",name]]




//设置字体的简写helvetica-light
#define FONT(size) [UIFont systemFontOfSize:size]
#define FONT_1 [UIFont systemFontOfSize:16]
#define FONT_2 [UIFont systemFontOfSize:14]
#define FONT_3 [UIFont systemFontOfSize:12]
#define FONT_3_bold [UIFont boldSystemFontOfSize:12]
#define FONT_3_light  [UIFont fontWithName:@"" size:12]




#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//

#define IMAGE_LOAD(imageView, urlStr) [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];


//颜色设置
#define WHITECOLOR [UIColor whiteColor]
#define WHITEGRAY  UIColorFromRGB(0xf0f0f0)
#define CLEARCOLOR [UIColor clearColor]
#define BLACKCOLOR [UIColor blackColor]
//背景色 白灰色
#define WhiteGray_color 0xf0f0f0

#define BLACKGRAY UIColorFromRGB(0x333333)
#define SEPAEATOR_COLOR             @"e9e9e9"
//#define NAVBGCOLOR [UIColor colorWithRed:16/255.0 green:74/255.0 blue:185/255.0 alpha:1]

//#define NAVBGCOLOR [UIColor colorWithRed:11/255.0 green:37/255.0 blue:67/255.0 alpha:1]
#define NAVBGCOLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather_bg"]]
//#define NAVBGCOLOR [UIColor colorWithRed:54/255.0 green:143/255.0 blue:209/255.0 alpha:1]
#define LOGINBGCOLOR    [UIColor  colorFromHexRGB:@"fbfbfb"]//登录页面背景灰
//主色调蓝
#define MAINBLUECOLOR [UIColor colorWithRed:16/255.0 green:74/255.0 blue:186/255.0 alpha:1]

// tag 设置
#define TEXTFIELD_ACCOUNT_TAG 500         //!<用户名输入框TAG
#define TEXTFIELD_PWD_TAG 501             //!<密码输入框TAG

#define TEXTFIELD_FORGET_PHONE_TAG 502    //!<手机号输入框TAG
#define TEXTFIELD_FORGET_PWD_TAG 503      //!<密码输入框TAG
#define TEXTFIELD_FORGET_COMFPWDP_TAG 504 //!<确认密码输入框TAG
#define TEXTFIELD_FORGET_VERFI_TAG 505    //!<验证码输入框TAG

#define BUTTON_FORGET_PWD_TAG 101   //!<忘记密码按钮TAG
#define BUTTON_LOGIN_TAG 102        //!<登录按钮TAG
#define BUTTON_THIRD_LOGIN_TAG 103  //!<第三方登录按钮TAG



#define BUTTON_MY_NAME_TAG 114          //!<我的页面姓名认证按钮
#define BUTTON_MY_DIAOCHANGRENZHENG_TAG 115      //!<我的页面钓场认证按钮


#define TEXTFIELD_SAISHISHIJIAN_TAG 701          //!<发布赛事页面赛事时间
#define TEXTFIELD_BAOMINGJIEZHI_TAG 702          //!<发布赛事页面报名截止时间



#define SEARCH_HOME_TAG           300  //!<首页搜索
#define SEARCH_SEARCH_TAG         301  //!<搜索页面
#define SEARCH_DIAOCHANG_TAG      302  //!<钓场页面
#define SEARCH_FAXIAN_TAG      303  //!<发现页面


#define NAVIGATION_IMG_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather_bg"]]

//统一设置searchbar
#define CUSTOM_SEARCHBAR(searchBar)     if (@available(iOS 13, *)) {\
 searchBar.searchTextField.textColor = [UIColor blackColor];\
    searchBar.searchTextField.backgroundColor=[UIColor whiteColor];    }

#define WEAKSELF_SC __weak __typeof(&*self)weakSelf_SC = self


//******************tab*****************************
#define  kImg_TabHome_select  @"tab_home_select"
#define  kImg_TabHome  @"tab_home"
#define  kImg_TabDiao_select  @"tab_DiaoChang_select"
#define  kImg_TabDiao  @"tab_DiaoChang"
#define  kImg_TabMe_select  @"tab_user_select"
#define  kImg_TabMe  @"tab_user"
#define  kImg_TabPinPai_select  @"tab_pinpai_select"
#define  kImg_TabPinPai  @"tab_pinpai"
#define  kImg_TabGame_select  @"tab_jifen_select"
#define  kImg_TabGame  @"tab_jifen"

#define is_iPad ( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define SPLIT_LINE_COLOR            @"dbdbdb"   //!<分割线颜色


typedef NS_OPTIONS(NSInteger, FPageType) {
    FPageTypeBindPhone              =5,                        //!<绑定手机号页面
    FPageTypeRegist                 =0,                         //!<注册页面
    FPageTypeForgetPassword         =1,                          //!<忘记密码页面
    FPageTypeBuHuoView              =2,                       //!<捕获
    FPageTypeDiaoChangView          =3,                        //!<钓场
    FPageTypeDetailYuHuoView        =4                        //!<钓场详情页渔获

};

typedef NS_OPTIONS(NSInteger, FTabBarTypePage) {
    FPageTypeYouKeUnLogin            =0,                       //!<游客 未登录
    FPageTypeYouKeLogin              =1,                       //!<游客 已登录
    FPageTypeDiaoChangZhu            =2,                       //!<钓场主
    FPageTypeDaiLiRen                =3,                       //!<代理人
    FPageTypeDaiLiRenAndDiaochangZhu =4,                       //!<即是代理人又是钓场主
    FPageTypeDaiLiRenAndDiaochangZhu1 =5,                       //!<钓场主
    FPageTypeDaiLiRenAndDiaochangZhu2 =6,                       //!<代理人

};
/// 订单支付类型
typedef NS_ENUM(NSInteger, PayType) {
    PayTypeWallet = 1,
    PayTypeAli=3,
    PayTypeWx=2,
};
#define HomeNewsBannerHeight  520.0/1770*(SCREEN_WIDTH-20)

//#define HomeNewsBannerHeight  9.0/16.0*(SCREEN_WIDTH-20)

//使用模拟数据做开发
#define Development 1
#endif /* FConstont_h */
