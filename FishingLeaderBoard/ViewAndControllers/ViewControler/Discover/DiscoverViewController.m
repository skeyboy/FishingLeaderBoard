//
//  FaXianViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiscoverViewController.h"
#import "FindDiaoChangViewController.h"
#import "SaiShiAndHuoDongTableViewController.h"
#import "DiaoChangSearchTableViewController.h"
#import "DiaoChangDetailViewController.h"
#import "DiaoChangDetailViewController.h"
#import "EnrollGameNewViewController.h"
#import "ReleaseFishGetViewController.h"
#import "SearchViewController.h"
@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource,ApiFetchOptionalHandler>
@property(strong,nonatomic) UIView *bgView;
@property(strong,nonatomic) UIView *bgBannerView;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic)CLLocation * _Nullable location;
@property(strong,nonatomic)BMKLocationReGeocode * _Nullable rgcData;
@property(strong,nonatomic)NSArray *spotsList;
@property(strong,nonatomic)NSArray *fishGetList;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
    [self initPageData];
}
-(void)initPageView
{
    [self setNavViewWithTitle:@"" isShowBack:NO];
    hkNavigationView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Height_NavBar+20);
    [hkNavigationView setNavBarViewLeftSearchTag:SEARCH_FAXIAN_TAG];
    [hkNavigationView setNavBarViewRightBtnWithTitle:@"未知" normalImage:@"location" highlightedImage:@"location" target:self action:@selector(locationAction:)];
    [hkNavigationView setNavLineHidden];
    __weak __typeof(self) weakSelf = self;
    hkNavigationView.searchClick = ^(UISearchBar * search) {
        SearchViewController *vc =[[SearchViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    _bgView = [FViewCreateFactory createViewWithBgColor:WHITECOLOR];
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220+10-56-150+HomeNewsBannerHeight + (SCREEN_WIDTH-20-20)/3.0/2.0);
    _bgBannerView = [FViewCreateFactory createViewWithBgColor:WHITECOLOR];
    _bgBannerView.frame = CGRectMake(0, 10, SCREEN_WIDTH, HomeNewsBannerHeight);
    float yh =0;
    //轮播图
    //    [ToolView getLunBoViewHeight:150 width:SCREEN_WIDTH y:0 x:0 superView:bgView data:@[] clickBlock:^(id anyID, NSInteger index) {
    //
    //    }];
    yh =HomeNewsBannerHeight+10;
    //添加button
    [self addButton:yh];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = _bgView;
    [self.bgView addSubview:_bgBannerView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(frashData)];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BuHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuHuoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangSearchTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaXinHSTableViewCell" bundle:nil] forCellReuseIdentifier:@"FaXinHSTableViewCell"];
    
    //渔获选项发渔获
    UIButton* sendFishGetBtn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT - 60-Height_BottomLine-Height_TabBar, 80, 40) name:@"+发渔获" delegate:self selector:@selector(sendFishGet:) tag:0];
    sendFishGetBtn.backgroundColor = NAVBGCOLOR;
    sendFishGetBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:sendFishGetBtn];
    
}
-(void)sendFishGet:(UIButton*)btn
{
    if(![[AppManager manager]userHasLogin])
      {
          [self showDefaultInfo:@"请先登录"];
          return;
      }
    ReleaseFishGetViewController*vc = [[ReleaseFishGetViewController alloc]init];
     vc.hidesBottomBarWhenPushed = YES;
    vc.faBuSuccessBlock = ^{
        [self fishCatch];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)frashData
{
    [self initPageData];
}
-(void)addButton:(float)yh
{
    //全部钓场
    UIButton *btn1 =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(toAllFishSitesAction:) tag:0];
    [btn1 setImage:[UIImage imageNamed:@"D_alldiaochang"] forState:UIControlStateNormal];
    btn1.imageView.contentMode = UIViewContentModeScaleToFill;
    btn1.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;//水平方向拉伸
    btn1.contentVerticalAlignment =  UIControlContentVerticalAlignmentFill;


    [_bgView addSubview:btn1];
    btn1.layer.cornerRadius = 5;
    //赛事活动
    UIButton *btn2 =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(toGameAndActAction:) tag:0];
    [btn2 setImage:[UIImage imageNamed:@"D_huodongsaishi"] forState:UIControlStateNormal];
    [_bgView addSubview:btn2];
    btn2.imageView.contentMode = UIViewContentModeScaleToFill;
    btn2.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;//水平方向拉伸
    btn2.contentVerticalAlignment =  UIControlContentVerticalAlignmentFill;
    btn2.layer.cornerRadius = 5;
    
    //钓技课堂
    UIButton *btn3 =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(toFishClassAction:) tag:0];
    [btn3 setImage:[UIImage imageNamed:@"D_diaojiketang"] forState:UIControlStateNormal];
    [_bgView addSubview:btn3];
    btn3.layer.cornerRadius = 5;
    btn3.imageView.contentMode = UIViewContentModeScaleToFill;
    btn3.contentVerticalAlignment =  UIControlContentVerticalAlignmentFill;
    btn3.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;//水平方向拉伸


    
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3]];
    
    float length = (SCREEN_WIDTH-20-20)/3.0;
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:10 tailSpacing:10];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self->_bgView.mas_top).offset(yh+10);
        make.height.equalTo(@(length/2.0));
    }];
    
}
#pragma mark -数据请求
-(void)initPageData
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        UIButton *navRight = [self->hkNavigationView getNavBarRightBtn];
        if (onError == nil) {
            NSLog(@"rgcData.city = %@",rgcData.city) ;
            NSLog(@"rgcData.province = %@",rgcData.province) ;
            NSLog(@"rgcData.district = %@",rgcData.district) ;
            NSLog(@"rgcData.district = %@",rgcData.adCode) ;
            [navRight setTitle:rgcData.city forState:UIControlStateNormal];
            self.location = location;
            self.rgcData = rgcData;
            [self getHotSports];
        }else{
            [self getHotSports];
        }
        return YES;
    }];
    
}
-(void)getHotSports
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
    [params setValue:@(1) forKey:@"pageNo"];
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
        weak_self.spotsList =spotSurrounding.list;
        [weak_self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self getBannerData];
        [self fishCatch];
    }];
}

