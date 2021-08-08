//
//  BaoMingDingDanViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BaoMingDingDanViewController.h"
#import "FSSegmentTitleView.h"
#import "BaoMingDingDanTableViewCell.h"
@interface BaoMingDingDanViewController ()<FSSegmentTitleViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    TwoLabel *jinELabel;
    TwoLabel *dingDanLabel;
    TwoLabel *baoMingLabel;
    TwoLabel *heXiaoLabel;
    
    UITableView *tableView;
}
@end

@implementation BaoMingDingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"报名订单" isShowBack:YES];
    [self initPageView];
}
-(void)initPageView
{
    jinELabel = [[TwoLabel alloc]init];
    jinELabel.topLabel.text = @"99999999";
    jinELabel.bottomLabel.text = @"收入金额";
    jinELabel.bottomLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:jinELabel];
    dingDanLabel = [[TwoLabel alloc]init];
    dingDanLabel.topLabel.text = @"1";
    dingDanLabel.bottomLabel.text = @"订单数量";
    dingDanLabel.bottomLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:dingDanLabel];
    baoMingLabel = [[TwoLabel alloc]init];
    baoMingLabel.topLabel.text = @"2";
    baoMingLabel.bottomLabel.text = @"报名人数";
    baoMingLabel.bottomLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:baoMingLabel];
    heXiaoLabel = [[TwoLabel alloc]init];
    heXiaoLabel.topLabel.text = @"1";
    heXiaoLabel.bottomLabel.text = @"核销人数";
    heXiaoLabel.bottomLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:heXiaoLabel];
    NSArray *arr = @[jinELabel,dingDanLabel,baoMingLabel,heXiaoLabel];
     [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:SCREEN_WIDTH/4.0 leadSpacing:0 tailSpacing:0];
      [arr mas_makeConstraints:^(MASConstraintMaker *make){
          make.top.equalTo(hkNavigationView.mas_bottom).offset(10);
          make.height.equalTo(@80);
      }];
    FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, Height_NavBar+80+20, SCREEN_WIDTH, 45) delegate:self indicatorType:1];
             titleView.titlesArr = @[@"已报名",@"已核销"];
             [self.view addSubview:titleView];
             titleView.titleSelectColor= BLACKCOLOR;
             titleView.indicatorColor = BLACKCOLOR;
             titleView.backgroundColor = WHITECOLOR;
    [self.view addSubview:titleView];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titleView.frame)+10 , SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(titleView.frame) -10) style:UITableViewStylePlain];
       tableView.delegate = self;
       tableView.dataSource = self;
       [self.view addSubview:tableView];
       
       [tableView registerNib:[UINib nibWithNibName:@"BaoMingDingDanTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaoMingDingDanTableViewCell"];
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoMingDingDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaoMingDingDanTableViewCell" forIndexPath:indexPath];
    return cell;
}
-(void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    
}
@end
