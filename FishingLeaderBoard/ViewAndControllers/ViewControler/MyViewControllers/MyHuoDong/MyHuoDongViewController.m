//
//  MyHuoDongViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyHuoDongViewController.h"
#import "MyHDCanYuTableViewController.h"
#import "MyFaQiTableViewController.h"
#import "YHSegmentView.h"
@interface MyHuoDongViewController ()

@end

@implementation MyHuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavViewWithTitle:@"我的活动" isShowBack:YES];
    [self initWidget];
}
-(void)initWidget
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"我参与的",@"我发起的"];
    MyHDCanYuTableViewController *vc = [[MyHDCanYuTableViewController alloc]init];
    MyFaQiTableViewController *vc1 = [[MyFaQiTableViewController alloc]init];
    [mutArr addObjectsFromArray:@[vc,vc1]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)-1, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
       
    }];
    
     segmentView.yh_titleSelectedColor = BLACKCOLOR;
     segmentView.yh_titleNormalColor = BLACKCOLOR;
     segmentView.bottomLineView.backgroundColor = WHITECOLOR;
     [segmentView setSelectedItemAtIndex:0];
     segmentView.yh_segmentTintColor = NAVBGCOLOR;
     segmentView.yh_bgColor = WHITECOLOR;
    [self.view addSubview:segmentView];
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
