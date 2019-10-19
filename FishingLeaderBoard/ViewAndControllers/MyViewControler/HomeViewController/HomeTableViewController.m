//
//  HomeTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "HomeTableViewController.h"

@interface HomeTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arrTableSource;
}
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.headType == FPageTypeFishingClassHeadView)
    {
        [self setNavFishingClass];
    }else{
        [self setNavHome];
    }
    [self initPageView];
}
-(void)setNavFishingClass
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"钓技课堂" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)setNavHome
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"" isShowBack:NO];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [hkNavigationView setNavBarViewLeftBtnWithTitle:@"扫一扫" normalImage:@"saoyisao" highlightedImage:@"saoyisao" target:self action:@selector(btnLeftClick:)];
    [hkNavigationView setNavBarViewRightBtnWithTitle:@"消息" normalImage:@"msg" highlightedImage:@"msg" target:self action:@selector(btnRightClick:)];
    
    [hkNavigationView setNavBarViewCenterSearchTag:SEARCH_HOME_TAG];
    __weak __typeof(self) weakSelf = self;
    hkNavigationView.searchClick = ^(UISearchBar * search) {
        SearchViewController *vc =[[SearchViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
-(void)btnLeftClick:(UIButton *)btn
{
    
}
-(void)btnRightClick:(UIButton *)btn
{
    
}
-(void)initPageView
{
    arrTableSource = @[@"账号和或或或或或或",@"男男女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女斤斤计较军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainOneTableViewCell"];
    int headY = 0;
    if(_headType == FPageTypeHomeHeadView)
    {
        headY = 120 +150 +120 + 80 + 45;
    }else{
        headY = 40 + 10 + 60 + 10 + 60 + 10 + 45;
    }
    self.headView = [[HomeHeadTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headY) withType:_headType];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    __weak __typeof(self) weakSelf = self;
    self.headView.segmentCtrlClick = ^(UISegmentedControl * sem) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        NSLog(@"seg click");
    };
    self.headView.btnCtrlClick = ^(UIButton * btn) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        [strongSelf btnClick:btn];
    };
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 3||indexPath.row ==8 )
    {
        MainOneTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MainOneTableViewCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleTextLabel.text = [arrTableSource objectAtIndex:(indexPath.row%2)];
        cell.imageView1.image = [UIImage imageNamed:@"page1"];
        cell.timeLabel.text = @"19/19月05日 17：16";
        return cell;
    }else{
        MainTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleTextLabel.text = [arrTableSource objectAtIndex:(indexPath.row%2)];
        cell.imageView1.image = [UIImage imageNamed:@"page1"];
        cell.imageView2.image = [UIImage imageNamed:@"page1"];
        cell.imageView3.image = [UIImage imageNamed:@"page1"];
        cell.detailTimeLabel.text = @"19/19月05日 17：16";
        return cell;
    }
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *text = [arrTableSource objectAtIndex:(indexPath.row%2)];
//   CGSize size = [ToolClass sizeWithText:text font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH - 165 , 500)];
//    if(indexPath.row == 3||indexPath.row == 8)//一张图的时候
//    {
//        float h = size.height + 100;
//        if(h < 110)
//        {
//            h = 110;
//        }
//        return h;
//    }
//    //多张图
//    return 130  +size.height;
//}
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

-(void)btnClick:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    switch (tag) {
        case BUTTON_FISHCLASS_HOME_TAG:
            {
                HomeTableViewController *fishingClassVc = [[HomeTableViewController alloc]init];
                fishingClassVc.headType = FPageTypeFishingClassHeadView;
                [self.navigationController pushViewController:fishingClassVc animated:YES];
            }
            break;
            
        default:
            break;
    }
    
}

@end
