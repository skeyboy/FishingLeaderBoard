//
//  MyViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPageView];
    self.view.backgroundColor = LOGINBGCOLOR;
}

-(void)initPageView
{
    _myHeadView = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Height_StatusBar +110 + 80 )];
    [self.view addSubview:_myHeadView];
    UILabel *headLabel  = [ FViewCreateFactory createLabelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-20*2, 40) name:@"个人中心" font:FONT_1 textColor:BLACKCOLOR];
    headLabel.textAlignment = NSTextAlignmentLeft;
    UIView *view = [FViewCreateFactory createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) bgColor:WHITECOLOR];
    [view addSubview:headLabel];
    self.userTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_myHeadView.frame)+10 , SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_myHeadView.frame) - Height_TabBar -10) style:UITableViewStylePlain];
    self.userTableView.tableHeaderView = view;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.view addSubview:self.userTableView];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"id"];
    
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
//    }
//    cell.textLabel.text =[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row];
    MyTableViewCell *cell =[self.userTableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImage.image=[UIImage imageNamed:@"fabu_my"];
    cell.centerLabel.text = @"我的发布";
    cell.rightView.image = [UIImage imageNamed:@"rightInto_b"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
