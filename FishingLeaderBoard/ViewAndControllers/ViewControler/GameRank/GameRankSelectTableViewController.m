//
//  GameRankSelectTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GameRankSelectTableViewController.h"
#import "GameRankSelectTableViewCell.h"
#import "IntegralRankTableViewController.h"
@interface GameRankSelectTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GameRankSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageView];
}
-(void)initPageView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"赛事排名查询" isShowBack:YES];
    [hkNavigationView setNavLineHidden];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"GameRankSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"GameRankSelectTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameRankSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameRankSelectTableViewCell" forIndexPath:indexPath];
    
    cell.coverImageView.backgroundColor = [UIColor redColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralRankTableViewController *vc = [[IntegralRankTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
