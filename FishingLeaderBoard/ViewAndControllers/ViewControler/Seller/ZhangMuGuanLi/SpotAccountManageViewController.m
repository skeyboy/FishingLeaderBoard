//
//  SpotAccountManageViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/17.
//  Copyright © 2020 yue. All rights reserved.
//
#define MAXYEAR 2099
#define MINYEAR 1000
#import "SpotAccountManageViewController.h"
#import "SpotAccountManageView.h"
#import "LPButton.h"
#import "SpotAccountManageTableViewCell.h"
#import "SpotAMDetailViewController.h"
#import "YCMenuView.h"
//#import "YCMenuAction.h"
@interface SpotAccountManageViewController ()
{
    __block LPButton *btn_year;
    __block LPButton *btn_month;
    __block LPButton *btn_day;
    __block NSString *yearStr;
    __block NSString *monthStr;
    __block NSString *dayStr;
    __block NSInteger stateNoStart;//1:未开始 2、已结束
    SpotAccountManageView * headView;
    
    __block NSMutableArray *tableArr;
   __block NSInteger pageCurrent;
}
@end

@implementation SpotAccountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(flashData)
                                                   name:@"Notification_sendData"
                                                 object:nil];
    
    [self initViewPage];
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated
{
    if(self.isFlash == YES)
    {
        self.isFlash = NO;
        [self getData];
    }
}
-(void)flashData
{
    self.isFlash = YES;
}

