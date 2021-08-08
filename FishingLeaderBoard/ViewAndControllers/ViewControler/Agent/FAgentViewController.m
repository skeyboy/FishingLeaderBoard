//
//  FAgentViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FAgentViewController.h"
#import "CostomProgressView.h"
#import "FAentTableViewCell.h"
#import "SaiShiShenPiViewController.h"
#import "DiaoChangSearchTableViewController.h"
#import "ZhangMuGuanLiViewController.h"
#import "AgentInfo.h"
#import "Commissioner.h"
#import "FishingLeaderBoard-Swift.h"
#import "EnrollGameNewViewController.h"
@interface FAgentViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet ColorLabel *isRenZhengLabel;
@property (weak, nonatomic) IBOutlet UILabel *yaoqingmaLabel;

@property (weak, nonatomic) IBOutlet UIButton *showCode;
@property (weak, nonatomic) IBOutlet UIView *bgTowView;

@property (weak, nonatomic) IBOutlet UIView *bgFourView;
@property (weak, nonatomic) IBOutlet UIView *bgProgressView;

@property __block AgentInfo *agentInfo;


@property(strong,nonatomic)NSMutableArray *saishiLists;
@property(assign,nonatomic)NSInteger currentPage;

- (IBAction)fuzhiClick:(id)sender;


@end

@implementation FAgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saishiLists = [NSMutableArray arrayWithCapacity:0];
    [[ApiFetch share] spotGetFetch:SPOT_AGENT_TASK_INFO
                             query:@{}
                            holder:self
                         dataModel:AgentInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        NSLog(@"self.agentInfo  = %@",modelValue);
        self.agentInfo = modelValue;
        [self initPageView];
        [self addButton];


    }];
}
-(void)initPageView
{
    self.headView1.backgroundColor = NAVBGCOLOR;
    self.headView2.backgroundColor = NAVBGCOLOR;

    [self.bgProgressView removeAllSubviews];
    [self.bgTowView removeAllSubviews];
    self.bgProgressView.backgroundColor = [UIColor whiteColor];
      self.bgProgressView.layer.shadowOffset =CGSizeMake(1,2);
    self.bgProgressView.layer.borderColor = [UIColor lightGrayColor].CGColor;
      self.bgProgressView.layer.shadowColor =[UIColor lightGrayColor].CGColor;
      self.bgProgressView.layer.shadowOpacity = 1;
      self.bgProgressView.layer.shadowRadius = 2;
      self.bgProgressView.layer.cornerRadius = 5;
    
    MissionProgressView*v=[[MissionProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, self.bgProgressView.frame.size.height)];
    [self.bgProgressView addSubview:v];
    UIView *twoView = [TwoLabel addSomeTwoLabelTopColor:BLACKCOLOR
                                               BottomColor:[UIColor lightGrayColor]
                                                   topFont:[UIFont systemFontOfSize:17]
                                                bottomFont:[UIFont systemFontOfSize:12]
                                           textDataArrDict:@[@{@"top":
                                                               [NSString stringWithFormat:@"%.2f",self.agentInfo.feeCount],@"bottom":@"累计赚取金额"},
                                                             @{@"top":[NSString stringWithFormat:@"%@%%",@(self.agentInfo.applicationPercentage)],@"bottom":@"已打败多少伙伴"},]
                                                     frame:CGRectMake(0, 0, SCREEN_WIDTH-30, 80)
                                            twoLabelHeight:40
                                                     click:^(NSInteger index) {
          
       }];
//       [twoView addShadowCornerRadius:2 cornerRadius:5 shadowOpacity:0.2];
       [self.bgTowView addSubview:twoView];
    twoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [v bindProgressWithProgress:self.agentInfo.applicationPercentage/100.00 total:(int32_t)self.agentInfo.actualGameCount];
//    [v setProgressView:0 arr:@[@"20",@"40",@"60",@"80",@"100",@"120"]];
    UserInfo *userInfo = [AppManager manager].userInfo;
    self.phoneLabel.text = userInfo.phone;
    self.nameLabel.text = userInfo.nickName;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headImg] placeholderImage:[UIImage imageNamed:@"avatar_none"]];
//    [self.isRenZhengLabel setText:@"v已认证"];
        [self.isRenZhengLabel setText:@""];

