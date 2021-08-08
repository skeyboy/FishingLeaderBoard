//
//  MyFaQiTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyFaQiTableViewController.h"
#import "MyHDFaQiTableViewCell.h"
#import "BaoMingDingDanViewController.h"
#import "YaoHaoSetViewController.h"
@interface MyFaQiTableViewController ()

@end

@implementation MyFaQiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyHDFaQiTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyHDFaQiTableViewCell"];
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
    MyHDFaQiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyHDFaQiTableViewCell" forIndexPath:indexPath];
    cell.topImageView.image = [UIImage imageNamed:@"page1"];
    cell.bottomLabel.text = @"正钓 日场 鲤鱼 龙腾垂钓园";
    cell.xiuGaiXinXiBtn.indexPath = indexPath;
    [cell.xiuGaiXinXiBtn addTarget:self action:@selector(xiugaixinxi:) forControlEvents:UIControlEventTouchUpInside];
    cell.baoMingQingKuangBtn.indexPath = indexPath;
    [cell.baoMingQingKuangBtn addTarget:self action:@selector(baomingqingkuang:) forControlEvents:UIControlEventTouchUpInside];
    cell.yaoHaoSheZhiBtn.indexPath = indexPath;
     [cell.yaoHaoSheZhiBtn addTarget:self action:@selector(yaphaoshezhi:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.indexPath = indexPath;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)xiugaixinxi:(CellButton *)btn
{
    NSLog(@"%ld,%ld",btn.indexPath.section,btn.indexPath.row);
}
-(void)baomingqingkuang:(CellButton *)btn
{
    BaoMingDingDanViewController *vc =[[BaoMingDingDanViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)yaphaoshezhi:(CellButton *)btn
{
    YaoHaoSetViewController*vc =[[YaoHaoSetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)deleteBtnClick:(CellButton *)btn
{
    
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
