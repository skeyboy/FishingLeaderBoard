//
//  HomeTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "HomeTableViewController.h"
//#import "YuQrViewController.h"
//#import "FindDiaoChangViewController.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
//#import "AppDelegate.h"
//#import "SaiShiAndHuoDongTableViewController.h"
//#import "JiFenViewController.h"
//#import "DiaoChangDetailViewController.h"
//#import "FishingLeaderBoard-Swift.h"
#import "UserInfo.h"
#import "MJRefresh.h"
#import "ApiFetch.h"
#import "ApiFetch+User.h"
#import "UIViewController+ShowHud.h"
#import "InfoBanner.h"
#import "ApiFetch+Info.h"
#import "ToolView.h"
#import "FConstont.h"
#import "InfoNewHot.h"
#import "Masonry.h"
#import "DiaoChangSearchTableViewCell.h"
#import "ApiFetch+Spot.h"
#import "SpotSurrounding.h"
#import "AppManager.h"
#import "JLRoutes.h"
@interface HomeTableViewController ()<UITableViewDataSource,UITableViewDelegate,FSSegmentTitleViewDelegate,ApiFetchOptionalHandler>
{
    __block NSMutableArray *arrTableSource;
    __block NSString * order;
    __block NSInteger currentPage;
    __block NSInteger totalCount;
    __block BOOL isEnd;//下拉加载是否结束
    
    __block NSArray *fetchBroadcastArr;
    __block YYTimer *timer;
    double HomeNewsHeaderHeight ;
    
}
@end

@implementation HomeTableViewController
#define Order_Hot @"hot"
#define Order_Time @"time"
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavHome];
    [self initPageView];
    arrTableSource =[[NSMutableArray alloc]init];
    [self initPageData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_headView refresh];
}

- (void)onOptionalFailureHandler:(NSString *)message uri:(NSString *)uri{
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    if(isEnd == YES)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self hideHud];
}
- (BOOL)autoHudForLink:(NSString *)link{
    return YES;
}