//    self.yaoqingmaLabel.text = [NSString stringWithFormat:@"邀请码：%@",self.agentInfo.inviteCode];
    self.yaoqingmaLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self fuzhiClick:nil];
    }];
    [self.yaoqingmaLabel addGestureRecognizer:tap];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.estimatedRowHeight  = UITableViewAutomaticDimension;

    [self.mainTableView registerNib:[UINib nibWithNibName:@"FAentTableViewCell" bundle:nil] forCellReuseIdentifier:@"FAentTableViewCell"];
    
    
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.mainTableView.mj_footer = footer;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.currentPage = 1;
    [self getSaiShiLists];

}

-(void)getSaiShiLists
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@(1) forKey:@"status"];
    [dict setValue:@(self.currentPage) forKey:@"pageNo"];
    [[ApiFetch share] eventGetFetch:EVENT_DAILISAISHI query:dict
                             holder:self
                          dataModel:Commissioner.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        NSLog(@"%@",modelValue);
        Commissioner *eventSpotGame = (Commissioner *)modelValue;
        if (self.currentPage == 1) {
            [self.saishiLists removeAllObjects];
        }
        self.currentPage = eventSpotGame.page.pageNo +1;
        [self.saishiLists addObjectsFromArray:eventSpotGame.list];
        [self.mainTableView reloadData];
        [self.mainTableView.mj_footer endRefreshing];
        
        if(self.saishiLists.count == eventSpotGame.page.totalCount)
        {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
//        if(self.saishiLists.count == 0)
//        {
//            self.mainTableView.hidden = YES;
// 
//        }else{
//            self.mainTableView.hidden = NO;
//         }
    }];
}
-(void)loadMoreData
{
    [self getSaiShiLists];
}
-(void)addButton
{
    LPButton *btn1 =[ToolView btnTitle:@"赛事审批" image:@"saishishenpi" tag:0 superView:self.bgFourView sel:@selector(shenPiClick:) targer:self setStyle:LPButtonStyleTop font:13];
    UIButton *btn2 =[ToolView btnTitle:@"钓场数据" image:@"diaochangshuju" tag:0 superView:self.bgFourView sel:@selector(spotNumClick:) targer:self setStyle:LPButtonStyleTop font:13];
    UIButton *btn3 =[ToolView btnTitle:@"代理钓场" image:@"dailidiaochang" tag:0 superView:self.bgFourView sel:@selector(agentSpotClick:) targer:self setStyle:LPButtonStyleTop font:13];
    UIButton *btn4 =[ToolView btnTitle:@"账目管理" image:@"zhangmuguanli" tag:0 superView:self.bgFourView sel:@selector(detailClick:) targer:self setStyle:LPButtonStyleTop font:13];
    
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3,btn4]];
    float length = (SCREEN_WIDTH -30)/4.0;
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:0 tailSpacing:0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.bgFourView.mas_top).offset(10);
        make.height.equalTo(@80);
    }];
 
}
-(IBAction)shenPiClick:(UIButton *)btn
{
    SaiShiShenPiViewController *vc = [[SaiShiShenPiViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)spotNumClick:(UIButton*)btn{

H5ArticalDetailViewController* h5VC = [[H5ArticalDetailViewController alloc] init];
h5VC.url = AgentAnalysis;
    h5VC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:h5VC
                                         animated:YES];

}
-(void)agentSpotClick:(UIButton *)btn
{
    DiaoChangSearchTableViewController*vc = [[DiaoChangSearchTableViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isDaiLiDiaoChang = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)detailClick:(UIButton *)btn
{
    ZhangMuGuanLiViewController*vc = [[ZhangMuGuanLiViewController alloc]init];
    vc.agentInfo = self.agentInfo;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.saishiLists.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FAentTableViewCell" forIndexPath:indexPath];
    CommissionerGame * gameItem = self.saishiLists[indexPath.row];
    IMAGE_LOAD(cell.coverImageView, gameItem.coverImage)
    cell.gameTitleView.text = gameItem.name;
    cell.gameStartTimeView.text = [NSString stringWithFormat:@"开始时间:%@",[ToolClass dateToString3:gameItem.startTime]];
    cell.gameStatusView.text = [gameItem statusInfo];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EnrollGameNewViewController *vc =[[EnrollGameNewViewController alloc]init];
    CommissionerGame * gameItem = self.saishiLists[indexPath.row];

    vc.eventId = gameItem.id;
    vc.isAct = gameItem.type == 1;
   
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)fuzhiClick:(id)sender {
    if (! (self.agentInfo.inviteCode.length>0)) {
        [self showDefaultInfo:@"暂无邀请码"];
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
      pasteboard.string = self.agentInfo.inviteCode;
    [self showDefaultInfo:[NSString stringWithFormat:@"邀请码:%@复制成功",self.agentInfo.inviteCode]];
}

@end
