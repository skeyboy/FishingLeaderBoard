//
//  SaiShiListTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SaiShiListTableViewController.h"
#import "EnrollGameNewViewController.h"
@interface SaiShiListTableViewController ()<FSSegmentTitleViewDelegate,STSegmentViewDelegate,ApiFetchOptionalHandler>
{
}
@end

@implementation SaiShiListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"SaiShiListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SaiShiListTableViewCell"];
    [self initViewPage];
    [self initPageData];
}
-(void)initViewPage
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
}
#pragma mark -获取数据
-(void)initPageData
{
    self.eventGames = [[NSMutableArray alloc]initWithCapacity:0];
    self.currentGamePage = 1;
    self.GameOrAct = 2;
    self.preRequest = [[NSMutableDictionary alloc]initWithCapacity:0];
      @weakify(self)
      AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
          [self showDefaultLoading];
          [appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
              [self hideHud];
              if (onError == nil) {
                  self.adCode = rgcData.adCode;
                 // [weak_self getGameAndActLists:rgcData.adCode];
              }else{
                  self.adCode = @"110100";
                 // [weak_self getGameAndActLists:@"110100"];
              
              }
              return YES;
          }];
}
-(void)changeTab{
    [self.eventGames removeAllObjects];
    [self.preRequest removeAllObjects];
     self.currentGamePage = 1;
    [self getGameAndActLists:self.adCode];
}
-(void)loadMoreData
{
    [self getGameAndActLists:self.adCode];
}
//活动赛事
-(void)getGameAndActLists:(NSString *)adCode
{
    [self.preRequest setValue:adCode forKey:@"areaId"];
    [self.preRequest setValue:@(self.currentGamePage) forKey:@"pageNo"];
    [self.preRequest setValue:@(self.GameOrAct) forKey:@"type"];
    [self.preRequest setValue:self.chooseTimeS forKey:@"startTime"];
    NSLog(@"getGameAndActLists参数= %@",self.preRequest);
    [[ApiFetch share] eventGetFetch:EVENT_GETLIST_BYCITY query:self.preRequest holder:self dataModel:EventSpotGame.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                  NSLog(@"%@",modelValue);
        [self reloadEvnets:(EventSpotGame*)modelValue];
        [self.tableView.mj_footer endRefreshing];
        
        EventSpotGame *info  = (EventSpotGame*)modelValue;
        if(self.eventGames.count == info.page.totalCount)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self hideHud];
    }];
}

-(void)reloadEvnets:(EventSpotGame *) eventSpotGame{
    self.currentGamePage = eventSpotGame.page.pageNo +1;
    [self.eventGames addObjectsFromArray:eventSpotGame.list];
    [self.tableView reloadData];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventGames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SaiShiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaiShiListTableViewCell" forIndexPath:indexPath];
    [cell bindValue:self.eventGames[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        EnrollGameNewViewController *vc =[[EnrollGameNewViewController alloc]init];
        EventSpotGameItem*item = [self.eventGames objectAtIndex:indexPath.row];
        vc.eventId = item.id;
        vc.isAct = (self.GameOrAct == 1);
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

}

//emdIndex 1:赛事，2活动
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    NSLog(@"选择 = %ld",endIndex);
    if(endIndex!=startIndex)
    {
        if(endIndex == 0)
        {
            self.GameOrAct = 2;//赛事
        }else{
            self.GameOrAct = 1; //活动
        }
    }
    [self changeTab];
}
//index 代表选择的周几
- (void)buttonClick:(NSInteger)index
{
    NSLog(@"周几 = %ld",index);
    NSArray *dateA = [ToolClass getDateArr];
    if(index == 0)
    {
        self.chooseTimeS = nil;
    }else{
        self.chooseTimeS = [dateA objectAtIndex:index-1];
    }
    [self changeTab];
}

-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
     [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
@end
