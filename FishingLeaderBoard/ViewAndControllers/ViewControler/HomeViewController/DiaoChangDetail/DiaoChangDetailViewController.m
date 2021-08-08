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
#import "AppDelegate.h"
#import "EnrollGameNewViewController.h"
//#import "DCDetailAndFishGetViewController.h"
#import "YuPosterShareViewController.h"
#import "MySelButton.h"
#import "BuHuoTableViewCell.h"
@interface DiaoChangDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FSSegmentTitleViewDelegate,ApiFetchOptionalHandler>
{
    UIButton *sendFishGetBtn;//发送渔获按钮
   __block MySelButton*btnStore;
}
@property(nonatomic,strong)SpotInfo *spotInfo;
@property(copy, nonatomic) __block NSMutableArray * eventGames;
@property(copy, nonatomic) __block NSMutableArray * fishCatches;
@property(assign, nonatomic) __block NSInteger  currentGamePage;
@property(assign, nonatomic) __block NSInteger currentFishCatchPage;
@end

@implementation DiaoChangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _eventGames = [NSMutableArray arrayWithCapacity:0];
    _fishCatches = [NSMutableArray arrayWithCapacity:0];
    self.currentGamePage = 1;
    self.currentFishCatchPage = 1;
    [self setNavViewWithTitle:@"钓场详情" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    btnStore = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(SCREEN_WIDTH-50, Height_StatusBar+10, 30, 30) name:@"" delegate:self selector:@selector(storeClick:) tag:0];
    [hkNavigationView addSubview:btnStore];
    [btnStore setImage:[UIImage imageNamed: @"starNo"] forState:UIControlStateNormal];
    if ([YuWeChatShareManager isWXAppInstalled]) {
        UIButton *share = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(SCREEN_WIDTH-50-50, Height_StatusBar+10, 30, 30) name:@"" delegate:self selector:@selector(shareClick:) tag:0];
        [share setImage:[UIImage imageNamed: @"share_nav"] forState:UIControlStateNormal];
        [hkNavigationView addSubview:share];
    }
    [self initPageView];
    [self initPageData:YES];
    
   
}

#pragma mark -数据请求
-(void)loadMoreData
{
    if(self.cellType == FPageDCDAct)
    {
        [self getGameAndActLists];
    }else{
        [self fishCatch];
    }
}
-(void)initPageData:(BOOL)isGetGameList
{
    [[ApiFetch share ] spotGetFetch:SPOT_DETAIL_BY_ID
                                    query:@{
                                        @"spotId":@(self.spotId==0?1:self.spotId),
                                        @"pageNo":@(self.currentGamePage)
                                            
                                    }
                                   holder:self
                                dataModel:SpotInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
           SpotInfo *spotInfo = (SpotInfo*)modelValue;
           self.spotInfo = spotInfo;
           [self.headView bindDataToView:spotInfo];
        if(spotInfo.collectHave)
        {
            self->btnStore.isChoosed = YES;
            [self->btnStore setImage:[UIImage imageNamed:@"starYes"] forState:UIControlStateNormal];
        }else{
            self->btnStore.isChoosed = NO;
            [self->btnStore setImage:[UIImage imageNamed:@"starNo"] forState:UIControlStateNormal];
        }
        if(isGetGameList)
        {
           [self getGameAndActLists];
           [self fishCatch];
        }
       }];
}

//鱼获请求
-(void)fishCatch{
   
    [[ApiFetch share] infoGetFetch:INFO_FISH_CATCH
                             query:@{
                                 @"spotId":@(self.spotInfo.id),
                                 @"pageNo":@(self.currentFishCatchPage)
                             } holder:self
                         dataModel:InfoFishCatch.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"%@",modelValue);
        [self reloadFishCatch:modelValue];
        
        [self.tableView.mj_footer endRefreshing];
        
        InfoFishCatch *info  = (InfoFishCatch*)modelValue;
        
        if(self.fishCatches.count == info.page.totalCount)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}
