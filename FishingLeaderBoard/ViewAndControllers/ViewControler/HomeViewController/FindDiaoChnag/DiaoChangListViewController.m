//
//  DiaoChangListViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangListViewController.h"
#import "DiaoChangListHeadView.h"
#import "DiaoChangSearchTableViewCell.h"
#import "MenuView.h"
#import "DiaoChangDetailViewController.h"
@interface DiaoChangListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DiaoChangListHeadView *headView;
}
@end

@implementation DiaoChangListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Height_BottomLine-Height_NavBar-80) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    headView = [[[NSBundle mainBundle]loadNibNamed:@"DiaoChangListHeadView" owner:self options:nil]firstObject];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = headView;
    
     [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangSearchTableViewCell"];
    

    UIButton* btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, CGRectGetMaxY(self.tableView.frame)+10,SCREEN_WIDTH-40, 40) name:@"我是钓场主" delegate:self selector:@selector(intorenZheng:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 5.0;
    [self.view addSubview:btn];
    
     MenuView *menvView = [[MenuView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, CGRectGetMaxY(self.tableView.frame)-60*3-10, 60, 60*3) name:@[@"排序方式",@"人气",@"距离"] color:@[NAVBGCOLOR,[[UIColor alloc]initWithRed:251/255.0 green:79/255.0 blue:6/255.0 alpha:1],[[UIColor alloc]initWithRed:26/255.0 green:197/255.0 blue:136/255.0 alpha:1]]];
       [self.view addSubview:menvView];
       [self.view bringSubviewToFront:menvView];
       menvView.menuClick = ^(int index) {
           NSLog(@"%d",index);
       };
    
}
//我是钓场主d按钮点击事件
-(void)intorenZheng:(UIButton*)btn
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaoChangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaoChangSearchTableViewCell" forIndexPath:indexPath];
       cell.leftImageView.image = [UIImage imageNamed:@"page1"];
       cell.lastLabel.text =@"往事is促进法才能决定你参";
       cell.rightLabel.text = @"赛事";
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaoChangDetailViewController *diaoChangDetailVc = [[DiaoChangDetailViewController alloc]init];
    [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
}

@end
