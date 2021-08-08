//
//  ZhuanQuJiFenViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/9.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ZhuanQuJiFenViewController.h"
#import "ZhuanQuJiFenTableViewCell.h"
@interface ZhuanQuJiFenViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *sectionArr;
}
@end

@implementation ZhuanQuJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sectionArr = @[@"新手任务",@"日常任务"];
    [self setNavViewWithTitle:@"赚取积分" isShowBack:YES];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(hkNavigationView.frame)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZhuanQuJiFenTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZhuanQuJiFenTableViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhuanQuJiFenTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"ZhuanQuJiFenTableViewCell" forIndexPath:indexPath];
    cell.detailLabel.text = @"首次成功发布渔获可额外获得，在\"钓场详情-渔获\"中发布";
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionArr objectAtIndex:section];
}
@end
