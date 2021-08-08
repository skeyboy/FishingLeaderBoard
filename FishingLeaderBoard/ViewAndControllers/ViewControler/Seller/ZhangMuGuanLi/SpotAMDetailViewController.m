//
//  SpotAMDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SpotAMDetailViewController.h"
#import "SpotAMDetailTableViewCell.h"
#import "XinZhengYuPiaoShouRuView.h"
#import "XinZengQiTaShouRuView.h"
#import "XiuGaiYuTangFangYuShuLiangView.h"
@interface SpotAMDetailViewController ()
{
    
    __block NSMutableArray *tableArr;
    __block NSInteger pageCurrent;
}
@end

@implementation SpotAMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(flashData)
                                                   name:@"Notification_sendData"
                                                 object:nil];
    [self initPageView];
    [self initGetList];
}

-(void)flashData
{
    [self initGetList];
}
-(void)initPageView
{
    [self setNavViewWithTitle:@"赛事/活动账目详情" isShowBack:YES];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SpotAMDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"SpotAMDetailTableViewCell"];
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getList)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.mainTableView.mj_footer = footer;
}

-(void)initGetList
{
    pageCurrent = 1;
    if(tableArr)
    {
        [tableArr removeAllObjects];
    }else{
        tableArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:@(self.eventListItem.eventId) forKey:@"eventId"];
    [[ApiFetch share]orderGetFetch:ORDER_account_all_detail query:dict holder:self dataModel:[OrderEventAccountDetail class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        OrderEventAccountDetail *listTotal=(OrderEventAccountDetail*)modelValue;
        IMAGE_LOAD(self.spotImageView, self.eventListItem.coverImage);
        self.titleLabel.text = listTotal.eventName;
        self.timeLabel.text = [NSString stringWithFormat:@"时间：%@~%@",[ToolClass dateToString4: self.eventListItem.startTime],[[[ToolClass dateToString4: self.eventListItem.finishTime]componentsSeparatedByString:@" "]objectAtIndex:1]];
        self.baoMingRenShuLabel.text =[NSString stringWithFormat:@"报名人数：%ld人",listTotal.count];
        self.benchangshouyiLabel.text =[NSString stringWithFormat:@"%.2f",listTotal.thisInComeMoney];
        self.fangyuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.fangYu];
         self.shouyuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.shouYu];
        
         self.cunyuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.cunYu];
        
         self.fangyuzhichuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.fangYuZhiChu];
        
         self.shouyuzhichuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.shouYuZhiChu];
        
         self.qitazhichuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.qiTaZhiChu];
        
         self.yupiaoshouruLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.yuPiaoShouRu];
        
         self.cunYuShouRuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.cunYuShouRu];
        
        self.qitashouruLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.qiTaShouRu];
        
         self.biaoyuzhichuLabel.text = [NSString stringWithFormat:@"%.2f",listTotal.biaoYuZhiChu];
        
            [self getList];
    }];
    
    
}
-(void)getList
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:@(self.eventListItem.eventId) forKey:@"eventId"];
    [dict setValue:@(pageCurrent) forKey:@"pageNo"];
    [dict setValue:@(10) forKey:@"pageSize"];
    [[ApiFetch share]orderGetFetch:ORDER_account_all_list query:dict holder:self dataModel:[OrderEventAllList class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        OrderEventAllList*listO=(OrderEventAllList*)modelValue;

        self->pageCurrent = listO.page.pageNo +1;
        [self->tableArr addObjectsFromArray:listO.list];
        [self.mainTableView reloadData];
        [self.mainTableView.mj_footer endRefreshing];

        if(self->tableArr.count == listO.page.totalCount)
        {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}
- (IBAction)addNewItem:(id)sender {
    @weakify(self)
    UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"设置账目" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    UIAlertAction * item1 = [UIAlertAction actionWithTitle:@"新增鱼票收入" style:0 handler:^(UIAlertAction * _Nonnull action) {
        XinZhengYuPiaoShouRuView*v = [[XinZhengYuPiaoShouRuView alloc]init:2 eventId:self.eventListItem.eventId];
        [self.view addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.width.equalTo(self.view.mas_width);
            make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT));
        }];
        
    }];
    UIAlertAction * item2 = [UIAlertAction actionWithTitle:@"新增收鱼支出" style:0 handler:^(UIAlertAction * _Nonnull action) {
        XinZhengYuPiaoShouRuView*v = [[XinZhengYuPiaoShouRuView alloc]init:1 eventId:self.eventListItem.eventId];
        [self.view addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.width.equalTo(self.view.mas_width);
            make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT));
        }];
    }];
    UIAlertAction * item3 = [UIAlertAction actionWithTitle:@"修改放鱼数量" style:0 handler:^(UIAlertAction * _Nonnull action) {
       
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
        [dict setValue:@(self.eventListItem.eventId) forKey:@"eventId"];
        [[ApiFetch share]orderGetFetch:ORDER_account_fish_price query:dict holder:self dataModel:[OrderFishAndPrice class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            OrderFishAndPrice*fishPrice = (OrderFishAndPrice*)modelValue;
            XiuGaiYuTangFangYuShuLiangView*v = [[XiuGaiYuTangFangYuShuLiangView alloc]initEventId:self.eventListItem.eventId show:fishPrice];
            [self.view addSubview:v];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
                make.width.equalTo(self.view.mas_width);
                make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT));
            }];
        }];
      
    }];
    UIAlertAction * item4 = [UIAlertAction actionWithTitle:@"新增其他收入" style:0 handler:^(UIAlertAction * _Nonnull action) {
        XinZengQiTaShouRuView*v = [[XinZengQiTaShouRuView alloc]init:1 eventId:self.eventListItem.eventId];
        [self.view addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.width.equalTo(self.view.mas_width);
            make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT));
        }];
    }];
    UIAlertAction * item5 = [UIAlertAction actionWithTitle:@"新增其他支出" style:0 handler:^(UIAlertAction * _Nonnull action) {
        XinZengQiTaShouRuView*v = [[XinZengQiTaShouRuView alloc]init:2 eventId:self.eventListItem.eventId];
        [self.view addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.width.equalTo(self.view.mas_width);
            make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT));
        }];
    }];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                    style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [actionSheet addAction:item1];
    [actionSheet addAction:item2];
    [actionSheet addAction:item3];
    [actionSheet addAction:item4];
    [actionSheet addAction:item5];
    
    [self presentViewController:actionSheet
                       animated:YES
                     completion:^{
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotAMDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SpotAMDetailTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindData:[tableArr objectAtIndex:indexPath.row]];
    return cell;
}
- (void)dealloc
{
    //根据通知的名字移除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_sendData" object:nil];
}

@end
