//
//  MyViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *myIconArr;
}
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
     myIconArr = [MyDataObject getMyData];
    _myHeadView = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Height_StatusBar +110 + 80 )vc:self];
    [self.view addSubview:_myHeadView];
    

    self.userTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_myHeadView.frame)+10 , SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_myHeadView.frame) - Height_TabBar -10) style:UITableViewStyleGrouped];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.view addSubview:self.userTableView];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [myIconArr objectAtIndex:section];
    return arr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分普通用户和钓场主
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArr = [myIconArr objectAtIndex:indexPath.section];
    NSDictionary *dict =[sectionArr objectAtIndex:indexPath.row];
    MyTableViewCell *cell =[self.userTableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImage.image=[UIImage imageNamed:[dict objectForKey:@"imageName"]];
    cell.centerLabel.text = [dict objectForKey:@"name"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        NSArray *arr = @[@"个人中心",@"钓场中心"];
        UILabel *headLabel  = [ FViewCreateFactory createLabelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-20*2, 40) name:[arr objectAtIndex:section] font:FONT_1 textColor:BLACKCOLOR];
        headLabel.textAlignment = NSTextAlignmentLeft;
        UIView *view = [FViewCreateFactory createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) bgColor:WHITECOLOR];
        [view addSubview:headLabel];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
@end
