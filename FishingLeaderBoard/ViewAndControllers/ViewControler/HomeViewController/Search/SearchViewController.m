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
    hkNavigationView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Height_NavBar+20);
    [hkNavigationView setNavBarViewCenterSearchTag:SEARCH_SEARCH_TAG];
    [hkNavigationView setNavBarViewRightBtnWithName:@"搜索" target:self action:@selector(search1)];
    CUSTOM_SEARCHBAR(hkNavigationView.searchBar)
    hkNavigationView.searchClick = ^(UISearchBar * search) {
        [self search];
    };
    
    [self initPageView];
}
-(void)search
{
    NSString *searchText = hkNavigationView.searchBar.text;
    NSLog(@"seach click");
    [self.searchDelegate searchButtonClick:searchText];
}
-(void)search1
{
    [hkNavigationView.searchBar resignFirstResponder];
    [self search];
}
-(void)initPageView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"钓场",@"赛事",@"活动",@"渔获"];
    DiaoChangSearchTableViewController *diaoChangVc = [[DiaoChangSearchTableViewController alloc]init];
    SaiShiTableViewController *saiShiVc = [[SaiShiTableViewController alloc]init];
    saiShiVc.pageType = 2;
    SaiShiTableViewController *huoDongVc = [[SaiShiTableViewController alloc]init];
    huoDongVc.pageType = 3;
//    UserTableViewController *userVC = [[UserTableViewController alloc]init];
    BuHuoTableViewController *buHuoVc = [[BuHuoTableViewController alloc]init];
    buHuoVc.pageType = FPageTypeBuHuoView;
    [mutArr addObjectsFromArray:@[diaoChangVc,saiShiVc,huoDongVc,buHuoVc]];
    self.searchDelegate = diaoChangVc;
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)-1, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:14 TitleSelectedSize:14 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
        [self searchType:index+1];
        self.searchDelegate = [mutArr objectAtIndex:index];
    }];
    segmentView.yh_titleSelectedColor = WHITECOLOR;
    segmentView.yh_titleNormalColor = [UIColor lightGrayColor];
    [segmentView setSelectedItemAtIndex:0];
    segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
    segmentView.yh_bgColor = NAVBGCOLOR;
    [self.view addSubview:segmentView];
    
}
//1钓场2赛事3活动4渔获
-(void)searchType:(NSInteger)type
{
    
}
@end
