//
//  OrderNoPayTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "OrderNoPayTableViewController.h"
#import "OrderPayTableViewCell.h"
#import "NOPayDetailViewController.h"
#import "EMOrderDetailViewController.h"
@interface OrderNoPayTableViewController ()
@property(strong,nonatomic)NSMutableArray * orderList;
@end

@implementation OrderNoPayTableViewController

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
    [[ApiFetch share]orderGetFetch:ORDER_ENROLL_LIST query:@{@"payStatus":@(1)} holder:self dataModel:OrderApplyGame.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"mmm = %@",modelValue);
        [weak_self.orderList addObjectsFromArray:(NSArray*)modelValue];
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
    
    [cell bind:[self.orderList objectAtIndex:indexPath.row]];
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
    EMOrderDetailViewController*vc =[[EMOrderDetailViewController alloc]init];
    vc.intoPageType = self.intoPageType;
    vc.orderApplyGame = self.orderList[indexPath.row];
    vc.isOrder = NO;
    if(vc.intoPageType == 2)
    {
        vc.vc = self.vc;
    }else if(vc.intoPageType == 1){
        vc.vc = self;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
