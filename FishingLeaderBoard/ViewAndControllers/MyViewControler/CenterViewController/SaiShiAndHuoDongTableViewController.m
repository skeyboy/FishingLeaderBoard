//
//  SaiShiAndHuoDongTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SaiShiAndHuoDongTableViewController.h"
@interface SaiShiAndHuoDongTableViewController ()<STSegmentViewDelegate>

@end

@implementation SaiShiAndHuoDongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
}
-(void)initPageView
{

    self.view.backgroundColor = NAVBGCOLOR;
    _segmentView1 = [[STSegmentView alloc]initWithFrame:CGRectMake(0, Height_StatusBar+10, self.view.bounds.size.width, 30)];
    _segmentView1.titleArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    _segmentView1.delegate = self;
    _segmentView1.topLabelTextColor = WHITECOLOR;
    _segmentView1.bottomLabelTextColor = WHITECOLOR;
    _segmentView1.selectedBackgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    _segmentView1.labelFont = [UIFont boldSystemFontOfSize:15];
    _segmentView1.selectedBgViewCornerRadius = 3;
    [self.view addSubview:_segmentView1];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"赛事",@"活动"];
    SaiShiListTableViewController *saiShiVC = [[SaiShiListTableViewController alloc]init];
    SaiShiListTableViewController *huoDongVC = [[SaiShiListTableViewController alloc]init];
    [mutArr addObjectsFromArray:@[saiShiVC,huoDongVC]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0,Height_StatusBar+60, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
    }];
    
    segmentView.yh_titleSelectedColor = [UIColor groupTableViewBackgroundColor];
    [segmentView setSelectedItemAtIndex:1];
    segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
    segmentView.yh_bgColor =NAVBGCOLOR;
    [self.view addSubview:segmentView];
}
- (void)buttonClick:(NSInteger)index {
    NSLog(@"%ld",index);
}
@end
