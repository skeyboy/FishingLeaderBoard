//
//  DuiHuanJiFenViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DuiHuanJiFenViewController.h"

@interface DuiHuanJiFenViewController ()

@end

@implementation DuiHuanJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = NAVBGCOLOR;
    // Do any additional setup after loading the view.
   UIScrollView* bgScrollView = [[UIScrollView alloc]init];
      bgScrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - Height_TabBar);
    bgScrollView.bounces = NO;
    bgScrollView.backgroundColor = NAVBGCOLOR;
      [self.view addSubview:bgScrollView];
        self.bgjifenView = [[[NSBundle mainBundle]loadNibNamed:@"JiFenDuiHuanView" owner:self options:nil]firstObject];
      [bgScrollView addSubview:self.bgjifenView];
      [self.bgjifenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(bgScrollView);
                make.width.equalTo(bgScrollView);
                make.height.equalTo(@(818));
      }];
    UIView *qianDaoView = [ToolView jiFenShowView:@[@"1",@"3",@"2"] all:@[@"1",@"2",@"13",@"3",@"4",@"6",@"34",@"7",@"5",@"2"] superView:self.bgjifenView.bgQianDaoView];
    [qianDaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgjifenView.bgQianDaoView.mas_bottom).offset(-10);
        make.height.equalTo(@30);
        make.left.equalTo(self.bgjifenView.bgQianDaoView.mas_left).offset(10);
        make.right.equalTo(self.bgjifenView.bgQianDaoView.mas_right).offset(-10);
    }];
    [ToolView getLunBoViewHeight:100 width:SCREEN_WIDTH-20 y:0 x:0 superView:self.bgjifenView.bgLunBoView];

}


@end
