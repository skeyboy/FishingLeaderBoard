//
//  DiaoChangDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailViewController.h"

@interface DiaoChangDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DiaoChangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self setNavViewWithTitle:@"钓场详情" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self initPageView];
}
#pragma mark - 页面初始化
-(void)initPageView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangDetailTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DCDBriefTableViewCell" bundle:nil] forCellReuseIdentifier:@"DCDBriefTableViewCell"];
    self.headView =[[DiaoChangHeadView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)+100, SCREEN_WIDTH, 200)];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    __weak __typeof(self) weakSelf = self;
    

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    DiaoChangDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DiaoChangDetailTableViewCell" forIndexPath:indexPath];
    DCDBriefTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DCDBriefTableViewCell" forIndexPath:indexPath];
//    if(indexPath.row ==0)
//    {
//    cell.arr = @[@"鲫鱼1",@"雪域2"];
//    [cell addCharView];
//    [cell addTypeFish];
//    }else if(indexPath.row == 1)
//    {
        cell.arr = @[@"鲫鱼",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域"];
        [cell addCharView];
        [cell addTypeFish];
    cell.noteLabel.text = @"vvwacdccoencoejoqjcoweoekokeojfirjernvirnievmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsdddddddddddddddddddddddddddddddddddddddddddddcnncejdiejiiowdjwodjomckdsncenfjrifjirjfiojeoalfnckaljnfkn;jnknknfk";
//    }else
//    {
//        @[@"鲫鱼1",@"雪域2",@"雪域3",@"雪域4",@"雪域5"];
//    }
   
    
    return cell;
}
@end