//活动赛事
-(void)getGameAndActLists
{
    [[ApiFetch share] eventGetFetch:EVENT_SEARCHEVENT_BYSPOTID query:@{@"spotId":@(self.spotId==0?1:self.spotId),@"pageNo":@(self.currentGamePage)} holder:self dataModel:EventSpotGame.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                  NSLog(@"%@",modelValue);
        
        [self reloadEvnets:modelValue];
          [self.tableView.mj_footer endRefreshing];
             
             EventSpotGame *info  = (EventSpotGame*)modelValue;
             
             if(self.eventGames.count == info.page.totalCount)
             {
                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
             }
    }];
}

-(void)reloadFishCatch:(InfoFishCatch *) fishCatches{
    self.currentFishCatchPage = fishCatches.page.pageNo +1;
    [self.fishCatches appendObjects:fishCatches.list];
    [self.tableView reloadData];
}
-(void)reloadEvnets:(EventSpotGame *) eventSpotGame{
    self.currentGamePage = eventSpotGame.page.pageNo +1;
    [self.eventGames addObjectsFromArray:eventSpotGame.list];
    [self.tableView reloadData];
}


-(void)showNavSheet{
    [ToolClass openAppNav:self.spotInfo.lat
                      lng:self.spotInfo.lng
             withSpotName:self.spotInfo.name
                   hodler:self
                   result:^(BOOL success) {
        
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
     [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
#pragma mark -点击事件
-(void)storeClick:(MySelButton *)btn
{
    if(![[AppManager manager]userHasLogin])
       {
           [self showDefaultInfo:@"请先登录"];
           return;
       }
    @weakify(self)
    if(btn.isChoosed == YES)
    {
        [[ApiFetch share] spotGetFetch:SPOT_STORE_CANCEL query:@{@"userId":[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id],@"spotId":[NSString stringWithFormat:@"%ld", self.spotId]} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                    [weak_self hideHud];
                    [weak_self makeToask:@"取消收藏"];
              [self->btnStore setImage:[UIImage imageNamed:@"starNo"] forState:UIControlStateNormal];
              self->btnStore.isChoosed = NO;
            [self initPageData:NO];
          }];
        return;
    }
    [[ApiFetch share] spotGetFetch:SPOT_STORE query:@{@"userId":[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id],@"spotId":[NSString stringWithFormat:@"%ld", self.spotId]} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
              [weak_self hideHud];
              [weak_self makeToask:@"收藏成功"];
        [self->btnStore setImage:[UIImage imageNamed:@"starYes"] forState:UIControlStateNormal];
        self->btnStore.isChoosed = YES;
        [self initPageData:NO];
    }];
}

/// t海报分享
/// @param btn btn description
-(void)shareClick:(UIButton *)btn
{
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    YuPosterShareViewController *posterShareVC = [[YuPosterShareViewController alloc] init];
    posterShareVC.spotInfo = self.spotInfo;
    [self presentViewController:posterShareVC
                       animated:YES
                     completion:^{
        
    }];
}
#pragma mark -FSSegmentTitleViewDelegate
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    NSLog(@"click =%ld",(long)endIndex);
    if(endIndex == 0)
    {
        //活动赛事列表
        self.cellType = FPageDCDAct;
        sendFishGetBtn.hidden = YES;
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - Height_BottomLine);
       
        
    }else if (endIndex == 1)
    {
        self.cellType = FPageDCDJianJie;
        sendFishGetBtn.hidden = YES;
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - Height_BottomLine);
        
        
    }else{
        self.cellType = FPageDCDFishGet;
        sendFishGetBtn.hidden = NO;
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - Height_BottomLine-60);
        
    }
    if(startIndex!=endIndex)
    {
        MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
        self.tableView.mj_footer = footer;
        [self.tableView reloadData];
    }
}
#pragma mark - 页面初始化
-(void)initPageView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - Height_BottomLine) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headView = [[[NSBundle mainBundle]loadNibNamed:@"DiaoChangDetailHeadView" owner:self options:nil]firstObject];
    [_headView addAllViewDelegate:self];
    self.tableView.tableHeaderView =_headView;

    [self.tableView.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@(497-146+HomeNewsBannerHeight));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];

    [self.headView.bgLunBoTuImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.headView.mas_top).offset(10);
           make.left.equalTo(self.headView.mas_left).offset(10);
           make.height.equalTo(@(HomeNewsBannerHeight));
           make.right.equalTo(self.headView.mas_right).offset(-10);
       }];
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaoChangDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaoChangDetailTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DCDBriefTableViewCell" bundle:nil] forCellReuseIdentifier:@"DCDBriefTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuHuoTableViewCell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //渔获选项发渔获
    sendFishGetBtn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, SCREEN_HEIGHT - 50-Height_BottomLine, SCREEN_WIDTH - 20 *2, 40) name:@"发渔获" delegate:self selector:@selector(sendFishGet:) tag:0];
    sendFishGetBtn.backgroundColor = [UIColor orangeColor];
    sendFishGetBtn.layer.cornerRadius = 5.0;
    sendFishGetBtn.hidden = YES;
    [self.view addSubview:sendFishGetBtn];
    
}
-(void)sendFishGet:(UIButton*)btn
{
    if(![[AppManager manager]userHasLogin])
      {
          [self showDefaultInfo:@"请先登录"];
          return;
      }
    ReleaseFishGetViewController*vc = [[ReleaseFishGetViewController alloc]init];
     vc.spotId = self.spotInfo.id;
    vc.faBuSuccessBlock = ^{
        self.currentFishCatchPage = 1;
        [self.fishCatches removeAllObjects];
        [self fishCatch];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.cellType) {
        case FPageDCDAct:{
            return self.eventGames.count;
        }
        break;
        case FPageDCDJianJie:{
            return 1;
        }
            break;
        case FPageDCDFishGet:{
            return self.fishCatches.count/2+self.fishCatches.count%2;
        }
            break;
        default: return 1;
            break;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.cellType) {
        case FPageDCDAct:{
            return 115;
        }
        break;
        case FPageDCDJianJie:{
            return 115+60*4+50+40*self.spotInfo.spotFishponds.count;
        }
            break;
        case FPageDCDFishGet:{
            return 280;
        }
            break;
        default: return 110;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(self.cellType ==FPageDCDJianJie)
    {
    DCDBriefTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DCDBriefTableViewCell" forIndexPath:indexPath];
        
        cell.btnClick = ^(UIButton * btn) {
            if(![[AppManager manager]userHasLogin])
              {
                  [self showDefaultInfo:@"请先登录"];
                  return;
              }
            ReleaseFishGetViewController*vc = [[ReleaseFishGetViewController alloc]init];
            vc.spotId = self.spotInfo.id;
            vc.faBuSuccessBlock = ^{
                self.currentFishCatchPage = 1;
                [self.fishCatches removeAllObjects];
                [self fishCatch];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
        [cell bindData:self.spotInfo];
        return cell;
    }else if (self.cellType == FPageDCDAct)
    {
        DiaoChangDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DiaoChangDetailTableViewCell" forIndexPath:indexPath];
        if (self.eventGames.count) {
            
            [cell bindValue:self.eventGames[indexPath.row]];
        }
        return cell;
    }else {
        
        BuHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuHuoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.fishCatches.count)
        {
            if(((indexPath.row+1)*2) > self.fishCatches.count)
                   {
                     [cell bindValue:self.fishCatches[indexPath.row*2] Value2:nil];
                   }else{
                     [cell bindValue:self.fishCatches[indexPath.row*2] Value2:self.fishCatches[indexPath.row*2+1]];
                   }
        }
        return cell;
    }

   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.cellType ==FPageDCDAct)
    {
//        DCDetailAndFishGetViewController *vc = [[DCDetailAndFishGetViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        EnrollGameNewViewController *vc = [[EnrollGameNewViewController alloc]init];
        EventSpotGameItem *item = self.eventGames[indexPath.row];
        vc.eventId = item.id;
        vc.isAct = (item.type == 1);
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
