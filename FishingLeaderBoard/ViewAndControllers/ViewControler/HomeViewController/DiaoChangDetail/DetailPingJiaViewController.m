//
//  DetailPingJiaViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/12.
//  Copyright © 2020 yue. All rights reserved.
//

#import "DetailPingJiaViewController.h"

@interface DetailPingJiaViewController ()

@end

@implementation DetailPingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"评价详情" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [self initPageView];
}
-(void)initPageView
{
    [self addstars];
    [self addBiaoQian];
}
-(GRStarsView *)addstars{
    _starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(30, 30) margin:0 numberOfStars:5];
    _starsView.frame = CGRectMake(0, 0, 160,40);
    [self.bgStarView addSubview:_starsView];
    _starsView.allowSelect = NO;  // 默认可点击
    _starsView.allowDecimal = YES;  //默认可显示小数
    _starsView.allowDragSelect =NO;//默认不可拖动评分，可拖动下需可点击才有效
    _starsView.score = 2.5;
    _starsView.touchedActionBlock = ^(CGFloat score) {
        
    };
    return _starsView;
}
-(void)addBiaoQian{
    self.slView = [[SelectView alloc]initWithArr:@[@"环境干净",@"老版热情",@"钓位宽大",@"车位充足",@"餐位服务周到",@"实数放鱼",@"钓场清净"] row:@"4" cornerRadius:3 height:40];
    [self.bgBiaoQianView addSubview:self.slView];
    self.slView.isMuli = YES;//多选
    self.slView.isNoClick = YES;
    [self.slView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgBiaoQianView.mas_top);
        make.centerX.equalTo(self.bgBiaoQianView.mas_centerX);
        make.width.equalTo(self.bgBiaoQianView.mas_width);
        make.height.equalTo(self.bgBiaoQianView.mas_height);
    }];
    [self.slView setMoRenSelectedMarkArray:@[@"1",@"4"]];

}
- (IBAction)woyaodianpingAction:(id)sender {
    FaBuPingJiaView*fabuView = [[FaBuPingJiaView alloc]init];
    [self.view addSubview:fabuView];
    [fabuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);

    }];
}
@end