-(void)dealloc
{
    [timer invalidate];
}
#pragma mark -数据请求
/// 获取广播消息
/// @param  筛选数据范围默认为全部
-(void)fetchBroadcast:(UserType) userType{
    [[ApiFetch share] userGetFetch:USER_BROADCAST
                             query:@{@"userType":@(userType)} holder:self
                         dataModel:NSArray.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"===%@",modelValue);
        self->fetchBroadcastArr = (NSArray *)modelValue;
        if(self->fetchBroadcastArr.count>1)
        {
            self->timer = [YYTimer timerWithTimeInterval:3 target:self selector:@selector(timercast:) repeats:YES];
            [self->timer fire];
         }else if(self->fetchBroadcastArr.count==1){
            self.headView.xiaoXiLabel.text =[self->fetchBroadcastArr objectAtIndex:0];
        }else{
            self.headView.xiaoXiLabel.text =@"暂无广播消息";
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)timercast:(YYTimer*)timer
{
    self.headView.clipsToBounds = YES;
    static int i = 0;
    CGRect frame = self.headView.xiaoXiLabel.frame;
    [UIView animateWithDuration:1 animations:^{
        self.headView.xiaoXiLabel.frame = CGRectMake(frame.origin.x, frame.origin.y+5, frame.size.width,0);
    } completion:^(BOOL finished) {
        self.headView.xiaoXiLabel.frame = frame;
        self.headView.xiaoXiLabel.text =[self->fetchBroadcastArr objectAtIndex:i];
        i++;
           if(i>=self->fetchBroadcastArr.count)
           {
               i = 0;
           }
    }];
   
   
}
/// 获取天气数据
-(void)fetchWeather{
    /*
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
         [appdelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError * onError) {
             self.rgcData = rgcData;
             self.location = location;
             NSDictionary * requestParams = @{};
             if (onError !=nil) {
           requestParams =      @{
                     @"longitude":@(116.405285), @"latitude":@(39.904989)
           };
             }else{
             requestParams =    @{
                     @"longitude":@(location.coordinate.longitude), @"latitude":@(location.coordinate.latitude)
                 };
             }
             [[ApiFetch share] infoGetFetch:INFO_HOME_GEOGRAPHY
                                      query: requestParams
                                     holder:self
                                  dataModel:InfoGeography.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
                 InfoGeography *infoGeography = (InfoGeography*)modelValue;
//                 self.headView.wCenterLabel.text = infoGeography.address;
//                 self.headView.wLeft1Label.text =infoGeography.pM25;
//                 self.headView.wLeft2Label.text = @"PM25";
                 self.headView.wNewLeftLabel.text = infoGeography.address;
                 self.headView.wRight1Label.text = [NSString stringWithFormat:@"%@ %@",infoGeography.temperature,infoGeography.weather];
                 self.headView.wRight2Label.text = infoGeography.wind;
                 [self.tableView.mj_header endRefreshing];
             }];
             return YES;
         }];
*/
     }
     

//获取首页轮播
-(void)getBannerData{
    [self.headView.bgLunBoView removeAllSubviews];
    [[ApiFetch share] infoGetFetch:INFO_HOME_BANNER
                             query:@{@"bannerType":@(1)} holder:self
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
        [ToolView getLunBoViewHeight:HomeNewsBannerHeight
                                  width:SCREEN_WIDTH-20
                                      y:0
                                      x:0
                           superView:self.headView.bgLunBoView data:wM clickBlock:^(id anyID, NSInteger index) {
            InfoBanner *infoBanner = [bannerList objectAtIndex:index];
            //PS轮播图类型 type1：钓场，2：活动，3：赛事，4：文章
            
            [[JLRoutes globalRoutes] routeURL:[NSURL URLWithString:@"/banner/click"] withParameters:@{
                @"tyep":@(infoBanner.type),
                @"targetId":@(infoBanner.targetId),
                @"infoBanner":infoBanner
            }];
          
        }];
        [self.tableView.mj_header endRefreshing];
      }];
    
}
//获取Z资讯数据
-(void)getNewData
{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if(self.location)
    {
        [params setValue:self.rgcData.province  forKey:@"province"];
        [params setValue:self.rgcData.city forKey:@"city"];
        [params setValue:@(self.location.coordinate.longitude) forKey:@"lng"];
        [params setValue:@(self.location.coordinate.latitude) forKey:@"lat"];
        [params setValue:self.rgcData.adCode forKey:@"areaId"];
    }else{
        [params setValue:@"110100" forKey:@"areaId"];
    }
    [params setValue:@(currentPage) forKey:@"pageNo"];
    [params setValue:@(3) forKey:@"pageSize"];
    
    NSLog(@"params = %@",params);
    //按照数据URL拼接的方式传/fishing/spot/hot/info?pageNo=1&pageSize=3&areaId=110100
    NSMutableString *str = [[NSMutableString alloc]initWithString:SPOT_HOT_SPOTS];
    [str appendString:@"?"];
    for (int i = 0; i<params.allKeys.count; i++) {
        NSString *key = [params.allKeys objectAtIndex:i];
        if(i!=0)
        {
            [str appendString:@"&"];
        }
        [str appendFormat:@"%@=%@",key,[params objectForKey:key]];
    }
    str =  [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"params  = %@",str);
    @weakify(self)
    
    [[ApiFetch share] spotPostFetch:str
                                  body:@{}
                                holder:self
                             dataModel:SpotSurrounding.class
                             onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
           //       TODO 此处补全数据
           SpotSurrounding *spotSurrounding = (SpotSurrounding*) modelValue;
           [self->arrTableSource addObjectsFromArray:spotSurrounding.list];
           [self.tableView reloadData];
           [self.tableView.mj_footer endRefreshing];
           [self.tableView.mj_header endRefreshing];
           if(self->currentPage ==spotSurrounding.page.totalPage)
           {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
               self->isEnd = YES;
           }
        self->currentPage = spotSurrounding.page.pageNo+1;
       }];
    return;
    
    
    
    [[ApiFetch share] infoGetFetch:INFO_NEW_HOT
                              query:@{
                                  @"order":order,
                                  @"pageNo":@(currentPage)
//                                  @"spotType":@"1"
                              } holder:self
                          dataModel:InfoNewHot.class
                          onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        
        InfoNewHot *infoNewHot = (InfoNewHot *)modelValue;
        [self->arrTableSource addObjectsFromArray:infoNewHot.list];
        self->currentPage = self->currentPage+1;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(self->arrTableSource.count ==infoNewHot.page.totalCount)
        {
          [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self->isEnd = YES;
        }

     }];
}
#pragma mark -页面初始化部分
-(void)setNavHome
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"" isShowBack:NO];
    hkNavigationView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Height_NavBar+20);
    [hkNavigationView setNavLineHidden];
    hkNavigationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather_bg"]];
   
