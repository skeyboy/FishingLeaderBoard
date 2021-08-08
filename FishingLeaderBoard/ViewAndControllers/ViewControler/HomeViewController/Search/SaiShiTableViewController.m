//
//  SaiShiTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SaiShiTableViewController.h"
#import "EnrollGameNewViewController.h"
@interface SaiShiTableViewController ()<ApiFetchOptionalHandler>
@property(strong,nonatomic)NSMutableArray *gamesList;
@property(strong,nonatomic)NSMutableArray *actesList;

@property(assign,nonatomic)NSInteger currentGamePage;
@property(assign,nonatomic)NSInteger currentActPage;

@property(strong,nonatomic)NSString *searchStr;
@end

@implementation SaiShiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
    [self initPageData];

}
-(void)initPageView
{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-Height_NavBar-20-44);
       [self.tableView registerNib:[UINib nibWithNibName:@"SaiShiTableViewCell" bundle:nil] forCellReuseIdentifier:@"SaiShiTableViewCell"];
       self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
       MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
             [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
             [footer setTitle:@"" forState:MJRefreshStateIdle];
             [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
             self.tableView.mj_footer = footer;
             self.tableView.showsVerticalScrollIndicator = NO;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.pageType == 2)
    {
        return self.gamesList.count;
    }else{
        return self.actesList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SaiShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaiShiTableViewCell" forIndexPath:indexPath];
    if(self.pageType == 2)
    {
        [cell bind:self.gamesList[indexPath.row]];
    }else{
        [cell bind:self.actesList[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventGameDetail *ev = nil;
    if(self.pageType == 2)
    {
        ev = self.gamesList[indexPath.row];
    }else{
        ev = self.actesList[indexPath.row];
    }
    EnrollGameNewViewController*vc = [[EnrollGameNewViewController alloc]init];
    vc.eventId = ev.id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 数据请求
-(void)initPageData
{
    if(self.pageType == 2)
    {
        self.currentGamePage = 1;
           self.gamesList = [[NSMutableArray alloc]init];
           [self getGames];
    }else{
        self.currentActPage = 1;
        self.actesList = [[NSMutableArray alloc]init];
        [self getGames];
    }
   
}
-(void)loadMoreData
{
    [self getGames];
}
-(void)getGames
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:self.searchStr forKey:@"key"];
    [params setValue:@(self.pageType) forKey:@"searchType"];
    if(self.pageType == 2)
    {
        [params setValue:@(self.currentGamePage) forKey:@"pageNo"];
    }else{
        [params setValue:@(self.currentActPage) forKey:@"pageNo"];
    }
    @weakify(self)
    NSLog(@"params = %@",params);
    [[ApiFetch share] infoGetFetch:INFO_SEARCH
                                   query:params
                                  holder:self
                               dataModel:EventSpotGame.class
                               onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
             //       TODO 此处补全数据
             EventSpotGame *ev = (EventSpotGame*) modelValue;
        if(self.pageType == 2)
        {
            [weak_self.gamesList addObjectsFromArray:ev.list];
            weak_self.currentGamePage ++;
            if(weak_self.gamesList.count == ev.page.totalPage)
            {
                [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [weak_self.actesList addObjectsFromArray:ev.list];
            weak_self.currentActPage ++;
            if(weak_self.gamesList.count == ev.page.totalPage)
            {
                [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
             [weak_self.tableView reloadData];
             [weak_self.tableView.mj_footer endRefreshing];
          
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
-(void)searchButtonClick:(NSString *)searchStr
{
    self.searchStr = searchStr;
    [self initPageData];
}


@end
