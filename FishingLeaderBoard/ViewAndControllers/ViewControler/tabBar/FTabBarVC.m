//
//  LZTabBarVC.m
//  WebViewTest
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FTabBarVC.h"
#import "LZCustomTabbar.h"
#import "LoginAndRegisterViewController.h"
#import "HomeTableViewController.h"
#import "MyViewController.h"
#import "BuHuoTableViewController.h"
#import "SaiShiAndHuoDongTableViewController.h"
@interface FTabBarVC ()

@end

@implementation FTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initUI];
}
- (void)initUI
{
   
    self.tabbar = [[LZCustomTabbar alloc] init];
    //中间自定义tabBar点击事件
    __weak __typeof(self) weakSelf = self;
    
    _tabbar.btnClickBlock = ^(UIButton *btn) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        strongSelf.selectedIndex = 4;
    };
    [self setValue:_tabbar forKeyPath:@"tabBar"];
    
    HomeTableViewController *homeVc =[[HomeTableViewController alloc]init];
    homeVc.headType = FPageTypeHomeHeadView;
    UINavigationController * NCHome = [self addChildVc:homeVc title:@"首页" image:kImg_TabHome selectedImage:kImg_TabHome_select];
    //第一个控制器
    LoginAndRegisterViewController * vc1 = [[LoginAndRegisterViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    UINavigationController * NC1 = [self addChildVc:vc1 title:@"品牌" image:kImg_TabHome selectedImage:kImg_TabHome_select];
    
    //第3个控制器
    BuHuoTableViewController * vc3 = [[BuHuoTableViewController alloc] init];
    vc3.pageType = FPageTypeDiaoChangView;
    UINavigationController * NC3 = [self addChildVc:vc3 title:@"钓场" image:kImg_TabPinPai selectedImage:kImg_TabPinPai_select];
    
    //第4个控制器
    MyViewController* vc4 = [[MyViewController alloc] init];
    UINavigationController * NC4 = [self addChildVc:vc4 title:@"我的" image:kImg_TabMe selectedImage:kImg_TabMe_select];
    
    //第5个控制器
    SaiShiAndHuoDongTableViewController * vc5 = [[SaiShiAndHuoDongTableViewController alloc] init];
    vc5.view.backgroundColor = NAVBGCOLOR;
    vc5.title = @"中间";
    UINavigationController * NC5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    NC5.navigationBar.hidden = YES;
     self.viewControllers = @[NCHome,NC3,NC1,NC4,NC5];
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
- (UINavigationController*)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色  system为系统字体
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont fontWithName:nil size:13]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:nil size:13]} forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBar.hidden = YES;
    return nav;
}
#pragma mark - 类的初始化方法，只有第一次使用类的时候会调用一次该方法
+ (void)initialize
{
    //tabbar去掉顶部黑线
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [LZCustomTabbar setTabBarUI:self.tabBar.subviews tabBar:self.tabBar topLineColor:[UIColor lightGrayColor] backgroundColor:self.tabBar.barTintColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
