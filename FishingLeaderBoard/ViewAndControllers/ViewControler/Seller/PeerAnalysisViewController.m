//
//  PeerAnalysisViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PeerAnalysisViewController.h"
#import "JGProgressView.h"
#import "PARingView.h"
@interface PeerAnalysisViewController ()
@property(strong,nonatomic)PeerAnalysisPageView*bgView;
@end

@implementation PeerAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"同行分析" isShowBack:YES];
       hkNavigationView.backgroundColor = NAVBGCOLOR;
    self.view.backgroundColor = [[UIColor alloc]initWithRed:19/255.0 green:17/255.0 blue:36/255.0 alpha:1];
    [self initPageView];
}
-(void)initPageView
{
     UIScrollView *  bgScrollView = [[UIScrollView alloc]init];
       bgScrollView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar);
       [self.view addSubview:bgScrollView];
       self.bgView = [[PeerAnalysisPageView alloc]init];
       [bgScrollView addSubview:self.bgView];
       [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(bgScrollView);
           make.width.equalTo(bgScrollView);
           make.height.greaterThanOrEqualTo(@320);
       }];
     JGProgressView *PV = [[JGProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 16)];
      PV.progress = 0.18;
      [self.bgView.bgProgressView addSubview:PV];
    PV = [[JGProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 16)];
         PV.progress = 0.22;
         [self.bgView.bgProgressView1 addSubview:PV];
    PV = [[JGProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 16)];
         PV.progress = 0.38;
         [self.bgView.bgProgressView2 addSubview:PV];
    PV = [[JGProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 16)];
         PV.progress = 0.05;
         [self.bgView.bgProgressView3 addSubview:PV];
   PV = [[JGProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 16)];
         PV.progress = 0.01;
         [self.bgView.bgProgressView4 addSubview:PV];
    PV = [[JGProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 16)];
         PV.progress = 0.16;
         [self.bgView.bgProgressView5 addSubview:PV];
    PARingView *rv = [[PARingView alloc]initWithFrame:CGRectMake(0, 30, 140, 140) scales:@[@(30),@(40),@(30)] colors:@[[UIColor orangeColor],[UIColor greenColor],[UIColor blueColor]] radius:70 colorCenter:[[UIColor alloc]initWithRed:6/255.0 green:15/255.0 blue:30/255.0 alpha:1] isFill:YES];
    rv.backgroundColor = [[UIColor alloc]initWithRed:6/255.0 green:15/255.0 blue:30/255.0 alpha:1];
    [self.bgView.bgCenterView addSubview:rv];
    [rv mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(self.bgView.bgCenterView.mas_right).offset(-30);
        make.top.equalTo(self.bgView.bgCenterView.mas_top).offset(30);
        make.height.equalTo(@140);
        make.width.equalTo(@140);
    }];
    
       rv = [[PARingView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) scales:@[@(90),@(10)] colors:@[[UIColor blueColor],[UIColor orangeColor]] radius:125 colorCenter:[[UIColor alloc]initWithRed:6/255.0 green:15/255.0 blue:30/255.0 alpha:1] isFill:NO];
       rv.backgroundColor = [[UIColor alloc]initWithRed:6/255.0 green:15/255.0 blue:30/255.0 alpha:1];
       [self.bgView.bgBottomView addSubview:rv];
       [rv mas_makeConstraints:^(MASConstraintMaker *make) {
       
           make.centerX.equalTo(self.bgView.bgBottomView.mas_centerX);
           make.top.equalTo(self.bgView.bgBottomView.mas_top);
           make.height.equalTo(@250);
           make.width.equalTo(@250);
       }];
    
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
