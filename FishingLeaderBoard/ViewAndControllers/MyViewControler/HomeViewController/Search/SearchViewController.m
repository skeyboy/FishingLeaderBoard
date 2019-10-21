//
//  SearchViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SearchViewController.h"
#import "YHSegmentView.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:@"" isShowBack:YES];
    [hkNavigationView setNavBarViewCenterSearchTag:SEARCH_SEARCH_TAG];
    [hkNavigationView setNavBarViewRightBtnWithName:@"搜索" target:self action:@selector(search:) ];
    hkNavigationView.searchClick = ^(UISearchBar * search) {
        
    };
    
    [self initPageView];
}
-(void)search:(UIButton *)btn
{
    NSString *searchText = hkNavigationView.searchBar.text;
    hkNavigationView.searchBar.text = @"";
    [hkNavigationView.searchBar resignFirstResponder];
    NSLog(@"seach click");
    
}

-(void)initPageView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"钓场",@"赛事",@"活动",@"用户",@"渔获"];
    DiaoChangSearchTableViewController *diaoChangVc = [[DiaoChangSearchTableViewController alloc]init];
    SaiShiTableViewController *saiShiVc = [[SaiShiTableViewController alloc]init];
    SaiShiTableViewController *huoDongVc = [[SaiShiTableViewController alloc]init];
    UserTableViewController *userVC = [[UserTableViewController alloc]init];
    BuHuoTableViewController *buHuoVc = [[BuHuoTableViewController alloc]init];
    [mutArr addObjectsFromArray:@[diaoChangVc,saiShiVc,huoDongVc,userVC,buHuoVc]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)-1, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:14 TitleSelectedSize:14 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
  
    }];
    segmentView.yh_titleSelectedColor = WHITECOLOR;
    segmentView.yh_titleNormalColor = [UIColor lightGrayColor];
    [segmentView setSelectedItemAtIndex:0];
    segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
    segmentView.yh_bgColor = NAVBGCOLOR;
    [self.view addSubview:segmentView];
    
}
@end