////获取钓场轮播
-(void)getBannerData{
    [_bgBannerView removeAllSubviews];
    [[ApiFetch share] infoGetFetch:INFO_HOME_BANNER
                             query:@{@"bannerType":@(2)} holder:self
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
                                   x:10
                           superView:_bgBannerView data:wM clickBlock:^(id anyID, NSInteger index) {
         InfoBanner *infoBanner = [bannerList objectAtIndex:index];
                //PS轮播图类型 type1：钓场，2：活动，3：赛事，4：文章
                if(infoBanner.type ==1)
                {
                    DiaoChangDetailViewController*vc = [[ DiaoChangDetailViewController alloc]init];
                    vc.spotId = infoBanner.targetId;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (infoBanner.type == 3)
                {
                    EnrollGameNewViewController*vc = [[EnrollGameNewViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.eventId = infoBanner.targetId;
                    vc.isAct = 0;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (infoBanner.type == 2)
                {
                    EnrollGameNewViewController*vc = [[EnrollGameNewViewController alloc]init];
                                   vc.hidesBottomBarWhenPushed = YES;
                                   vc.eventId = infoBanner.targetId;
                                   vc.isAct = 1;
                                   [self.navigationController pushViewController:vc animated:YES];
                }else if (infoBanner.type == 4)
                {
                    
                    [self pushToArticleDetailById:infoBanner.targetId];
                }
            }];
            [self.tableView.mj_header endRefreshing];
        }];
   
}
-(void)pushToArticleDetailById:(NSInteger ) articleId{
    H5ArticalDetailViewController * articleVc =[[H5ArticalDetailViewController alloc] init];
     articleVc.url = ARTICAL_DETAIL_URL(articleId);
     articleVc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:articleVc
                                          animated:YES];
    
}
//鱼获请求
-(void)fishCatch{
    
    [[ApiFetch share] infoGetFetch:INFO_FISH_CATCH
                             query:@{
                                 @"pageNo":@(1),
                                 @"pageSize":@(4)
                             } holder:self
                         dataModel:InfoFishCatch.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"%@",modelValue);
        [self.tableView.mj_header endRefreshing];
        
        InfoFishCatch *info  = (InfoFishCatch*)modelValue;
        self.fishGetList = info.list;
        [self.tableView reloadData];
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
#pragma mark - 点击事件
//全部钓场
-(void)toAllFishSitesAction:(UIButton *)btn
{
    FindDiaoChangViewController*vc =[[FindDiaoChangViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//点击活动和赛事
-(void)toGameAndActAction:(UIButton *)btn
{
    SaiShiAndHuoDongTableViewController*vc =[[SaiShiAndHuoDongTableViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//点击钓技课堂
-(void)toFishClassAction:(UIButton *)btn
{
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.hidesBottomBarWhenPushed = YES;
    h5Vc.url = FISH_ClassRoom;
    
    [self.navigationController pushViewController:h5Vc
                                         animated:YES];
}
//点击每一组，更多
-(void)moreBtnClick:(CellButton *)btn
{
    NSInteger section = btn.indexPath.section;
    if(section == 0)
    {
        FindDiaoChangViewController*vc =[[FindDiaoChangViewController alloc]init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];

    }else if (section == 1)
    {
        BuHuoTableViewController *buHuoVc = [[BuHuoTableViewController alloc]init];
        buHuoVc.pageType = FPageTypeDiaoChangView;
        buHuoVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:buHuoVc animated:YES];
    }
}
//点击导航右侧位置按钮
-(void)locationAction:(UIButton *)btn
{
    FindDiaoChangViewController*vc =[[FindDiaoChangViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.spotsList.count;
    }else {
        return self.fishGetList.count/2+self.fishGetList.count%2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        BuHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuHuoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.fishGetList.count)
        {
            if(((indexPath.row+1)*2) > self.fishGetList.count)
            {
                [cell bindValue:self.fishGetList[indexPath.row*2] Value2:nil];
            }else{
                [cell bindValue:self.fishGetList[indexPath.row*2] Value2:self.fishGetList[indexPath.row*2+1]];
            }
        }
        return cell;
    }else if (indexPath.section ==0)
    {
        SpotSurround *spotSurround = [self.spotsList objectAtIndex:indexPath.row];
        DiaoChangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaoChangSearchTableViewCell" forIndexPath:indexPath];
        [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:spotSurround.icon]placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
        cell.titleLabel.text = spotSurround.name;
        cell.renZhengLabel.text = ((spotSurround.attestation==2)?@"v已认证":@"");
        cell.lastLabel.text = spotSurround.address;
        cell.starsView.score = spotSurround.star;
        return cell;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [FViewCreateFactory createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) bgColor:WHITECOLOR];
    UILabel *l = [FViewCreateFactory createLabelWithFrame:CGRectMake(10, 10, 150, 20) name:@"猜你喜欢" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    l.textAlignment = NSTextAlignmentLeft;
    [v addSubview:l];
    CellButton *btn = [CellButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-80, 10, 60, 20);
    [btn setTitle:@"更多 > " forState:UIControlStateNormal];
    [btn setTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [v addSubview:btn];
    if(section == 0)
    {
        l.text = @"猜你喜欢";
    }else{
        l.text = @"钓鱼广场";
    }
    if(self.spotsList.count == 0)
    {
        if(section==1)
        {
            return v;
        }else{
            return nil;
        }
    }else{
        return v;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.spotsList.count == 0)
    {
        if(section==0)
        {
            return 0;
        }else{
            return 40;
        }
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 110;
    }else{
        return 280;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        DiaoChangDetailViewController *diaoChangDetailVc = [[DiaoChangDetailViewController alloc]init];
        SpotSurround * spotSurronund = self.spotsList[indexPath.row];
        diaoChangDetailVc.spotId  = spotSurronund.id;
        diaoChangDetailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
    }else if (indexPath.section == 1)
    {
        //渔获详情页
    }
}
@end
