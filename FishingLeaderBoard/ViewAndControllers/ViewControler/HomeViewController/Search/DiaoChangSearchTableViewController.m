//
//  DiaoChangSearchTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangSearchTableViewController.h"
#import "DiaoChangDetailViewController.h"
@interface DiaoChangSearchTableViewController ()<UITableViewDelegate,UITableViewDataSource,ApiFetchOptionalHandler>

@property(strong,nonatomic)CLLocation * _Nullable location;
@property(strong,nonatomic)BMKLocationReGeocode * _Nullable rgcData;
@property(strong,nonatomic)NSMutableArray *spotsList;
@property(assign,nonatomic)NSInteger currentPage;
@property(strong,nonatomic)NSString *searchStr;
@end

@implementation DiaoChangSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangSearchTableViewCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self initPageData];
}

#pragma mark - 页面初始化
-(void)initPageView
{
    CGFloat y = 0;
    CGFloat height =self.view.frame.size.height-Height_NavBar-20-44;
    if(self.isDaiLiDiaoChang==YES)
    {
        [self setNavViewWithTitle:@"代理钓场" isShowBack:YES];
        y = CGRectGetMaxY(hkNavigationView.frame);
        height =SCREEN_HEIGHT-Height_NavBar-20;

    }
 
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, height) style:UITableViewStylePlain];
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
       [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
       [footer setTitle:@"" forState:MJRefreshStateIdle];
       [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
       self.tableView.mj_footer = footer;
       self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"GameRankSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"GameRankSelectTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 数据请求
-(void)initPageData
{
    self.currentPage = 1;
    self.spotsList = [[NSMutableArray alloc]init];
    if(self.isDaiLiDiaoChang==YES)
    {
        [self getDaiLiSports];

    }else{
    [self getHotSports];
    }
}
-(void)getDaiLiSports
{
       NSMutableDictionary * params = [NSMutableDictionary dictionary];
       [params setValue:@(self.currentPage) forKey:@"pageNo"];
       [params setValue:@(10) forKey:@"pageSize"];

       @weakify(self)
       NSLog(@"params = %@",params);
       [[ApiFetch share] spotGetFetch:SPOT_DAILILIST
                                      query:params
                                     holder:self
                                  dataModel:SpotSurrounding.class
                                  onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
                //       TODO 此处补全数据
                SpotSurrounding *spotSurrounding = (SpotSurrounding*) modelValue;
                [weak_self.spotsList addObjectsFromArray:spotSurrounding.list];
                weak_self.currentPage = spotSurrounding.page.pageNo+1;
                [weak_self.tableView reloadData];
                [weak_self.tableView.mj_footer endRefreshing];
                if(weak_self.spotsList.count == spotSurrounding.page.totalCount)
                {
                    [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
}
-(void)loadMoreData
{
    if(self.isDaiLiDiaoChang==YES)
    {
        [self getDaiLiSports];
        
    }else{
        [self getHotSports];
    }
}
-(void)getHotSports
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@(1) forKey:@"searchType"];
    [params setValue:self.searchStr forKey:@"key"];
    [params setValue:@(self.currentPage) forKey:@"pageNo"];
    @weakify(self)
    NSLog(@"params = %@",params);
    [[ApiFetch share] infoGetFetch:INFO_SEARCH
                                   query:params
                                  holder:self
                               dataModel:SpotSurrounding.class
                               onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
             //       TODO 此处补全数据
             SpotSurrounding *spotSurrounding = (SpotSurrounding*) modelValue;
             [weak_self.spotsList addObjectsFromArray:spotSurrounding.list];
             weak_self.currentPage = spotSurrounding.page.pageNo+1;
             [weak_self.tableView reloadData];
             [weak_self.tableView.mj_footer endRefreshing];
             if(weak_self.spotsList.count == spotSurrounding.page.totalCount)
             {
                 [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
             }
         }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self.tableView.mj_footer endRefreshing];
    [self hideHud];

}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.spotsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaoChangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaoChangSearchTableViewCell" forIndexPath:indexPath];
    if (self.spotsList.count) {
          
          SpotSurround * spotSurronund = self.spotsList[indexPath.row];
          cell.lastLabel.text =spotSurronund.address;
          //attestation 1 未认证 2认证
          cell.leftLabel.text =((spotSurronund.attestation==2)?@"认证":@"");
          cell.centerLabel.text =((spotSurronund.game==2)?@"赛事":@"");
          cell.rightLabel.text =((spotSurronund.activity==2)?@"活动":@"");
          [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:spotSurronund.icon]placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
          cell.titleLabel.text = spotSurronund.name;
          cell.starsView.score =spotSurronund.star;
      }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DiaoChangDetailViewController *diaoChangDetailVc = [[DiaoChangDetailViewController alloc]init];
    SpotSurround * spotSurronund = self.spotsList[indexPath.row];
    diaoChangDetailVc.spotId  = spotSurronund.id;
    [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
    
}
-(void)searchButtonClick:(NSString *)searchStr
{
    self.searchStr = searchStr;
    [self initPageData];
}


@end
