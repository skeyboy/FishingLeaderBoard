//
//  SaiShiShenPiViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/26.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SaiShiShenPiViewController.h"
#import "ShenPiTableViewCell.h"
#import "LPButton.h"
#import "EnrollGameNewViewController.h"
#import "Commissioner.h"
@interface SaiShiShenPiViewController ()<UITableViewDelegate,UITableViewDataSource,ApiFetchOptionalHandler>
{
    NSArray *shenpizhuangtaiArr;
    NSInteger shenpiStare;
    __block NSMutableArray *selectArr;
    NSInteger isTongGuo;
}
@property(strong,nonatomic)NSMutableArray *saishiLists;
@property(assign,nonatomic)NSInteger currentPage;
@end

@implementation SaiShiShenPiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saishiLists = [[NSMutableArray alloc]initWithCapacity:0];
    self.currentPage = 1;
    selectArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self setNavViewWithTitle:@"赛事审批" isShowBack:YES];
    self.view.backgroundColor = WHITECOLOR;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ShenPiTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShenPiTableViewCell"];
    self.mainTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.mainTableView.mj_footer = footer;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    [self initViewPage];
    [self getSaiShiLists];
    //    self.mainTableView.hidden = YES;
    self.wuneirongLabel.hidden = YES;
}
-(void)getSaiShiLists
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@(2) forKey:@"type"];
    [dict setValue:@(shenpiStare) forKey:@"status"];
    [dict setValue:@(self.currentPage) forKey:@"pageNo"];
    [[ApiFetch share] eventGetFetch:EVENT_DAILISAISHI query:dict
                             holder:self
                          dataModel:Commissioner.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        NSLog(@"%@",modelValue);
        Commissioner *eventSpotGame = (Commissioner *)modelValue;
        self.currentPage = eventSpotGame.page.pageNo +1;
        [self.saishiLists addObjectsFromArray:eventSpotGame.list];
        [self.mainTableView reloadData];
        [self.mainTableView.mj_footer endRefreshing];
        
        if(self.saishiLists.count == eventSpotGame.page.totalCount)
        {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
        if(self.saishiLists.count == 0)
        {
            self.mainTableView.hidden = YES;
            self.wuneirongLabel.hidden = NO;
            
        }else{
            self.mainTableView.hidden = NO;
            self.wuneirongLabel.hidden = YES;
        }
    }];
}
-(void)loadMoreData
{
    [self getSaiShiLists];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self.mainTableView.mj_footer endRefreshing];
    [self hideHud];
    
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
-(void)initViewPage
{
    self.tongguoBtn.backgroundColor = NAVBGCOLOR;
    self.tongguoBtn.layer.cornerRadius=5;
    self.butongguoBtn.layer.cornerRadius = 5;
    self.butongguoBtn.backgroundColor = NAVBGCOLOR;
    LPButton *lp2 = [ToolView btnTitle:@"待审批" image:@"selected" tag:0 superView:self.bgDaiShenPiView sel:@selector(shenpizhuangtaiclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    lp2.isSelected = YES;
    shenpiStare = 1;
    lp2.tag = 200;
    LPButton *lp3 = [ToolView btnTitle:@"已审批" image:@"unselect" tag:0 superView:self.bgDaiShenPiView sel:@selector(shenpizhuangtaiclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    lp3.tag = 200+1;
    shenpizhuangtaiArr = @[lp2,lp3];
    [lp2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgDaiShenPiView.mas_left).offset(15);
        make.width.equalTo(@(120));
        make.centerY.equalTo(self.bgDaiShenPiView.mas_centerY);
        make.height.equalTo(@35);
    }];
    [lp3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lp2.mas_right);
        make.width.equalTo(@(120));
        make.centerY.equalTo(self.bgDaiShenPiView.mas_centerY);
        make.height.equalTo(@35);
    }];
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
    ShenPiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShenPiTableViewCell" forIndexPath:indexPath];
    CommissionerGame*eventItem = [self.saishiLists objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:eventItem.coverImage] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    NSLog(@"name = %@",eventItem.name);
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",eventItem.name];
    cell.leixingLabel.text = [NSString stringWithFormat:@"类型：%@",eventItem.type==1?@"活动":@"赛事"];
    cell.saishishijianLabel.text = [NSString stringWithFormat:@"时间:%@",[ToolClass dateToString:eventItem.startTime]];
    NSArray* arr =@[@"排名赛事",@"抽奖赛事",@"普通活动",@"积分活动"];
    if((eventItem.pattern-1)>=0)
    {
        cell.jifensaishiLabel.text = [arr objectAtIndex: eventItem.pattern-1];
        cell.jifensaishiLabel.textColor = [UIColor redColor];
        cell.jifensaishiLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else{
        cell.jifensaishiLabel.text = @"";
        cell.jifensaishiLabel.backgroundColor = WHITECOLOR;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.fuXuanBtn setImage:[UIImage imageNamed:@"nomorl"]
                    forState:UIControlStateNormal];
    cell.fuXuanBtnClick = ^(LPButton*btn){
        if(btn.isSelected == NO)
        {
            [btn setImage:[UIImage imageNamed:@"select"]
                 forState:UIControlStateNormal];
            btn.isSelected = YES;
            [self->selectArr addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
        }else{
            [btn setImage:[UIImage imageNamed:@"nomorl"]
                 forState:UIControlStateNormal];
            btn.isSelected = NO;
            [self->selectArr removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
        }
    };
    if(shenpiStare == 1)
    {
        cell.shenpishijianLabel.hidden = YES;
        cell.yitongguoLabel.hidden = YES;
        cell.fuXuanBtn.hidden = NO;
        self.bgTongGuoView.hidden= NO;
        [self.bgTongGuoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
        [cell.fuXuanBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(40));
        }];
    }else
    {
        cell.shenpishijianLabel.hidden = NO;
        cell.yitongguoLabel.hidden = NO;
        cell.fuXuanBtn.hidden = YES;
        self.bgTongGuoView.hidden = YES;
        [self.bgTongGuoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        if(eventItem.status == 2)
        {
            cell.yitongguoLabel.text = @"已通过";
            cell.yitongguoLabel.backgroundColor = [UIColor greenColor];
            cell.shenpishijianLabel.text = [ToolClass dateToString4:eventItem.approvalTime];
            
        }else{
            cell.shenpishijianLabel.text = @"";
            cell.yitongguoLabel.text = @"未通过";
            cell.yitongguoLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        [cell.fuXuanBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0));
        }];
    }
    return cell;
}
- (IBAction)tongguoClick:(id)sender {
    isTongGuo = 2;
    
    [self tijiaoShenPi];
    
}

- (IBAction)butongguoClick:(id)sender {
    isTongGuo = 3;
    
    [self tijiaoShenPi];
    
}
-(void)tijiaoShenPi
{
    NSString *sIDs =@"";
    if(selectArr.count>0)
    {
        EventSpotGameItem *eItem = [_saishiLists objectAtIndex:[[selectArr objectAtIndex:0]intValue]];
        sIDs = [NSString stringWithFormat:@"%ld",eItem.id];
    }
    for(int i =1;i<selectArr.count;i++ )
    {
        EventSpotGameItem *eItem = [_saishiLists objectAtIndex:[[selectArr objectAtIndex:i]intValue]];
        sIDs = [NSString stringWithFormat:@"%@,%ld",sIDs,eItem.id];
    }
    NSLog(@"sids = %@",sIDs);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:sIDs forKey:@"eventId"];
    [dict setValue:@(isTongGuo) forKey:@"status"];
    [[ApiFetch share] eventGetFetch:EVENT_DAILISHENPI query:dict holder:self dataModel:EventSpotGame.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self addAlert];
    }];
}
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审批成功" message:@"审批结果在\"已审批\"中查看" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.currentPage = 1;
        [self->selectArr removeAllObjects];
        [self.saishiLists removeAllObjects];
        [self getSaiShiLists];
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
-(void)shenpizhuangtaiclick:(LPButton *)btn
{
    int index = btn.tag -200;
    LPButton *lp = [shenpizhuangtaiArr objectAtIndex:( 1-index)];
    if(index == 0)
    {
        shenpiStare = 1;//待审批
        self.currentPage = 1;
        [self->selectArr removeAllObjects];
        [self.saishiLists removeAllObjects];
    }else{
        shenpiStare = 2;//已审批
        self.currentPage = 1;
        [self->selectArr removeAllObjects];
        [self.saishiLists removeAllObjects];
    }
    [self getSaiShiLists];
    if(btn.isSelected == NO)
    {
        [btn setImage:[UIImage imageNamed: @"selected"] forState:UIControlStateNormal];
        btn.isSelected = YES;
        lp.isSelected = NO;
        [lp setImage:[UIImage imageNamed: @"unselect"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn.isSelected = NO;
        lp.isSelected = YES;
        [lp setImage:[UIImage imageNamed: @"selected"] forState:UIControlStateNormal];
    }
    [self.mainTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnrollGameNewViewController *vc =[[EnrollGameNewViewController alloc]init];
    EventSpotGameItem*sItem = [self.saishiLists objectAtIndex:indexPath.row];
    vc.eventId = sItem.id;
    vc.isAct =  1 == sItem.type;
    if(shenpiStare==1)
    {
        vc.isShenPi = 1;
    }else{
        vc.isShenPi = 2;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
