//
//  NOPayDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import "NOPayDetailViewController.h"
#import "ShowNoPayDetail.h"
@interface NOPayDetailViewController ()
{
    UIScrollView* bgScrollView;
}
@property(strong,nonatomic)ShowNoPayDetail*showNoPayDetail;
@end

@implementation NOPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"报名订单" isShowBack:YES];

        bgScrollView = [[UIScrollView alloc]init];
        bgScrollView.frame = CGRectMake(0,CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame));
        bgScrollView.backgroundColor = WHITECOLOR;
        [self.view addSubview:bgScrollView];
        self.showNoPayDetail= [[ShowNoPayDetail alloc]init];
        [bgScrollView addSubview:self.showNoPayDetail];
        [self.showNoPayDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.width.equalTo(bgScrollView);
            make.height.mas_greaterThanOrEqualTo(@(689));
            make.left.equalTo(@0);
        }];
}

@end
