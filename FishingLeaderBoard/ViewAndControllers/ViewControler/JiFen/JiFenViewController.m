//
//  JiFenViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/8.
//  Copyright © 2019 yue. All rights reserved.
//

#import "JiFenViewController.h"
#import "TwoLabel.h"
@interface JiFenViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     UIView *topView;
    TwoLabel *twoLabel;
    UITableView *tableView;
}
@end

@implementation JiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"兑换币/经验" isShowBack:YES];
    [hkNavigationView setNavLineHidden];
    topView = [FViewCreateFactory createViewWithBgColor:NAVBGCOLOR];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hkNavigationView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@120);
    }];
    twoLabel = [[TwoLabel alloc]init];
    [self.view addSubview:twoLabel];
    twoLabel.topLabel.text = @"29";
    twoLabel.topLabel.font = [UIFont boldSystemFontOfSize:20];
    twoLabel.topLabel.textColor = [UIColor whiteColor];
    twoLabel.bottomLabel.textColor = [UIColor whiteColor];
    twoLabel.bottomLabel.font=[UIFont systemFontOfSize:17];
    twoLabel.bottomLabel.text = @"兑换币";
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.width.equalTo(@(100));
        make.centerY.equalTo(topView.mas_centerY);
        make.height.equalTo(@(70));
    }];
    [self addButton];
    
    UIView *view = [FViewCreateFactory createViewWithBgColor:[UIColor lightGrayColor]];
     [self.view addSubview:view];
     [view mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(topView.mas_bottom).offset(90);
         make.left.equalTo(self.view.mas_left);
         make.width.equalTo(@(SCREEN_WIDTH));
         make.height.equalTo(@8);
     }];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120+90+Height_NavBar+8, SCREEN_WIDTH, SCREEN_HEIGHT-(120+90+Height_NavBar+8)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"每日签到";
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = @"2019年11月05日 08:57";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 12, 110, 30)];
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor redColor];
    label.text = @"+3";
    cell.accessoryView = label;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [FViewCreateFactory createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,65) bgColor:WHITECOLOR];
    UILabel *label1 = [FViewCreateFactory createLabelWithName:@"积分记录" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [v addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v.mas_top);
        make.height.equalTo(@40);
        make.left.equalTo(v.mas_left).offset(20);
    }];
    UILabel * label2 = [FViewCreateFactory createLabelWithName:@"积分项目" font:[UIFont boldSystemFontOfSize:13] textColor:BLACKCOLOR];
    [v addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom);
        make.height.equalTo(@20);
        make.left.equalTo(v.mas_left).offset(20);
    }];
    label2 = [FViewCreateFactory createLabelWithName:@"兑换币" font:[UIFont boldSystemFontOfSize:13] textColor:BLACKCOLOR];
       [v addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(label1.mas_bottom);
           make.height.equalTo(@20);
           make.right.equalTo(v.mas_right).offset(-20);
    }];
    UIView *line = [FViewCreateFactory createViewWithBgColor:[UIColor lightGrayColor]];
    [v addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v.mas_left);
        make.right.equalTo(v.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(v.mas_bottom);
    }];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}
-(void)addButton
{
    UIButton *btn1 = [self btnTitle:@"规则说明" image:@"jifen_guize"tag:1];
    UIButton *btn2 = [self btnTitle:@"每日签到" image:@"jifen_qiandao"tag:2];
    UIButton *btn3 = [self btnTitle:@"赚取积分" image:@"jifen_jifen"tag:3];
    UIButton *btn4 = [self btnTitle:@"积分商城" image:@"jifen_shangcheng"tag:4];
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3,btn4]];
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:20 tailSpacing:20];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.height.equalTo(@70);
    }];


}
-(LPButton *)btnTitle:(NSString *)title image:(NSString *)imageStr tag:(int)tag
{
    LPButton *btn  = [[LPButton alloc] init];
    btn.style = LPButtonStyleTop;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    return btn;
}
-(void)btnClick:(UIButton *)btn
{
    int tag = (int)btn.tag;
    if(tag == 1)//规则说明
    {
       
    }else if(tag == 2){//每日签到
        
        [self showJiZaiInfo:@"今日签到加载中..."];
        
    }else if(tag == 3){//赚取积分
        
        ZhuanQuJiFenViewController*vc =[[ZhuanQuJiFenViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{//积分商城
        [self showWithInfo:@"功能暂未开通，敬请期待！" delayToHideAfter:1];
    }
}
@end
