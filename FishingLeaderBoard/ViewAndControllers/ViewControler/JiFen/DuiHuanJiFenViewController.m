//
//  DuiHuanJiFenViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DuiHuanJiFenViewController.h"

@interface DuiHuanJiFenViewController ()<ApiFetchOptionalHandler>
{
   __block UIScrollView* bgScrollView;
    __block UIView *contentView ;
}
PropCopy(SignPageInfo, signPageInfo);
PropCopy(UIView, qianDaoView)

@end

@implementation DuiHuanJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = NAVBGCOLOR;
    // Do any additional setup after loading the view.
    [self setNavViewWithTitle:@"积分兑换" isShowBack:NO];
    [self initPageView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initPageData];
}

-(void)initPageView
{
     bgScrollView = [[UIScrollView alloc]init];
     bgScrollView.frame = CGRectMake(0,CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - Height_TabBar-hkNavigationView.height);
    
     [self.view addSubview:bgScrollView];
    contentView = [UIView new];
    [bgScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(bgScrollView);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
     bgScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initPageData)];
     self.bgjifenView = [[JiFenDuiHuanView alloc]init];
     [contentView addSubview:self.bgjifenView];
     [self.bgjifenView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.equalTo(@0).offset(-Height_StatusBar);
//         make.left.equalTo(bgScrollView.mas_left);
//         make.width.equalTo(bgScrollView);
//         make.height.greaterThanOrEqualTo(@(818));
          make.top.equalTo(@0);
         make.left.right.bottom.equalTo(contentView);
         make.height.greaterThanOrEqualTo(@(818));
     }];
    _qianDaoView = [ToolView jiFenShowView:0 all:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"] superView:self.bgjifenView.bgQianDaoView];
    [_qianDaoView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self.bgjifenView.bgQianDaoView.mas_bottom).offset(-10);
         make.height.equalTo(@30);
         make.left.equalTo(self.bgjifenView.bgQianDaoView.mas_left).offset(10);
         make.right.equalTo(self.bgjifenView.bgQianDaoView.mas_right).offset(-10);
     }];
     [ToolView getLunBoViewHeight:100 width:SCREEN_WIDTH-20 y:0 x:0 superView:self.bgjifenView.bgLunBoView data:@[] clickBlock:^(id anyID, NSInteger index) {
         
     }];
}
-(void)initPageData
{
     @weakify(self)
     [[ApiFetch share] userGetFetch:USER_SIGNPAGE
                                query:@{}
                               holder:self
                            dataModel:SignPageInfo.class
                            onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
//         NSSLog(@"jifen modelValue = %@",modelValue);
         self.signPageInfo = (SignPageInfo*)modelValue;
         [self frashData];
         [self hideHud];
         [self->bgScrollView.mj_header endRefreshing];
       }];
}
-(void)frashData
{
    [_qianDaoView removeFromSuperview];
    if(self.signPageInfo.hasSign == 0)
    {
        [self.bgjifenView.quQianDaoButton setTitle:@"去签到" forState:UIControlStateNormal];
    }else{
        [self.bgjifenView.quQianDaoButton setTitle:@"已签到" forState:UIControlStateNormal];
    }
    self.bgjifenView.jiFenLabel.text = [NSString stringWithFormat:@"%d",(int)self.signPageInfo.currency];
    self.bgjifenView.yiQianDaoLabel.text = [NSString stringWithFormat:@"已签到%d天",(int)self.signPageInfo.days];
    _qianDaoView = [ToolView jiFenShowView:(int)self.signPageInfo.days all:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"] superView:self.bgjifenView.bgQianDaoView];
    [_qianDaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgjifenView.bgQianDaoView.mas_bottom).offset(-10);
        make.height.equalTo(@30);
        make.left.equalTo(self.bgjifenView.bgQianDaoView.mas_left).offset(10);
        make.right.equalTo(self.bgjifenView.bgQianDaoView.mas_right).offset(-10);
        }];
        [ToolView getLunBoViewHeight:100 width:SCREEN_WIDTH-20 y:0 x:0 superView:self.bgjifenView.bgLunBoView data:@[] clickBlock:^(id anyID, NSInteger index) {
            
        }];
    
    [self.bgjifenView.bgLunBoView removeAllSubviews];
    [[ApiFetch share] infoGetFetch:INFO_HOME_BANNER
                               query:@{@"bannerType":@(4)} holder:self
                             dataModel:InfoBanner.class
                             onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
          NSArray * bannerList = (NSArray *)modelValue;
          NSMutableArray *wM = [[NSMutableArray alloc]init];
          for(int i = 0;i<bannerList.count;i++)
          {
              InfoBanner *infoBanner = [bannerList objectAtIndex:i];
              WMBannerCellModel *model = [[WMBannerCellModel alloc]init];
              model.imageName = infoBanner.icon;
              [wM addObject:model];
          }
          [ToolView getLunBoViewHeight:230
                                    width:SCREEN_WIDTH
                                        y:0
                                        x:0
                             superView:self.bgjifenView.bgLunBoView data:wM clickBlock:^(id anyID, NSInteger index) {
              InfoBanner *infoBanner = [bannerList objectAtIndex:index];
//              //PS轮播图类型 type1：钓场，2：活动，3：赛事，4：文章
//              if(infoBanner.type ==1)
//              {
//                  DiaoChangDetailViewController*vc = [[ DiaoChangDetailViewController alloc]init];
//                  vc.spotId = infoBanner.targetId;
//                  vc.hidesBottomBarWhenPushed = YES;
//                  [self.navigationController pushViewController:vc animated:YES];
//              }else if (infoBanner.type == 3)
//              {
//                  EnrollGameNewViewController*vc = [[EnrollGameNewViewController alloc]init];
//                  vc.hidesBottomBarWhenPushed = YES;
//                  vc.eventId = infoBanner.targetId;
//                  vc.isAct = 0;
//                  [self.navigationController pushViewController:vc animated:YES];
//              }else if (infoBanner.type == 2)
//              {
//                  EnrollGameNewViewController*vc = [[EnrollGameNewViewController alloc]init];
//                                 vc.hidesBottomBarWhenPushed = YES;
//                                 vc.eventId = infoBanner.targetId;
//                                 vc.isAct = 1;
//                                 [self.navigationController pushViewController:vc animated:YES];
//              }else if (infoBanner.type == 4)
//              {
//
//                  [self pushToArticleDetailById:infoBanner.targetId];
//              }
          }];
        }];
    
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [bgScrollView.mj_header endRefreshing];
     [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
@end
