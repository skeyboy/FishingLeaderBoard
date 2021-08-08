//
//  FTabBarClass.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FTabBarClass.h"
#import "ZhuanQuJiFenViewController.h"
#import "LoginAndRegisterViewController.h"
#import "AllMyViewController.h"
#import "FAgentViewController.h"
#import "HomeIntegralViewController.h"

@implementation FTabBarClass

+(UITabBarController *)intoTabBarControll
{
//    UITabBarController *tab =[[UITabBarController alloc]init];
    //首页
    HomeTableViewController *homeVc =[[HomeTableViewController alloc]init];
  
    UINavigationController * NCHome = [self addChildVc:homeVc title:@"首页" image:@"Tab_home" selectedImage:@"Tab_homeS"];
    //发现
    DiscoverViewController * discoverVc = [[DiscoverViewController alloc] init];
    UINavigationController * NC_discover = [self addChildVc:discoverVc title:@"发现" image:@"Tab_discorver" selectedImage:@"Tab_discorverS"];
    
    //原来的不用了 我的
//    MyViewController* vc3 = [[MyViewController alloc] init];
//    UINavigationController * NC3 = [self addChildVc:vc3 title:@"我的" image:kImg_TabMe selectedImage:kImg_TabMe_select];
    //已登录 我的(游客)
    MyViewController* visit_Login_Vc = [[MyViewController alloc]init];
    UINavigationController * NC_visitMy_Login = [self addChildVc:visit_Login_Vc title:@"我的" image:@"Tab_my" selectedImage:@"Tab_myS"];
    //已登录 我的(商家或代理)
    MyViewController* agentMy_Vc = [[MyViewController alloc]init];
    UINavigationController * NC_agentMy = [self addChildVc:agentMy_Vc title:@"我的" image:@"Tab_my" selectedImage:@"Tab_myS"];
    //未登录 我的
    LoginAndRegisterViewController *visit_unLogin_Vc = [[ LoginAndRegisterViewController alloc]init];
    UINavigationController * NC_visitMy_unLogin = [self addChildVc:visit_unLogin_Vc title:@"我的" image:@"Tab_my" selectedImage:@"Tab_myS"];
    //未登录 积分
    LoginAndRegisterViewController *integral_unLogin_Vc = [[ LoginAndRegisterViewController alloc]init];
    UINavigationController * NC_integral_unLogin = [self addChildVc:integral_unLogin_Vc title:@"积分" image:@"Tab_jifen" selectedImage:@"Tab_jifenS"];
    //已登录 积分
    DuiHuanJiFenViewController*integral_Login_Vc =[[DuiHuanJiFenViewController alloc]init];
    H5ArticalDetailViewController *h5JiFen = [[H5ArticalDetailViewController alloc] init];
    h5JiFen.url = RewardScore;
    
    HomeIntegralViewController *homeIntegralVC = [[HomeIntegralViewController alloc] init];

    UINavigationController * NC_integral_Login = [self addChildVc:/*integral_Login_Vc*/ homeIntegralVC title:@"积分" image:@"Tab_jifen" selectedImage:@"Tab_jifenS"];
    //商家
    SellerViewController *seller_Vc = [[ SellerViewController alloc]init];
    UINavigationController * NC_seller = [self addChildVc:seller_Vc  title:@"商家" image:@"Tab_shangjia" selectedImage:@"Tab_shangjiaS"];
    //代理
    FAgentViewController *agent_Vc = [[ FAgentViewController alloc]init];
    UINavigationController * NC_agent = [self addChildVc:agent_Vc title:@"代理" image:@"Tab_agent" selectedImage:@"Tab_agentS"];
    FTabBarTypePage typePage = [AppManager manager].barPageType;
    if([AppManager manager].userInfo == nil)
    {
        typePage = FPageTypeYouKeUnLogin;
    }else{
        if([AppManager manager].userHasLogin == NO)
        {
            typePage =FPageTypeYouKeUnLogin;
        }else{
//              UserTypeAll = 0,//全部用户 游客
//              UserTypeFriend = 1,//钓友
//              UsetTypeSpot = 2,//商家
//              UsetTypeAgent = 3//代理商
               // UsetTypeAgent =4//即是商家，又是代理商
            if([AppManager manager].userInfo.userType == 1)
            {
                typePage = FPageTypeYouKeLogin;
            }else if([AppManager manager].userInfo.userType == 2)
            {
                typePage = FPageTypeDiaoChangZhu;
            }else if([AppManager manager].userInfo.userType == 3){
                typePage = FPageTypeDaiLiRen;
            }else if([AppManager manager].userInfo.userType == 4){
                if(typePage == FPageTypeDaiLiRenAndDiaochangZhu1)
                {
                    typePage = FPageTypeDaiLiRenAndDiaochangZhu2;
                    
                }else{
                    typePage = FPageTypeDaiLiRenAndDiaochangZhu1;
                }
            }
            
        }
    }
//    if ([AppManager manager].userHasLogin) {
//        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//            if (typePage>2) {//暂时屏蔽 代理商/(商家~代理商)
//                typePage = FPageTypeYouKeLogin;
//                NSLog(@"iPad 设备，目前适配为游客的全部用户");
//            }
//        }
//    }
    BOOL rev = ( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
    NSLog(@"%ld",rev);
    [AppManager manager].barPageType = typePage;
    UITabBarController *tab = [AppDelegate appDelegate].tabBarController;
    if(tab == nil)
    {
        tab = [[UITabBarController alloc]init];
        [AppDelegate appDelegate].window.rootViewController = tab;
        [AppDelegate appDelegate].tabBarController = tab;
    }else{
        tab.viewControllers = nil;
    }
    if(typePage == FPageTypeYouKeUnLogin)
    {
        tab.viewControllers = @[NCHome,NC_discover,NC_integral_unLogin,NC_visitMy_unLogin];
    }else if (typePage == FPageTypeYouKeLogin){
        tab.viewControllers = @[NCHome,NC_discover,NC_integral_Login,NC_visitMy_Login];
    }else if (typePage == FPageTypeDaiLiRen)
    {
        tab.viewControllers = @[NCHome,NC_discover,NC_agent,NC_integral_Login,NC_agentMy];
    }else if (typePage == FPageTypeDiaoChangZhu)
    {
        tab.viewControllers = @[NCHome,NC_discover,NC_seller,NC_integral_Login,NC_agentMy];
    }else if (typePage == FPageTypeDaiLiRenAndDiaochangZhu1)
    {
        tab.viewControllers = @[NCHome,NC_discover,NC_seller,NC_integral_Login,NC_agentMy];
    }else if (typePage == FPageTypeDaiLiRenAndDiaochangZhu2)
    {
        tab.viewControllers = @[NCHome,NC_discover,NC_agent,NC_integral_Login,NC_agentMy];
    }
    if([AppDelegate appDelegate].reLoginNav)
    {
        [[AppDelegate appDelegate].reLoginNav dismissViewControllerAnimated:YES completion:^{
        }];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FFISH_LOGIN_SUCCESS" object:nil];
    [AppDelegate appDelegate].tabBarController = tab;
    return tab;
}
#pragma mark - 添加子控制器  设置图片
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
+ (UINavigationController*)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色  system为系统字体
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont fontWithName:nil size:13]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVBGCOLOR,NSFontAttributeName:[UIFont fontWithName:nil size:13]} forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [nav setNavigationBarHidden:YES animated:NO];
    return nav;
}
@end
