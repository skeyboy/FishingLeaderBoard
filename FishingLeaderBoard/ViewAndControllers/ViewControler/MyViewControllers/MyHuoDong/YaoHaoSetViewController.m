//
//  YaoHaoSetViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YaoHaoSetViewController.h"
#import "FSSegmentTitleView.h"
@interface YaoHaoSetViewController ()<FSSegmentTitleViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *yaoHaoSetView;
    UIView *zhanWaiDiaoYouView;
    UITableView*tableView;
}
@end

@implementation YaoHaoSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavViewWithTitle:@"摇号设置" isShowBack:YES];
    [self initPageView];
}
-(void)initPageView
{
    FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, 45) delegate:self indicatorType:1];
             titleView.titlesArr = @[@"摇号设置",@"站外钓友"];
             [self.view addSubview:titleView];
             titleView.titleSelectColor= BLACKCOLOR;
             titleView.indicatorColor = BLACKCOLOR;
             titleView.backgroundColor = WHITECOLOR;
    [self.view addSubview:titleView];
    //添加摇号设置页面
    yaoHaoSetView = [FViewCreateFactory createViewWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar-45) bgColor:WHITECOLOR];
    [self.view addSubview:yaoHaoSetView];
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       [confirmBtn setTitle:@"添加站外钓友" forState:UIControlStateNormal];
       [confirmBtn setBackgroundColor:NAVBGCOLOR];
       [confirmBtn setTintColor:WHITECOLOR];
       confirmBtn.layer.cornerRadius = 5;
    [confirmBtn addTarget:self action:@selector(addZhanWaiDiaoYou:) forControlEvents:UIControlEventTouchUpInside];
       [yaoHaoSetView addSubview:confirmBtn];
       [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(yaoHaoSetView.mas_top).offset(20);
           make.height.equalTo(@40);
           make.left.equalTo(yaoHaoSetView.mas_left).offset(10);
           make.right.equalTo(yaoHaoSetView.mas_right).offset(-10);
       }];
    UILabel *label = [FViewCreateFactory createLabelWithName:@"1、报名后自动分配号码；" font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor]];
    [yaoHaoSetView addSubview:label];
    label.textAlignment = NSTextAlignmentLeft;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmBtn.mas_bottom).offset(10);
        make.height.equalTo(@21);
        make.left.equalTo(yaoHaoSetView.mas_left).offset(10);
        make.right.equalTo(yaoHaoSetView.mas_right).offset(-10);
    }];
    UILabel *label1 = [FViewCreateFactory createLabelWithName:@"2、请在\"我发起的-报名情况\"中查看序号" font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor]];
    label1.textAlignment = NSTextAlignmentLeft;
    [yaoHaoSetView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.height.equalTo(@21);
        make.left.equalTo(yaoHaoSetView.mas_left).offset(10);
        make.right.equalTo(yaoHaoSetView.mas_right).offset(-10);
    }];
    UILabel *label2 = [FViewCreateFactory createLabelWithName:@"3、非App注册用户参与摇号，请添加手机号参与摇号"font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor]];
    [yaoHaoSetView addSubview:label2];
    label2.textAlignment = NSTextAlignmentLeft;
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom);
        make.height.equalTo(@21);
        make.left.equalTo(yaoHaoSetView.mas_left).offset(10);
        make.right.equalTo(yaoHaoSetView.mas_right).offset(-10);
    }];
    
    //设置站外钓友页面
      zhanWaiDiaoYouView = [FViewCreateFactory createViewWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar-45) bgColor:WHITECOLOR];
      [self.view addSubview:zhanWaiDiaoYouView];
    zhanWaiDiaoYouView.hidden = YES;
    
         tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar-45) style:UITableViewStylePlain];
          tableView.delegate = self;
          tableView.dataSource = self;
          [zhanWaiDiaoYouView addSubview:tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@""];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"13621019411";
    cell.detailTextLabel.text = @"2019年11月02日 11:14";
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"3";
    label.textAlignment = NSTextAlignmentRight;
    label.frame=CGRectMake(SCREEN_WIDTH-110, 20, 100, 21);
    cell.accessoryView =label;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [FViewCreateFactory createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55) bgColor:WHITECOLOR];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 21)];
    label.text = @"手机号";
    label.font = [UIFont boldSystemFontOfSize:13];
    [v addSubview:label];
    label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 20, 60, 21)];
    label.text = @"号码";
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont boldSystemFontOfSize:13];
    [v addSubview:label];
    UIView *line = [FViewCreateFactory createViewWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 1) bgColor:BLACKCOLOR];
    [v addSubview:line];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}
-(void)addZhanWaiDiaoYou:(UIButton *)btn
{
    [self addAlert];
}

-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"号码分配" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请添加手机号" ;
        }];
         UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
             //弹出请输入正确的手机号
             [self addAlert];
         }];
      UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
}
-(void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    if(startIndex!=endIndex)
    {
        if(endIndex == 0)
        {
            yaoHaoSetView.hidden = NO;
            zhanWaiDiaoYouView.hidden = YES;
        }else{
            yaoHaoSetView.hidden = YES;
            zhanWaiDiaoYouView.hidden = NO;
        }
    }
}
@end
