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
@interface DiaoChangListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DiaoChangListHeadView *headView;
}
@end

@implementation DiaoChangListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Height_BottomLine-Height_StatusBar) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    headView = [[[NSBundle mainBundle]loadNibNamed:@"DiaoChangListHeadView" owner:self options:nil]firstObject];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = headView;
    
     [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangSearchTableViewCell"];
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



@end
