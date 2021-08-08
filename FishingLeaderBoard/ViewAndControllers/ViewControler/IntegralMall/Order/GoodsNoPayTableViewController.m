//
//  GoodsNoPayTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GoodsNoPayTableViewController.h"
#import "OrderPayTableViewCell.h"
#import "GoodsOrderComfirmViewController.h"
@interface GoodsNoPayTableViewController ()
@property(strong,nonatomic)NSMutableArray * orderList;
@end

@implementation GoodsNoPayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderList = [[NSMutableArray alloc]initWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderPayTableViewCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self getPageData];
}
-(void)getPageData
{
    @weakify(self)
    [self.orderList removeAllObjects];
    [[ApiFetch share]goodsGetFetch:GOODS_ORDERLISTS query:@{@"status":@(1)} holder:self dataModel:GoodsOrderLists.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"mmm = %@",modelValue);
        GoodsOrderLists *lists =(GoodsOrderLists *)modelValue;
        [weak_self.orderList addObjectsFromArray:lists.list];
        [weak_self.tableView reloadData];
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
    [cell bindForGoods:[self.orderList objectAtIndex:indexPath.row]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) name:@"        下单后15分钟内未支付订单将被系统清除，请尽快支付" font:[UIFont systemFontOfSize:15] textColor:[UIColor lightGrayColor]];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsOrderComfirmViewController*vc =[[GoodsOrderComfirmViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
