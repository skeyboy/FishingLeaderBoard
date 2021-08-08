//
//  SGoodsDuiHuanListableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/1/11.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SGoodsDuiHuanListableViewController.h"
#import "SellerExchangeCell.h"
#import "CurrencyOrder.h"
#import "FConstont.h"
@interface SGoodsDuiHuanListableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    __block NSInteger mCurrentPageNo;
}
@property(assign, nonatomic) NSInteger status;
@property(nonatomic)NSMutableArray * list;
@end

@implementation SGoodsDuiHuanListableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SellerExchangeCell" bundle:nil] forCellReuseIdentifier:@"SellerExchangeCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
              self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          } else {
              self.automaticallyAdjustsScrollViewInsets = NO;
          }
    

    if (self.finished) {
        self.status = 3;
    }else{
        self.status = 2;
    }
    self.list = [NSMutableArray array];
    mCurrentPageNo = 1;
    [self refresh];
    [self loadMore];
    // 马上进入刷新状态
       [self.tableView.mj_header beginRefreshing];
}
-(void)refresh{
    @weakify(self)
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        mCurrentPageNo = 1;
        //进行数据刷新操作
        [weak_self fetchOrRefresh:NO];
    }];
}
-(void)loadMore{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
@weakify(self)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self fetchOrRefresh:YES];
    }];
}
-(void)fetchOrRefresh:(BOOL) isLoadMore{
   
    [[ApiFetch share] goodsGetFetch:BUSSINESS_CURRENCY_ORDER
                              query:@{
                                  @"pageNo":@(mCurrentPageNo),
                                  @"status":@(self.status)
                              } holder:self
                          dataModel:CurrencyOrder.class
                          onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        CurrencyOrder *order = modelValue;
        if (isLoadMore) {
           
            [self.tableView.mj_footer endRefreshing];
            if (mCurrentPageNo == order.page.pageNo) {
                         
                           return ;
                       }
            mCurrentPageNo =order.page.pageNo+1;
        }else{
            mCurrentPageNo = 1;
            [self.list removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        }
        [self.list addObjectsFromArray:order.list];
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.list == nil) {
        return 0;
    }
    return self.list.count;
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   SellerExchangeCell *exchangeCell = [tableView dequeueReusableCellWithIdentifier:@"SellerExchangeCell"
                                                                         forIndexPath:indexPath];
      
    exchangeCell.finished = self.finished;
    exchangeCell.indexPath = indexPath;
    CurrencyOrderItem * item = self.list[indexPath.row];
    [exchangeCell bindValue:item];
          exchangeCell.sellerExchangeResult = ^(NSIndexPath * _Nonnull indexPath) {
              //TODO 补全商品兑换确认操作
              [[ApiFetch share] goodsGetFetch:BUSSINESS_CONFIRM_EXCHANGE
                                        query:@{
                                            @"code":item.code
                                        }
                                       holder:self
                                    dataModel:NSDictionary.class
                                    onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
                  [self fetchOrRefresh:YES];
                  [self makeToask:responseObject[@"message"]];
              }];
              
          };
    return exchangeCell;
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    return cell;
}



@end
#define hxNavigationBarHeight 44
@implementation ChuKuHistoryViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setNavViewWithTitle:@"出库记录" isShowBack:YES];
    SGoodsDuiHuanListableViewController * vc = [[SGoodsDuiHuanListableViewController alloc] init];
    vc.finished = YES;

    vc.view.frame = CGRectMake(0, hxNavigationBarHeight , SCREEN_WIDTH, CGRectGetHeight(self.view.frame)-hxNavigationBarHeight);
    [self addChildViewController:vc];
    
    [self.view addSubview:vc.view];
}

@end
