//
//  MyHDCanYuTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyHDCanYuTableViewController.h"
#import "SaiShiTableViewCell.h"
@interface MyHDCanYuTableViewController ()

@end

@implementation MyHDCanYuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self.tableView registerNib:[UINib nibWithNibName:@"SaiShiTableViewCell" bundle:nil] forCellReuseIdentifier:@"SaiShiTableViewCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SaiShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaiShiTableViewCell" forIndexPath:indexPath];
    cell.bgImageView.image = [UIImage imageNamed:@"page1"];
    cell.bottomLabel.text = @"正钓 日场 鲤鱼 龙腾垂钓园";
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
