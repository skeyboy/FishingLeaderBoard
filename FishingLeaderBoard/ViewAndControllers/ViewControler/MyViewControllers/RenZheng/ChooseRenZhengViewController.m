//
//  ChooseRenZhengViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ChooseRenZhengViewController.h"
#import "LPButton.h"
#import "ShiMingRenZhengViewController.h"
#import "DiaoChangZhuRenZhengViewController.h"
#import "AppDelegate.h"
@interface ChooseRenZhengViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation ChooseRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"我的认证" isShowBack:YES];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, SCREEN_WIDTH, 120) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
//    de.tbc.tabBar.hidden =YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 0)
    {
       //BUTTON_MY_NAME_TAG
        cell.textLabel.text = @"实名认证";
        UIButton *btn = [self btnTitle:@"去认证" image:@"arrow_primary" tag:BUTTON_MY_NAME_TAG];
        btn.frame = CGRectMake(SCREEN_WIDTH-100-10, 12.5, 90, 35);
        [cell.contentView addSubview:btn];
    }else{
         cell.textLabel.text = @"钓场认证";
         UIButton *btn = [self btnTitle:@"去认证" image:@"arrow_primary" tag:BUTTON_MY_DIAOCHANGRENZHENG_TAG];
         btn.frame = CGRectMake(SCREEN_WIDTH-100-10, 12.5, 90, 35);
         [cell.contentView addSubview:btn];
    }
    return cell;
}
-(LPButton *)btnTitle:(NSString *)title image:(NSString *)imageStr tag:(int)tag
{
    LPButton *btn  = [[LPButton alloc] init];
    btn.style = LPButtonStyleRight;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}
-(void)btnClick:(UIButton *)btn
{
    if(btn.tag == BUTTON_MY_DIAOCHANGRENZHENG_TAG)
    {
        DiaoChangZhuRenZhengViewController *vc = [[DiaoChangZhuRenZhengViewController alloc]init];
               [self.navigationController pushViewController:vc animated:YES];
    }else{
      ShiMingRenZhengViewController *vc = [[ShiMingRenZhengViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        ShiMingRenZhengViewController *vc = [[ShiMingRenZhengViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DiaoChangZhuRenZhengViewController *vc = [[DiaoChangZhuRenZhengViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
