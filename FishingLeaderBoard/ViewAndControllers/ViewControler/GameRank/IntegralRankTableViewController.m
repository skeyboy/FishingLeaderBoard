//
//  IntegralRankTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "IntegralRankTableViewController.h"
#import "IntegralRankHeadView.h"
#import "IntegralRankTableViewCell.h"
#import "YuRankShareViewController.h"
@interface IntegralRankTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)IntegralRankHeadView *headView;

@end

@implementation IntegralRankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;

         [self initPageView];
    
}
-(void)shareClick:(UIButton *)btn
{
       if(![[AppManager manager]userHasLogin])
         {
             [self showDefaultInfo:@"请先登录"];
             return;
         }
    [self.tableView scrollToTopAnimated:YES];
    
    
    YuRankShareViewController * rankShareVc = [[YuRankShareViewController alloc] init];
    rankShareVc.paimingLists = self.paimingLists;
    rankShareVc.nameStr = self.nameStr;
    [self presentViewController:rankShareVc
                       animated:YES
                     completion:^{
        
    }];
}
-(void)initPageView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"赛事排名" isShowBack:YES];
    [hkNavigationView setNavLineHidden];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
       btn.frame =CGRectMake(SCREEN_WIDTH/2.0+50, Height_StatusBar+12, 20, 20);
       [btn setImage:[UIImage imageNamed:@"shuoming_w"] forState:UIControlStateNormal];
       [btn addTarget:self action:@selector(shuomingBiaoTiclick:) forControlEvents:UIControlEventTouchUpInside];
       [hkNavigationView addSubview:btn];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    if ([YuWeChatShareManager isWXAppInstalled]) {
         UIButton *share = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(SCREEN_WIDTH-50, Height_StatusBar+10, 30, 30) name:@"" delegate:self selector:@selector(shareClick:) tag:0];
         [share setImage:[UIImage imageNamed: @"share_nav"] forState:UIControlStateNormal];
         [hkNavigationView addSubview:share];
     }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"IntegralRankTableViewCell" bundle:nil] forCellReuseIdentifier:@"IntegralRankTableViewCell"];
    self.headView = [[[NSBundle mainBundle]loadNibNamed:@"IntegralRankHeadView" owner:self options:nil]firstObject];
     self.tableView.tableHeaderView = self.headView;
    [self.tableView.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@70);
        make.width.equalTo(@(SCREEN_WIDTH));
     }];
    [self.view addSubview:self.tableView];
    
    
}
-(void)shuomingBiaoTiclick:(UIButton *)btn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"1、一个赛事/活动多次报名情况，只统计第一次报名时的排名；\n2、一次报名多人，只算1人成绩；" preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alert.view.subviews[0];

    UIView *subView2 = subView1.subviews[0];

    UIView*subView3 = subView2.subviews[0];

    UIView*subView4 = subView3.subviews[0];

    UIView*subView5 = subView4.subviews[0];

    for(int i=0;i<subView5.subviews.count;i++)
    {
        if([subView5.subviews[i] isKindOfClass:UILabel.class])
        {
            UILabel *label = subView5.subviews[i];
            if([label.text isEqualToString:@"1、一个赛事/活动多次报名情况，只统计第一次报名时的排名；\n2、一次报名多人，只算1人成绩；"])
            {
                label.textAlignment = NSTextAlignmentLeft;
            }
        }
    }
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.paimingLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRankTableViewCell" forIndexPath:indexPath];
    PaiMingItem *paimingitem = [self.paimingLists objectAtIndex:indexPath.row];
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:paimingitem.headImg]placeholderImage:[UIImage imageNamed:@"noHead"]];
    cell.nameLabel.text = paimingitem.nickName;
    cell.integralLabel.text = [NSString stringWithFormat:@"%ld",paimingitem.currencyCount];
    cell.chengjiLabel.text =[NSString stringWithFormat:@"%ld",paimingitem.buyBackCount];
    if(indexPath.row==0)//第一名
    {
        cell.mingCiImgView.image = [UIImage imageNamed:@"no1"];
    }else if(indexPath.row == 1)//第二名
    {
        cell.mingCiImgView.image = [UIImage imageNamed:@"no2"];

    }else if(indexPath.row==2){//第三名
        cell.mingCiImgView.image = [UIImage imageNamed:@"no3"];

    }else{
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
      cell.mingCiImgView.image = [UIImage imageNamed:@""];

    }
    return cell;
}

@end
