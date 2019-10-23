//
//  BuHuoTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BuHuoTableViewController.h"

@interface BuHuoTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BuHuoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.pageType == FPageTypeBuHuoView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    }else if(self.pageType == FPageTypeDiaoChangView)
    {
        [self setNavViewWithTitle:@"" isShowBack:NO];
        [hkNavigationView setNavBarViewLeftSearchTag:SEARCH_DIAOCHANG_TAG];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [hkNavigationView setNavBarViewRightBtnWithTitle:@"未知" normalImage:@"location" highlightedImage:@"location" target:self action:@selector(btnRightClick:)];
        hkNavigationView.searchClick = ^(UISearchBar * search) {
            
        };
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
        DiaoChangHeadView *headView = [[[NSBundle mainBundle]loadNibNamed:@"DiaoChangHeadView" owner:self options:nil]firstObject];
        self.tableView.tableHeaderView = headView;
    }
    [self initPageView];

}
-(void)initPageView
{
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuHuoTableViewCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorColor = CLEARCOLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
}
-(void)btnRightClick:(UIButton *)btn
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuHuoTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.button1.tag = 900+indexPath.row*2;
    cell.button2.tag = 900+indexPath.row*2+1;
    [cell.userButton1 setImage:[UIImage imageNamed:@"page1"] forState:UIControlStateNormal];
    [cell.userButton2 setImage:[UIImage imageNamed:@"page1"] forState:UIControlStateNormal];
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
