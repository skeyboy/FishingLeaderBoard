//
//  SellerStockTableViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/20.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SellerStockTableViewController.h"
#import "SellerStock.h"
#import "SellerStockCell.h"
@interface SellerStockTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *stockTableView;
@property(nonatomic) NSMutableArray * listStock;
@end

@implementation SellerStockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:@"商品库存" isShowBack:YES];
    self.stockTableView.delegate = self;
    self.stockTableView.dataSource = self;
    self.stockTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.listStock = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.stockTableView registerNib:[UINib nibWithNibName:@"SellerStockCell" bundle:nil] forCellReuseIdentifier:@"SellerStockCell"];
    @weakify(self)

    self.stockTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weak_self refreshStock];
    }];
    [self.stockTableView.mj_header beginRefreshing];
}
-(void)refreshStock{
    @weakify(self)
      [[ApiFetch share] goodsGetFetch:BUSSINESS_LISTSTOCK
                                query:@{}
                               holder:self
                            dataModel:SellerStock.class
                            onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
          [weak_self.listStock removeAllObjects];
          [weak_self.listStock addObjectsFromArray:modelValue];
          [weak_self.stockTableView reloadData];
          [weak_self.stockTableView.mj_header endRefreshing];
      }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (!self.listStock) {
        return 0;
    }
    return self.listStock.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerStockCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerStockCell" forIndexPath:indexPath];
    
    [cell bindValue:self.listStock[indexPath.row]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
