//
//  GoodsPayTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GoodsPayTableViewController.h"
#import "OrderPayTableViewCell.h"
#import "ExchangeBillViewController.h"
#import "GoodsOrderComfirmViewController.h"
@interface GoodsPayTableViewController ()
@property(strong,nonatomic)NSMutableArray * orderList;
@property(assign,nonatomic)NSInteger currentPage;
@end

@implementation GoodsPayTableViewController

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
    [[ApiFetch share]goodsGetFetch:GOODS_ORDERLISTS query:@{@"status":@(self.stateForList),@"pageNo":@(self.currentPage)} holder:self dataModel:GoodsOrderLists.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        GoodsOrderLists *lists =(GoodsOrderLists *)modelValue;
        [weak_self.orderList addObjectsFromArray:lists.list];
        [weak_self.tableView reloadData];
        weak_self.currentPage = weak_self.currentPage+1;
        [weak_self.tableView.mj_footer endRefreshing];
        [weak_self.tableView.mj_header endRefreshing];
        if(weak_self.orderList.count == lists.page.totalCount)
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
    [cell bindForGoods:self.orderList[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsOrderListItem *item = self.orderList[indexPath.row];
    if(self.stateForList == 2)
    {
        ExchangeBillViewController*vc =[[ExchangeBillViewController alloc]init];
        vc.orderStr = item.code;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dict setValue:item.code forKey:@"code"];
        [[ApiFetch share]goodsGetFetch:GOODS_ORDERDETAIL query:dict holder:self dataModel:GoodsOrderDetail.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
            GoodsOrderDetail *goodsOrderDetail = (GoodsOrderDetail *) modelValue;
            GoodsOrderComfirmViewController*vc = [[GoodsOrderComfirmViewController alloc]initWithNibName:@"GoodsOrderComfirmViewController" bundle:nil];
            vc.isRealEnty = YES;
            vc.spotName = goodsOrderDetail.spotName;
            vc.spotAddress =goodsOrderDetail.address;
            vc.skuPrice = goodsOrderDetail.order.currency/ goodsOrderDetail.order.number;
            vc.price= goodsOrderDetail.goods.price;
            vc.count = goodsOrderDetail.order.number;
            vc.isPeiSong = (goodsOrderDetail.order.receiveType==2);
            vc.address = goodsOrderDetail.address;
            vc.orderStr = item.code;
            vc.coverImg = goodsOrderDetail.goods.coverImg;
            vc.count = item.number;
            vc.isPeiSong = (item.receiveType == 2);
            vc.orderStr = item.code;
            vc.remark = goodsOrderDetail.order.remark;
            vc.selectSku = goodsOrderDetail.selectSku;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.stateForList == 1)
    {
        UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) name:@"        下单后15分钟内未支付订单将被系统清除，请尽快支付" font:[UIFont systemFontOfSize:15] textColor:[UIColor lightGrayColor]];
        label.textAlignment = NSTextAlignmentLeft;
        return label;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        return view;
    }
}
- (void)onOptionalFailureHandler:(NSString *)message uri:(NSString *)uri{
    [self.tableView.mj_header endRefreshing];
    [self hideHud];
}
- (BOOL)autoHudForLink:(NSString *)link{
    return YES;
}
@end