//    [hkNavigationView setNavBarViewLeftBtnWithNormalImage:@"saoyisao" highlightedImage:@"saoyisao" target:self action:@selector(btnLeftClick:)];
//    [hkNavigationView setNavBarViewRightBtnWithNormalImage:@"msg" highlightedImage:@"msg" target:self action:@selector(btnRightClick:)];
    [hkNavigationView setNavBarViewLeftBtnWithTitle:@"扫一扫" normalImage:@"saoyisao" highlightedImage:@"saoyisao" target:self action:@selector(btnLeftClick:)];
     [hkNavigationView setNavBarViewRightBtnWithTitle:@"消息" normalImage:@"msg" highlightedImage:@"msg" target:self action:@selector(btnRightClick:)];
    [hkNavigationView setNavBarViewCenterSearchTag:SEARCH_HOME_TAG];
    __weak __typeof(self) weakSelf = self;
    hkNavigationView.searchClick = ^(UISearchBar *se) {
        
        [[JLRoutes globalRoutes] routeURL:[NSURL fileURLWithPath:@"/search/spot"]];
//        
//        UIViewController *vc =[[NSClassFromString(@"SearchViewController") alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}


-(void)initPageView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    HomeNewsHeaderHeight = 558-140+ HomeNewsBannerHeight;
    NSBundle *podBundle = [NSBundle bundleForClass:self.class];
    
    self.headView = [[podBundle loadNibNamed:@"HomeNewHeadTableView" owner:self options:nil]firstObject];
   
    self.tableView.tableHeaderView = self.headView;
   [self.tableView.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.greaterThanOrEqualTo(@(HomeNewsHeaderHeight));
       make.width.equalTo(@(SCREEN_WIDTH));
   }];
    [self.view addSubview:self.tableView];
    [self.headView.bgLunBoView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.headView.grvidView.mas_bottom);
         make.left.equalTo(self.headView.mas_left).offset(10);
         make.height.equalTo(@(HomeNewsBannerHeight));
         make.right.equalTo(self.headView.mas_right).offset(-10);
     }];
    @weakify(self)
    self.headView.segmentCtrlClick = ^(int startIndex, int endIndex) {
        NSLog(@"end  = %d,state = %d",endIndex,startIndex);
        @strongify(self)
        if(startIndex !=endIndex)
        {
            if(endIndex == 0)
            {
                self->order = Order_Hot;
            }else{
                self->order = Order_Time;
            }
            [self->arrTableSource removeAllObjects];
            self->currentPage = 1;
            [self getNewData];
        }
        
    };
    
