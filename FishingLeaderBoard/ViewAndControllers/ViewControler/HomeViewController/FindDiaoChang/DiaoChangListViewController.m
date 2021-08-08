//
//  DiaoChangListViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangListViewController.h"
#import "DiaoChangListHeadView.h"
#import "DiaoChangSearchTableViewCell.h"
#import "MenuView.h"
#import "DiaoChangDetailViewController.h"
#import "DiaoChangZhuRenZhengViewController.h"
typedef NS_ENUM(NSInteger,SpotOrderBy) {
    SpotOrderByHot = 1,//人气
    SpotOrderByDistance = 2 //距离
};
@interface DiaoChangListViewController ()<UITableViewDelegate,UITableViewDataSource,ApiFetchOptionalHandler,UISearchBarDelegate>
{
   __block DiaoChangListHeadView *headView;
}
@property(assign, nonatomic) SpotOrderBy orderBy;
@property(nonatomic,strong) NSMutableDictionary * preRequest;


/// 钓场列表
@property(nonatomic,strong)__block NSMutableArray * spots;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)BOOL isEnd;
@property(nonatomic,assign) __block BOOL isMoreLoad;

@end

@implementation DiaoChangListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.spots = [NSMutableArray arrayWithCapacity:0];
    self.preRequest = [[NSMutableDictionary alloc]init];
    [self.preRequest setValue:@"110100" forKey:@"areaId"];
    self.orderBy = SpotOrderByHot;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar-80) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    headView = [[[NSBundle mainBundle]loadNibNamed:@"DiaoChangListHeadView" owner:self options:nil]firstObject];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = headView;
    headView.searchBar.delegate = self;
    
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangSearchTableViewCell"];
    
    UIButton* btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, SCREEN_HEIGHT-Height_NavBar-80+10,SCREEN_WIDTH-40, 40) name:@"我是钓场主" delegate:self selector:@selector(intorenZheng:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 5.0;
    [self.view addSubview:btn];
    
    MenuView *menvView = [[MenuView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, CGRectGetMaxY(self.tableView.frame)-60*3-10, 60, 60*3) name:@[@"排序方式",@"人气",@"距离"] color:@[NAVBGCOLOR,[[UIColor alloc]initWithRed:251/255.0 green:79/255.0 blue:6/255.0 alpha:1],[[UIColor alloc]initWithRed:26/255.0 green:197/255.0 blue:136/255.0 alpha:1]]];
    [self.view addSubview:menvView];
    [self.view bringSubviewToFront:menvView];
    menvView.menuClick = ^(int index) {
        self->headView.searchBar.text = @"";
        [self->headView.searchBar endEditing:YES];
        if(index == 1)
        {
            self.orderBy =SpotOrderByHot;
        }else{
            self.orderBy = SpotOrderByDistance;
        }
        self.currentPage = 1;
        self.isEnd = NO;
        [self.spots removeAllObjects];
        [self fetchValue];
        
    };
        @weakify(self)
        self.currentPage = 1;
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [self showDefaultLoading];
        [appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
            [self hideHud];
            if (onError == nil) {
                self->headView.cityLabel.text = rgcData.city;
                [weak_self fetchSpotSurronunding:rgcData.adCode
                                             lng:@(location.coordinate.longitude).description
                                             lat:@(location.coordinate.latitude).description];
            }else{
                  self->headView.cityLabel.text = @"北京市";
                  [weak_self fetchSpotSurronunding:@"110100"
                   
                                                           lng:@"116.405285" lat:@"39.904989"];
            
            }
            return YES;
        }];
 
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
#pragma mark -上拉加载更多数据
-(void)loadMoreData
{self.isMoreLoad = YES;
    [self fetchValue];
}
/// 根据定位信息获取周边变钓场
-(void)fetchSpotSurronunding:(NSString *) areaId
                         lng:(NSString * ) lng
                         lat:(NSString * ) lat{
    self->headView.searchBar.text = @"";
    [self->headView.searchBar endEditing:YES];
    self.currentPage = 1;
    self.isEnd = NO;
    [self.spots removeAllObjects];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setValue:areaId forKey:@"areaId"];
    [params setValue:lng forKey:@"lng"];
    [params setValue:lat forKey:@"lat"];
    [self fetchSpotSurronunding:params];
}

