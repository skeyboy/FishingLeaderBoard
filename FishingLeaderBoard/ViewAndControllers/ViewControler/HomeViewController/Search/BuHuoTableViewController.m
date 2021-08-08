//
//  BuHuoTableViewController.m
//  FishingLeaderBoard
//  捕获和钓场两个VC
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BuHuoTableViewController.h"
#import "IQKeyboardManager.h"
#import "ReleaseFishGetViewController.h"
@interface BuHuoTableViewController ()<UITableViewDelegate,UITableViewDataSource,ApiFetchOptionalHandler>
@property(assign,nonatomic)NSInteger currentPage;
@property(strong,nonatomic)NSMutableArray *fishesList;

@property(strong,nonatomic)NSMutableArray *fishGetList;
@property(assign,nonatomic)NSInteger currentFishGetPage;
@property(strong,nonatomic)NSString *searchStr;

@end

@implementation BuHuoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    if(self.pageType == FPageTypeBuHuoView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar-20 -44) style:UITableViewStylePlain];
        [self initPageView];
        MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
              [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
              [footer setTitle:@"" forState:MJRefreshStateIdle];
              [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
              self.tableView.mj_footer = footer;
              self.tableView.showsVerticalScrollIndicator = NO;
        [self initPageData];

    }else if(self.pageType == FPageTypeDiaoChangView)
    {
        self.currentPage = 1;
        self.fishesList = [[NSMutableArray alloc]initWithCapacity:0];
        [self setNavViewWithTitle:@"钓鱼广场" isShowBack:YES];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame)) style:UITableViewStylePlain];
        [self initPageView];
        MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getDataForDiscoverMore)];
        [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
        self.tableView.mj_footer = footer;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self getDataForDiscoverMore];
        
    }
    
}
//发现页面钓鱼广场
-(void)getDataForDiscoverMore
{
    [[ApiFetch share] infoGetFetch:INFO_FISH_CATCH
                             query:@{
                                 @"pageNo":@(self.currentPage),
                             } holder:self
                         dataModel:InfoFishCatch.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"%@",modelValue);
        [self.tableView.mj_header endRefreshing];
        
        InfoFishCatch *info  = (InfoFishCatch*)modelValue;
        [self.fishesList addObjectsFromArray:info.list];
        [self.tableView reloadData];
        self.currentPage = self.currentPage+1;
        [self.tableView.mj_footer endRefreshing];
        if(self.fishesList.count == info.page.totalCount)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}
-(void)initPageView
{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuHuoTableViewCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorColor = CLEARCOLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
}
-(void)btnRightClick:(UIButton *)btn
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.pageType == FPageTypeBuHuoView)
    {
        return self.fishGetList.count/2+self.fishGetList.count%2;
    }else{
        return self.fishesList.count/2+self.fishesList.count%2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuHuoTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.pageType == FPageTypeBuHuoView)
    {
        if(self.fishGetList.count)
        {
            if(((indexPath.row+1)*2) > self.fishGetList.count)
            {
                [cell bindValue:self.fishGetList[indexPath.row*2] Value2:nil];
            }else{
                [cell bindValue:self.fishGetList[indexPath.row*2] Value2:self.fishGetList[indexPath.row*2+1]];
            }
        }
    }else{
        if(self.fishesList.count)
          {
              if(((indexPath.row+1)*2) > self.fishesList.count)
              {
                  [cell bindValue:self.fishesList[indexPath.row*2] Value2:nil];
              }else{
                  [cell bindValue:self.fishesList[indexPath.row*2] Value2:self.fishesList[indexPath.row*2+1]];
              }
          }
    }
    return cell;
}


-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
     [self.tableView.mj_footer endRefreshing];
     [self hideHud];

}
-(BOOL)autoHudForLink:(NSString *) link
{
    return NO;
}


#pragma mark -搜索渔获
-(void)initPageData
{
    self.currentFishGetPage = 1;
    self.fishGetList = [[NSMutableArray alloc]init];
    [self getFishGet];
}
-(void)loadMoreData
{
    [self getFishGet];
}
-(void)getFishGet
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@(4) forKey:@"searchType"];
    [params setValue:self.searchStr forKey:@"key"];
    [params setValue:@(self.currentFishGetPage) forKey:@"pageNo"];
    @weakify(self)
    NSLog(@"params = %@",params);
    [[ApiFetch share] infoGetFetch:INFO_SEARCH
                                   query:params
                                  holder:self
                               dataModel:InfoFishCatch.class
                               onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
             //       TODO 此处补全数据
             InfoFishCatch *infoFishCatch = (InfoFishCatch*) modelValue;
             [weak_self.fishGetList addObjectsFromArray:infoFishCatch.list];
             weak_self.currentFishGetPage = infoFishCatch.page.pageNo+1;
             [weak_self.tableView reloadData];
             [weak_self.tableView.mj_footer endRefreshing];
             if(weak_self.fishGetList.count == infoFishCatch.page.totalCount)
             {
                 [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
             }
         }];
}
-(void)searchButtonClick:(NSString *)searchStr
{
    self.searchStr = searchStr;
    [self initPageData];
}
@end
