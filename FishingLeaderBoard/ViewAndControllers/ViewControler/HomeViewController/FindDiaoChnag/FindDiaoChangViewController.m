//
//  DiaoChangListViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FindDiaoChangViewController.h"
#import "DiaoChangListViewController.h"
#import "DiaochangMapViewController.h"
#import "YHSegmentView.h"
#import "AppDelegate.h"
@interface FindDiaoChangViewController ()

@end

@implementation FindDiaoChangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavViewWithTitle:@"" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    hkNavigationView.frame =CGRectMake(0, 0, SCREEN_WIDTH, Height_StatusBar+50);
    hkNavigationView.navLineView.frame =(CGRect){0, Height_StatusBar+50 - 0.5, SCREEN_WIDTH, 0.5};
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"列表模式",@"地图模式"];
    DiaoChangListViewController *diaoChangListVc = [[DiaoChangListViewController alloc]init];
    DiaochangMapViewController *registerView = [[DiaochangMapViewController alloc]init];
    [mutArr addObjectsFromArray:@[diaoChangListVc,registerView]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, Height_StatusBar, SCREEN_WIDTH,  [UIScreen mainScreen].bounds.size.height - 0) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
    }];
    segmentView.yh_titleSelectedColor = [UIColor groupTableViewBackgroundColor];
    [segmentView setSelectedItemAtIndex:1];
    segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
    segmentView.yh_bgColor = NAVBGCOLOR;
    segmentView.backgroundColor = WHITECOLOR;
    [self.view addSubview:segmentView];
    UIButton *btn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(back) tag:0];
    [btn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(20, Height_StatusBar+5, 40, 40);
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
     AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
       de.tbc.tabBar.hidden =NO;
}
@end
