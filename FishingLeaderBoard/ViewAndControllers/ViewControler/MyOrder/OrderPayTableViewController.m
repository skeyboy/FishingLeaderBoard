//
//  OrderPayTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "OrderPayTableViewController.h"
#import "OrderPayTableViewCell.h"
#import "EMOrderDetailViewController.h"
@interface OrderPayTableViewController ()<ApiFetchOptionalHandler>
@property(strong,nonatomic)NSMutableArray * orderList;
@property(assign,nonatomic)NSInteger currentPage;
@end
@implementation OrderPayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.orderList = [[NSMutableArray alloc]initWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderPayTableViewCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self getPageData];
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getPageData)];
      [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
      [footer setTitle:@"" forState:MJRefreshStateIdle];
      [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
      self.tableView.mj_footer = footer;
      self.tableView.showsVerticalScrollIndicator = NO;
      self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
      
}
-(void)initData
{      self.currentPage = 1;
      [self.orderList removeAllObjects];
      [self getPageData];
}
-(void)getPageData
{
    @weakify(self)
    [[ApiFetch share]orderGetFetch:ORDER_ENROLL_LIST query:@{@"payStatus":@(2),@"pageNo":@(self.currentPage)} holder:self dataModel:OrderApplyGameList.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        OrderApplyGameList *orderApplyGameList =(OrderApplyGameList*)modelValue;
        [weak_self.orderList addObjectsFromArray:orderApplyGameList.list];
        [weak_self.tableView reloadData];
        weak_self.currentPage = weak_self.currentPage+1;
        [weak_self.tableView.mj_footer endRefreshing];
        [weak_self.tableView.mj_header endRefreshing];
        if(weak_self.orderList.count == orderApplyGameList.page.totalCount)
        {
            [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderPayTableViewCell" forIndexPath:indexPath];

    [cell bind:self.orderList[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMOrderDetailViewController*vc =[[EMOrderDetailViewController alloc]init];
    vc.orderApplyGame = self.orderList[indexPath.row];
    vc.isOrder = YES;
    vc.intoPageType = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)onOptionalFailureHandler:(NSString *)message uri:(NSString *)uri{
    [self.tableView.mj_header endRefreshing];
    [self hideHud];
}
- (BOOL)autoHudForLink:(NSString *)link{
    return YES;
}
@end