//    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
//    self.tableView.mj_footer = footer;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangSearchTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
       [self.tableView registerNib:
        [UINib nibWithNibName:@"MainOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainOneTableViewCell"];
       [self.tableView registerNib:[UINib nibWithNibName:@"MainNoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainNoTableViewCell"];
    
}
#pragma mark -下拉加载和上拉刷新部分
//上啦加载更多数据
-(void)loadMoreData
{
    [self getNewData];
}
//下拉刷新
-(void)loadData{
    [arrTableSource removeAllObjects];
    [self.tableView reloadData];
    currentPage = 1;
    [self getBannerData];
     [self fetchWeather];
    if([[AppManager manager] userHasLogin])
       {
           [self fetchBroadcast:UserTypeAll];
       }else{
       [self fetchBroadcast:UserTypeAll];
       }
    [self getNewData];
    
}
//初始化数据
-(void)initPageData{
    self->order = Order_Hot;
    [self->arrTableSource removeAllObjects];
    self->currentPage = 1;
    isEnd=NO;
    [self getNewData];
    [self getBannerData];
    [self fetchWeather];
    if([[AppManager manager] userHasLogin])
    {
        [self fetchBroadcast:UserTypeAll];
    }else{
    [self fetchBroadcast:UserTypeAll];
    }
}
#pragma mark - tab切换
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrTableSource.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)aCell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiaoChangSearchTableViewCell *cell = aCell;
    SpotSurround *spotSurround = [arrTableSource objectAtIndex:indexPath.row];

    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:spotSurround.icon]placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
              cell.titleLabel.text = spotSurround.name;
              cell.renZhengLabel.text = ((spotSurround.attestation==2)?@"v已认证":@"");
              cell.lastLabel.text = spotSurround.address;
              cell.starsView.score = spotSurround.star;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
           DiaoChangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaoChangSearchTableViewCell" forIndexPath:indexPath];
          
           return cell;
    
    
    
    NewHot *newHot =[arrTableSource objectOrNilAtIndex:indexPath.row];
     
    if(newHot.images.count == 1)
    {
        MainOneTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MainOneTableViewCell"  forIndexPath:indexPath];
        [cell bind:arrTableSource indexPath:indexPath];
        return cell;
    }else if(newHot.images.count == 0)
    {
        MainNoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainNoTableViewCell" forIndexPath:indexPath];
        return cell;
    
    }else{
        MainTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"  forIndexPath:indexPath];
        [cell bind:arrTableSource indexPath:indexPath];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpotSurround * spotSurronund = [arrTableSource objectOrNilAtIndex:indexPath.row];
    [[JLRoutes globalRoutes] routeURL:[NSURL fileURLWithPath:[NSString stringWithFormat: @"/find/%@",@(spotSurronund.id)]] withParameters:@{
       
        @"spotId":@(spotSurronund.id)
    }];
//        UIViewController *diaoChangDetailVc = [[NSClassFromString(@"DiaoChangDetailViewController") alloc]init];
////        diaoChangDetailVc.spotId  = spotSurronund.id;
////    [diaoChangDetailVc setValue:@(spotSurronund.id) forKey:@"spotId"]l
//    [diaoChangDetailVc setValue:@(spotSurronund.id) forKey:@"spotId"];
//        diaoChangDetailVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
    
//    NewHot *newHot =[arrTableSource objectOrNilAtIndex:indexPath.row];
//    [self pushToArticleDetailById:newHot.id];
 
}
-(void)pushToArticleDetailById:(NSInteger ) articleId{
//    H5ArticalDetailViewController * articleVc =[[H5ArticalDetailViewController alloc] init];
//     articleVc.url = ARTICAL_DETAIL_URL(articleId);
//     articleVc.hidesBottomBarWhenPushed = YES;
//     [self.navigationController pushViewController:articleVc
//                                          animated:YES];
    
}
#pragma mark -点击事件
-(void)btnRightClick:(UIButton *)btn
{
//    if (![AppManager manager].userHasLogin) {
//
//        [self makeToask:@"请先登录，在来查看消息吧"];
//        return;
//    }
//    H5ArticalDetailViewController *messageVc = [[H5ArticalDetailViewController alloc] init];
//    messageVc.url = HOME_MESSAGE;
//    messageVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:messageVc
//                                         animated:YES];
}

-(void)btnLeftClick:(UIButton *)btn
{
    //    TODO
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    //读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请在iOS设置中打开App相机使用权限";
        [hud hideAnimated:YES
               afterDelay:1.0];
        
        return;
        
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"/scan"]];

    [[JLRoutes globalRoutes] routeURL:[NSURL URLWithString:@"/scan"]];
//    UIViewController *qrScanVC  =[[NSClassFromString(@"YuQrViewController") alloc] init];
//    qrScanVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    qrScanVC.qrResult = ^(NSArray<LBXScanResult *> * result) {
//        if(result.count)
//        {
//            LBXScanResult *r =[result objectAtIndex:0];
//            NSString *spotIdS = r.strScanned;
//            if(spotIdS)
//            {
//                if([spotIdS intValue]!=0)
//                {
//                    DiaoChangDetailViewController *diaoChangDetailVc = [[DiaoChangDetailViewController alloc]init];
//                      diaoChangDetailVc.spotId  = [spotIdS integerValue];
//                    diaoChangDetailVc.hidesBottomBarWhenPushed = YES;
//                      [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
//                }else{
//                    [self showDefaultInfo:@"二维码格式化错误，请重新扫描"];
//                   
//                }
//            }else{
//                [self showDefaultInfo:@"二维码格式化错误，请重新扫描"];
//               
//            }
//            [qrScanVC dismissViewControllerAnimated:NO completion:^{
//                                              }];
//        }
//    };
//    [self presentViewController:qrScanVC animated:YES completion:^{
//        
//    }];
}

@end
