//
//  DiaoChangListViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FindDiaoChangViewController.h"
#import "DiaoChangListViewController.h"
#import "YHSegmentView.h"
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
    DiaoChangListViewController *registerView = [[DiaoChangListViewController alloc]init];
    [mutArr addObjectsFromArray:@[diaoChangListVc,registerView]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, Height_StatusBar, SCREEN_WIDTH,  [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
    }];
    segmentView.yh_titleSelectedColor = [UIColor groupTableViewBackgroundColor];
    [segmentView setSelectedItemAtIndex:1];
    segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
    segmentView.yh_bgColor = NAVBGCOLOR;
    [self.view addSubview:segmentView];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
@end