/// 手动选取城市获取钓场
/// @param cityId 选取的城市id
/// @note 接口中使用cityId作为areaId的数据
-(void)fetchSpotSourroundingByCityId:(NSInteger) cityId{
    self.currentPage = 1;
    self.isEnd = 0;
    [self.spots removeAllObjects];
    self->headView.searchBar.text = @"";
    [self->headView.searchBar endEditing:YES];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@(cityId) forKey:@"areaId"];
    [self fetchSpotSurronunding:params];
}
-(void)fetchSpotSurronunding:(NSDictionary *) params
{
    if (self.preRequest) {
        self.preRequest = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    [self.preRequest removeAllObjects];
    [self.preRequest addEntriesFromDictionary:params];
    [self fetchValue];
    
}

//最终发送请求的地方
-(void)fetchValue{
    [self.preRequest setValue:@(self.orderBy) forKey:@"orderBy"];
    [self.preRequest setValue:@(self.currentPage) forKey:@"pageNo"];
    NSLog(@"p = %@",self.preRequest);
    NSDictionary *params = [self.preRequest mutableCopy];
    @weakify(self)
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString * url = [NSString stringWithFormat:@"%@/fishing/spot%@",SERVER_ADDRESS, SPOT_SURROUNDING_SPOTS];
    [self showDefaultLoading];
    [manager POST:url
       parameters:params headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        AppModel * model = [AppModel modelWithDictionary:responseObject];
        if([model isSuccess]){
           SpotSurrounding *spotSurrounding  =  [model dataFor:SpotSurrounding.class];
            NSLog(@"%@",spotSurrounding);
                   [weak_self.tableView.mj_footer endRefreshing];
                   if(self.spots.count ==spotSurrounding.page.totalCount)
                   {
                       [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
                       self.isEnd = YES;
                   }
            if (!self.isMoreLoad) {//刷新啦
                [weak_self.spots removeAllObjects];
                self.currentPage = 2;
            }else{//加载更多
                self.currentPage = spotSurrounding.page.pageNo+1;
                weak_self.isMoreLoad = NO;
                if (spotSurrounding.list.count == 0) {
                    
                    [weak_self makeToask:@"没有更多啦"];
                }
            }
            
                   [weak_self.spots addObjectsFromArray:spotSurrounding.list];
            [weak_self.tableView reloadData];
                   [weak_self hideHud];
            
        }else{
            [self makeToask:model.message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self makeToask:@"网络出现问题"];
    }];
    return;
    [manager POST:@"http://127.0.0.1:8080/test"
       parameters:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
//    return;
    [[ApiFetch share] spotPostFetch:SPOT_SURROUNDING_SPOTS
                               body:params
                             holder:self
                          dataModel:SpotSurrounding.class
                          onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
        //       TODO 此处补全数据
        if (weak_self.spots) {
            [weak_self.spots removeAllObjects];
        }
        SpotSurrounding *spotSurrounding = (SpotSurrounding*) modelValue;
        
        [weak_self.spots addObjectsFromArray:spotSurrounding.list];
         weak_self.currentPage = spotSurrounding.page.pageNo+1;
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_footer endRefreshing];
        if(self.spots.count ==spotSurrounding.page.totalCount)
        {
            [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.isEnd = YES;
        }
        [weak_self hideHud];
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self.tableView.mj_footer endRefreshing];
     if(self.isEnd == YES)
     {
         [self.tableView.mj_footer endRefreshingWithNoMoreData];
     }
     [self hideHud];

}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}


//我是钓场主d按钮点击事件
-(void)intorenZheng:(UIButton*)btn
{
    
   if( [[AppManager manager]userHasLogin]==NO)
   {
       [self showDefaultInfo:@"请先登录"];
       return;
   }
   if(![[AppDelegate appDelegate]hasAuthor])
   {
       [self showDefaultInfo:@"钓场认证，请先打开定位"];
       return;
   }
    NSMutableDictionary *dictR = [[NSMutableDictionary alloc]init];
    [dictR setValue:[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id] forKey:@"userId"];
    [[ApiFetch share]spotGetFetch:SPOTID_BYUSER query:dictR holder:self dataModel:IsPubishAct.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        NSLog(@"发布赛事判断 = %@",modelValue);
        [self hideHud];
        IsPubishAct *isPublish = (IsPubishAct *)modelValue;
        if(isPublish.value == 0)
        {
            DiaoChangZhuRenZhengViewController *vc = [[ DiaoChangZhuRenZhengViewController  alloc]init];
            vc.spotId = nil;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
//            [self makeToask:@"你已经有钓场了"];
            DiaoChangZhuRenZhengViewController *vc = [[ DiaoChangZhuRenZhengViewController  alloc]init];
            vc.spotId = [NSString stringWithFormat:@"%ld",isPublish.value];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.spots.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaoChangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaoChangSearchTableViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (self.spots.count) {
        
        SpotSurround * spotSurronund = self.spots[indexPath.row];
        cell.lastLabel.text =[NSString stringWithFormat:@"%@ %@", spotSurronund.address,(spotSurronund.distance==nil)?@"":spotSurronund.distance];
        //attestation 1 未认证 2认证
        cell.leftLabel.text =((spotSurronund.attestation==2)?@"认证":@"");
        cell.centerLabel.text =((spotSurronund.game==2)?@"赛事":@"");
        cell.rightLabel.text =((spotSurronund.activity==2)?@"活动":@"");
        IMAGE_LOAD(cell.leftImageView, spotSurronund.icon);
        cell.titleLabel.text = spotSurronund.name;
        cell.starsView.score =spotSurronund.star;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaoChangDetailViewController *diaoChangDetailVc = [[DiaoChangDetailViewController alloc]init];
    SpotSurround * spotSurronund = self.spots[indexPath.row];
    diaoChangDetailVc.spotId  = spotSurronund.id;
    [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
}


/// 用户选择的城市
/// @param cityName 选择的城市名称
/// @param cityId 服务器对应城市id
-(void)userSelect:(NSString *)cityName cityId:(NSString *)cityId{
    [self fetchSpotSourroundingByCityId:[cityId integerValue]];
}

#pragma mark -搜索
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    if (searchText.length == 0) {
//        [self.spots removeAllObjects];
//        [self.spots  addObjectsFromArray:self.spotsSource];
//        [self.tableView reloadData];
//        return;
//    }
//    [self.spots removeAllObjects];
//    for(int i = 0;i<self.spotsSource.count;i++)
//    {
//        SpotSurround *spt = [self.spotsSource objectAtIndex:i];
//        if([spt.name containsString:searchText])
//        {
//            [self.spots addObject:spt];
//        }
//    }
    self.currentPage = 1;
    [self.preRequest removeObjectForKey:@"spotName"];
    if (searchText.length) {
        [self.preRequest setValue:searchText forKey:@"spotName"];
    }
    [self fetchValue];
//    [self.tableView reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 110;
}
@end
