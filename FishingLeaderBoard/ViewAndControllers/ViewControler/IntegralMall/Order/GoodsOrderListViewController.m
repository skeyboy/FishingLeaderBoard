//
//  GoodsOrderListViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GoodsOrderListViewController.h"
#import "GoodsPayTableViewController.h"
#import "GoodsNoPayTableViewController.h"
#import "YHSegmentView.h"
@interface GoodsOrderListViewController ()

@end

@implementation GoodsOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavViewWithTitle:@"兑换记录" isShowBack:YES];
    [self initWidget];
    
}
-(void)initWidget
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"待支付",@"已支付"];
   GoodsPayTableViewController *vc = [[GoodsPayTableViewController alloc]init];
    vc.stateForList = 1;
    GoodsPayTableViewController *vc1 = [[GoodsPayTableViewController alloc]init];
    vc1.stateForList = 2;
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


@end
