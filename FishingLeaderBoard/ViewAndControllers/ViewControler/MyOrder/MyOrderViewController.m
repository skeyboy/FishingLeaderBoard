//
//  MyOrderViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyOrderViewController.h"
#import "YHSegmentView.h"
#import "OrderNoPayTableViewController.h"
#import "OrderPayTableViewController.h"
@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"我的订单" isShowBack:YES];
    [self initWidget];
    
}
-(void)initWidget
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"待支付",@"已支付"];
    OrderNoPayTableViewController *vc = [[OrderNoPayTableViewController alloc]init];
    vc.intoPageType = self.intoPageType;
    vc.vc = self.vc;
    OrderPayTableViewController *vc1 = [[OrderPayTableViewController alloc]init];
    [mutArr addObjectsFromArray:@[vc,vc1]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)-1, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
       
    }];
    
     segmentView.yh_titleSelectedColor = BLACKCOLOR;
     segmentView.yh_titleNormalColor = BLACKCOLOR;
     segmentView.bottomLineView.backgroundColor = WHITECOLOR;
     [segmentView setSelectedItemAtIndex:self.defaultSelectedIndex];
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
