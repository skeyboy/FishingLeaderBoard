//
//  ZhangMuGuanLiViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/26.
//  Copyright © 2020 yue. All rights reserved.
//

#import "ZhangMuGuanLiViewController.h"
#import "ZhangMuGuanLiTableViewCell.h"
#import "CXDatePickerView.h"
#import "AgentBill.h"
@interface ZhangMuGuanLiViewController ()<UISearchBarDelegate>
{
    __block NSString *_dateString;//选择的账目查询时间
    __block BOOL _isMore;
}
@property (weak, nonatomic) IBOutlet UIButton *queryYearView;
@property (weak, nonatomic) IBOutlet UIButton *queryMonthView;
@property(nonatomic) NSMutableArray * bills;
@property(nonatomic) Page * page;
@end

@implementation ZhangMuGuanLiViewController
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self fetchBillByTasktime:_dateString];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchBar.delegate = self;
    self.saishishouru.text = [NSString stringWithFormat:@"赛事收入：%.2f元",self.agentInfo.feeCount];
    self.baomingrenshuLabel.text = [NSString stringWithFormat:@"报名人数：%ld人",self.agentInfo.applicationCount];
    self.saishibaomingLabel.text = [NSString stringWithFormat:@"赛事报名：%ld次",self.agentInfo.actualGameCount];
    
    self.bills = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:@"账目管理" isShowBack:YES];
    [self.mainTablView registerNib:[UINib nibWithNibName:@"ZhangMuGuanLiTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZhangMuGuanLiTableViewCell"];
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
   _dateString = [NSString stringWithFormat:@"%@-%02x",@(year),month];
    [self.queryYearView setTitle:@(year).description forState:UIControlStateNormal];
    [self.queryMonthView setTitle:[NSString stringWithFormat:@"%02x",month] forState:UIControlStateNormal];
    [self fetchBillByTasktime:_dateString];
    self.mainTablView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.page = nil;
        _isMore = NO;
        [self fetchBillByTasktime:_dateString];
    }];
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getPageData)];
         [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
         [footer setTitle:@"" forState:MJRefreshStateIdle];
         [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    
    self.mainTablView.mj_footer = footer;
}
-(void)getPageData{
    _isMore = YES;
    [self fetchBillByTasktime:_dateString];
}

-(void)fetchBillByTasktime:(NSString *) taskTime{
    [self.searchBar endEditing:YES];
    
    NSMutableDictionary * reqParams = [NSMutableDictionary dictionary];
    if (self.searchBar.text) {
        [reqParams setValue:self.searchBar.text forKey:@"keyWord"];

    }
    [reqParams setValue:_dateString forKey:@"taskTime"];
    if (_isMore) {
        [reqParams setValue:@(self.page.pageNo +1) forKey:@"pageNo"];
    }
    //没有获取到page数据则说明一切重置
    if (!self.page) {
        _isMore = NO;
    }
    @weakify(self)
    if (self.page) {
        if (self.page.totalPage == self.page.pageNo){
            [self makeToask:@"没有更多账单数据"];
            return;
        }
    }
    [[ApiFetch share] orderGetFetch:ORDER_AGENT_MANAGER_INFO
                                query:reqParams
                               holder:self
                            dataModel:AgentBillManage.class
                            onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        AgentBillManage * manage = modelValue;
        self.page = manage.page;
        if (!_isMore    ) {
            [weak_self.bills removeAllObjects];
        }
        [weak_self.bills addObjectsFromArray:manage.list];

             [weak_self.mainTablView.mj_footer endRefreshing];
             [weak_self.mainTablView.mj_header endRefreshing];
         [weak_self.mainTablView reloadData];
        if (self.page.pageNo == self.page.totalPage) {
            [weak_self.mainTablView.mj_footer endRefreshingWithNoMoreData];
        }
       }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bills.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhangMuGuanLiTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ZhangMuGuanLiTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell bindBill:self.bills[indexPath.row]];
    return cell;
}
- (IBAction)yearClick:(UIButton*)btn {
    //年月
    NSDate * scrollToDate;
    NSString *titleYear  =[self.yearBtn titleForState:UIControlStateNormal];
    NSString *titleMonth = [self.monthBtn titleForState:UIControlStateNormal];
    NSString *dateTitle = [NSString stringWithFormat:@"%@-%@-01",titleYear,titleMonth];
    scrollToDate =  [ToolClass dateFromString:dateTitle];
    NSLog(@"%@",scrollToDate);
    @weakify(self)
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonth scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM"];
        NSLog(@"选择的日期：%@",dateString);
        NSArray *sA = [dateString componentsSeparatedByString:@"-"];
        [self.yearBtn setTitle:[sA objectAtIndex:0] forState:UIControlStateNormal];
        [self.monthBtn setTitle:[sA objectAtIndex:1] forState:UIControlStateNormal];
        self->_dateString = dateString;
        weak_self.page = nil;
        [weak_self fetchBillByTasktime:_dateString];
    }];
    datepicker.dateLabelColor = [UIColor blackColor];//时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
    datepicker.cancelButtonColor = datepicker.doneButtonColor;
    datepicker.headerViewColor = [UIColor groupTableViewBackgroundColor];
    datepicker.hideSegmentedLine=YES;
    datepicker.hideBackgroundYearLabel=YES;
    [datepicker show];
}
- (IBAction)monthClick:(id)sender {
    //年月
    NSDate * scrollToDate;
    NSString *titleYear  =[self.yearBtn titleForState:UIControlStateNormal];
    NSString *titleMonth = [self.monthBtn titleForState:UIControlStateNormal];
    NSString *dateTitle = [NSString stringWithFormat:@"%@-%@-01",titleYear,titleMonth];
    scrollToDate =  [ToolClass dateFromString:dateTitle];
    NSLog(@"%@",scrollToDate);
    @weakify(self)
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonth scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM"];
        NSLog(@"选择的日期：%@",dateString);
        NSArray *sA = [dateString componentsSeparatedByString:@"-"];
        [self.yearBtn setTitle:[sA objectAtIndex:0] forState:UIControlStateNormal];
        [self.monthBtn setTitle:[sA objectAtIndex:1] forState:UIControlStateNormal];
        weak_self.page = nil;
        self->_dateString = dateString;
              [weak_self fetchBillByTasktime:_dateString];
    }];
    datepicker.dateLabelColor = [UIColor blackColor];//时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
    datepicker.cancelButtonColor = datepicker.doneButtonColor;
    datepicker.headerViewColor = [UIColor groupTableViewBackgroundColor];
    datepicker.hideSegmentedLine=YES;
    datepicker.hideBackgroundYearLabel=YES;
    [datepicker show];
}

@end
