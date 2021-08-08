//
//  SGoodsDuiHuaJiLuViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/11.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SGoodsDuiHuaJiLuViewController.h"
#import "SGoodsDuiHuanListableViewController.h"
#import "YHSegmentView.h"
#import "YuQrViewController.h"
#import "SellerConfirmViewController.h"
@interface SGoodsDuiHuaJiLuViewController ()<YuQrViewControllerDelegate>

@end

@implementation SGoodsDuiHuaJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"商品兑换" isShowBack:YES];
     [hkNavigationView setNavBarViewRightBtnWithTitle:@"" normalImage:@"saoyisao" highlightedImage:@"saoyisao" target:self action:@selector(scan:)];
    [self initWidget];
    
}
-(void)scan:(UIButton*)btn
{
    @weakify(self)
  __block  YuQrViewController *qrVc = [[YuQrViewController alloc] init];
    @weakify(qrVc)
    qrVc.qrDelegate = self;
    qrVc.qrResult = ^(NSArray<LBXScanResult *> *result) {
        if (result.count) {
            LBXScanResult * item = result.firstObject;
            SellerConfirmViewController *sellerConfirmVc = [[SellerConfirmViewController alloc] init];
            sellerConfirmVc.code = item.strScanned;
            [weak_qrVc dismissViewControllerAnimated:NO
                                     completion:^{
                [weak_self.navigationController pushViewController:sellerConfirmVc
                animated:YES];
            }];
        }
    };
    [self presentViewController:qrVc
                       animated:YES
                     completion:^{
        
    }];
}
-(void)initWidget
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"待提货",@"已提货"];
    if (self.titles) {
        titleArr = self.titles;
    }
    SGoodsDuiHuanListableViewController *vc = [[SGoodsDuiHuanListableViewController alloc]init];
    SGoodsDuiHuanListableViewController *vc1 = [[SGoodsDuiHuanListableViewController alloc]init];
    vc1.finished = YES;
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