-(void)getData
{
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
        [dict setValue:@(stateNoStart) forKey:@"type"];
        [dict setValue:[self getListDateStr] forKey:@"time"];
        [[ApiFetch share]orderGetFetch:ORDER_account_elist_total query:dict holder:self dataModel:[OrderEventListTotal class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
             OrderEventListTotal *listTotal=(OrderEventListTotal*)modelValue;
             self->headView.zhongShouRuLabel.text = [NSString stringWithFormat:@"%.2f", listTotal.allShouRu];
             self->headView.zongZhiChuLabel.text = [NSString stringWithFormat:@"%.2f", listTotal.allZhiChu];
            [self initGetList];
        }];
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
    [self getList];
    
}
-(void)getList
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:@(stateNoStart) forKey:@"type"];
    [dict setValue:[self getListDateStr] forKey:@"time"];
    [dict setValue:@(pageCurrent) forKey:@"pageNo"];
    [dict setValue:@(10) forKey:@"pageSize"];
          [[ApiFetch share]orderGetFetch:ORDER_account_elist query:dict holder:self dataModel:[OrderEventList class] onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
              OrderEventList*listO=(OrderEventList*)modelValue;
              
               self->pageCurrent = listO.page.pageNo +1;
              [self->tableArr addObjectsFromArray:listO.list];
               [self.mainTableView reloadData];
               [self.mainTableView.mj_footer endRefreshing];
               
               if(tableArr.count == listO.page.totalCount)
               {
                   [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
               }
          }];
}
-(NSString*)getListDateStr
{
    if(monthStr==nil)
    {
        return yearStr;
    }else{
        if(dayStr==nil)
        {
            NSString *s = [NSString stringWithFormat:@"%@-%@",yearStr,monthStr];
            return s;
        }else{
            NSString *s = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
                       return s;
        }
        
    }
}
-(void)initViewPage
{
    
    [self setNavViewWithTitle:@"账目管理" isShowBack:YES];
    
    headView =  [[[NSBundle mainBundle]loadNibNamed:@"SpotAccountManageView" owner:self options:nil]firstObject];
    self.mainTableView.tableHeaderView =headView;
    [self.mainTableView.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainTableView.mas_top);
        make.height.greaterThanOrEqualTo(@250);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    btn_year =[ToolView btnTitle:@"--年" image:@"sortDown" tag:0 superView:headView.yearbgView sel:@selector(chooseYearMD:) targer:self setStyle:LPButtonStyleRight font:17];
    btn_year.backgroundColor = WHITECOLOR;
    btn_year.layer.cornerRadius = 15;
    btn_year.clipsToBounds = YES;
    btn_month =[ToolView btnTitle:@"--月" image:@"sortDown" tag:0 superView:headView.yearbgView sel:@selector(chooseMonthMD:) targer:self setStyle:LPButtonStyleRight font:17];
    btn_month.backgroundColor = WHITECOLOR;
    btn_month.layer.cornerRadius = 15;
    btn_month.clipsToBounds = YES;
    btn_day =[ToolView btnTitle:@"--日" image:@"sortDown" tag:0 superView:headView.yearbgView sel:@selector(chooseDayMD:) targer:self setStyle:LPButtonStyleRight font:17];
    btn_day.backgroundColor = WHITECOLOR;
    btn_day.layer.cornerRadius = 15;
    btn_day.clipsToBounds = YES;
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn_year,btn_month,btn_day]];
    float length = (SCREEN_WIDTH -60)/3.0;
    if(length<100)
    {
        length =100;
    }
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:20 tailSpacing:20];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(headView.yearbgView.mas_top).offset(10);
        make.height.equalTo(@(30
                            ));
    }];
    NSString *todayS= [ToolClass getCurrentTime];
    NSArray *sA = [todayS componentsSeparatedByString:@"-"];
    [self->btn_year setTitle:[NSString stringWithFormat:@"%@年",[sA objectAtIndex:0]] forState:UIControlStateNormal];
    self->yearStr =[sA objectAtIndex:0];
    [self->btn_month setTitle:[NSString stringWithFormat:@"%@月",[sA objectAtIndex:1]] forState:UIControlStateNormal];
    self->monthStr = [sA objectAtIndex:1];
    [self->btn_day setTitle:@"全部" forState:UIControlStateNormal];
    self->dayStr = nil;
    [headView.weiKaiShiBtn addTarget:self action:@selector(changesStateWei:) forControlEvents:UIControlEventTouchUpInside];
    [headView.yiJieShuBtn addTarget:self action:@selector(changesStateYi:) forControlEvents:UIControlEventTouchUpInside];
    stateNoStart = 1;
    headView.weiKaiShiBtn.backgroundColor = CLEARCOLOR;
    [headView.weiKaiShiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    headView.yiJieShuBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    [headView.yiJieShuBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SpotAccountManageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SpotAccountManageTableViewCell"];
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getList)];
         [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
         [footer setTitle:@"" forState:MJRefreshStateIdle];
         [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.mainTableView.mj_footer = footer;
}
-(void)changesStateYi:(UIButton *)btn
{
    stateNoStart = 2;

    headView.yiJieShuBtn.backgroundColor = CLEARCOLOR;
      headView.weiKaiShiBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    [self getData];
}
-(void)changesStateWei:(UIButton *)btn
{
    stateNoStart = 1;
    
    headView.weiKaiShiBtn.backgroundColor = CLEARCOLOR;
    headView.yiJieShuBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    [self getData];
    
  
}
-(void)chooseMonthMD:(UIButton*)btn
{

     NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];

     for (NSInteger i = 0; i<=12; i++) {
         NSString *num = [NSString stringWithFormat:@"%02d月",(long)i];
         if(i==0)
         {
             num = @"全部";
         }
         YCMenuAction *action = [YCMenuAction actionWithTitle:num image:nil handler:^(YCMenuAction *action) {
             NSLog(@"点击了%@",action.title);
             NSString*yuanStr=self->monthStr;
             if([action.title isEqualToString:@"全部"])
             {
                 self->monthStr = nil;
             }else{
                 self->monthStr = [action.title substringToIndex:action.title.length-1];
             }
             [self->btn_month setTitle:action.title forState:UIControlStateNormal];
             [self->btn_day setTitle:@"全部" forState:UIControlStateNormal];
             self->dayStr = nil;
             
             if(![yuanStr isEqualToString:self->monthStr])
             {
                 [self getData];
             }
         }];
         [arr addObject:action];
     }
     YCMenuView *view = [YCMenuView menuWithActions:arr width:120 atPoint:CGPointMake(SCREEN_WIDTH/2.0, Height_NavBar+60)];
     [view show];
}
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month {
    NSInteger num_year  = year;
    NSInteger num_month = month;
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            return 30;
        }
        case 2:{
            if (isrunNian) {
                return 29;
            }else{
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}
-(void)chooseDayMD:(UIButton*)btn
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    if(monthStr==nil)
    {
        YCMenuAction *action = [YCMenuAction actionWithTitle:@"全部" image:nil handler:^(YCMenuAction *action) {
            NSLog(@"点击了%@",action.title);
            dayStr = nil;
            [self->btn_day setTitle:@"全部" forState:UIControlStateNormal];
        }];
        [arr addObject:action];

    }else{
        NSInteger dayTotal = [self DaysfromYear:[yearStr intValue] andMonth:[monthStr intValue]];
        for(int i=0;i<=dayTotal;i++)
        {
            NSString *num = [NSString stringWithFormat:@"%02d号",(long)i];

            if(i==0)
            {
                num = @"全部";
            }
            YCMenuAction *action = [YCMenuAction actionWithTitle:num image:nil handler:^(YCMenuAction *action) {
                NSLog(@"点击了%@",action.title);
                NSString* yuanStr = self->dayStr;
                if([action.title isEqualToString:@"全部"])
                {
                    self->dayStr = nil;
                }else{
                    self->dayStr = [action.title substringToIndex:action.title.length-1];
                }
                [self->btn_day setTitle:action.title forState:UIControlStateNormal];
                if(![yuanStr isEqualToString:self->dayStr])
                {
                    [self getData];
                }
            }];
            [arr addObject:action];
        }
        
        
        
    }
    float length = (SCREEN_WIDTH -60)/3.0;
      if(length<100)
      {
          length =100;
      }
    
    YCMenuView *view = [YCMenuView menuWithActions:arr width:120 atPoint:CGPointMake((SCREEN_WIDTH - 20 - (length)/2.0), Height_NavBar+60)];
    [view show];
}
-(void)chooseYearMD:(UIButton*)btn
{
    NSString *currentYear = [ToolClass getCurrentTime];
    int l = [[[currentYear componentsSeparatedByString:@"-"]objectAtIndex:0]intValue];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i = l; i>= MINYEAR; i--) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        YCMenuAction *action = [YCMenuAction actionWithTitle:num image:nil handler:^(YCMenuAction *action) {
            NSLog(@"点击了%@",action.title);
            NSString *yuanStr = self->yearStr;
            self->yearStr = action.title;
            [self->btn_year setTitle:[NSString stringWithFormat:@"%@年",action.title] forState:UIControlStateNormal];
            if(![yuanStr isEqualToString:self->yearStr])
            {
                [self getData];
            }
        }];
        [arr addObject:action];
    }
    float length = (SCREEN_WIDTH -60)/3.0;
      if(length<100)
      {
          length =100;
      }
    YCMenuView *view = [YCMenuView menuWithActions:arr width:120 atPoint:CGPointMake(20+length/2.0, Height_NavBar+60)];
    [view show];
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
    SpotAccountManageTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SpotAccountManageTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindData:[tableArr objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotAMDetailViewController*vc  = [[SpotAMDetailViewController alloc]init];
    vc.eventListItem = [tableArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc
{
    //根据通知的名字移除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_sendData" object:nil];
}
@end
