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
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"列表模式",@"地图模式"];
    DiaoChangListViewController *diaoChangListVc = [[DiaoChangListViewController alloc]init];
    DiaoChangListViewController *registerView = [[DiaoChangListViewController alloc]init];
    [mutArr addObjectsFromArray:@[diaoChangListVc,registerView]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(40, Height_StatusBar, SCREEN_WIDTH-80, 20) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
    }];
    
    segmentView.yh_titleSelectedColor = [UIColor groupTableViewBackgroundColor];
    [segmentView setSelectedItemAtIndex:1];
    segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
    segmentView.yh_bgColor = NAVBGCOLOR;
    [hkNavigationView addSubview:segmentView];
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
