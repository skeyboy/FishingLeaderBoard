//
//  DiaoChangDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailViewController.h"
#import "FSSegmentTitleView.h"
#import "ReleaseFishGetViewController.h"
@interface DiaoChangDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FSSegmentTitleViewDelegate>

@end

@implementation DiaoChangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self setNavViewWithTitle:@"钓场详情" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [self initPageView];
}
#pragma mark -FSSegmentTitleViewDelegate
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    NSLog(@"click =%ld",(long)endIndex);
    if(endIndex == 0)
    {
        self.cellType = FPageDCDAct;
    }else if (endIndex == 1)
    {
        self.cellType = FPageDCDJianJie;
    }else{
        self.cellType = FPageDCDFishGet;
    }
    if(startIndex!=endIndex)
    {
        [self.tableView reloadData];
    }
}
#pragma mark - 页面初始化
-(void)initPageView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.headView =[[DiaoChangDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
//    self.tableView.tableHeaderView = self.headView;
    self.headView = [[[NSBundle mainBundle]loadNibNamed:@"DiaoChangDetailHeadView" owner:self options:nil]firstObject];
    [_headView addAllViewDelegate:self];

    self.tableView.tableHeaderView =_headView;
    
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangDetailTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DCDBriefTableViewCell" bundle:nil] forCellReuseIdentifier:@"DCDBriefTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuHuoTableViewCell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    __weak __typeof(self) weakSelf = self;
    

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.cellType) {
        case FPageDCDAct:{
            return 10;
        }
        break;
        case FPageDCDJianJie:{
            return 1;
        }
            break;
        case FPageDCDFishGet:{
            return 13;
        }
            break;
        default: return 1;
            break;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(self.cellType ==FPageDCDJianJie)
    {
    DCDBriefTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DCDBriefTableViewCell" forIndexPath:indexPath];
        cell.arr = @[@"鲫鱼",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域",@"雪域"];
        [cell addCharView];
        [cell addTypeFish];
        cell.btnClick = ^(UIButton * btn) {
            ReleaseFishGetViewController*vc = [[ReleaseFishGetViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
    cell.noteLabel.text = @"vvwacdccoencoejoqjcoweoekokeojfirjernvirnievmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsdddddddddddddddddddddddddddddddddddddddddddddcnncejdiejiiowdjwodjomckdsncenfjrifjirjfiojeoalfnckaljnfkn;jnknknfk";
        
        return cell;
    }else if (self.cellType == FPageDCDAct)
    {
        DiaoChangDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DiaoChangDetailTableViewCell" forIndexPath:indexPath];
        return cell;
    }else {
        BuHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuHuoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.button1.tag = 900+indexPath.row*2;
        cell.button2.tag = 900+indexPath.row*2+1;
        [cell.userButton1 setImage:[UIImage imageNamed:@"page1"] forState:UIControlStateNormal];
        [cell.userButton2 setImage:[UIImage imageNamed:@"page1"] forState:UIControlStateNormal];
        return cell;
    }

   
    
}
@end
