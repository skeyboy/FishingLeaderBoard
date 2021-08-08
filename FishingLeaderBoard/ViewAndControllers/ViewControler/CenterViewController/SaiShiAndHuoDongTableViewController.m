//
//  SaiShiAndHuoDongTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SaiShiAndHuoDongTableViewController.h"
#import "FSSegmentTitleView.h"
#import "ToolClass.h"
#import "AppDelegate.h"
#import "FaBuSaiShiViewController.h"

@interface SaiShiAndHuoDongTableViewController ()<STSegmentViewDelegate,FSSegmentTitleViewDelegate,ApiFetchOptionalHandler,UIScrollViewDelegate>
{
}
@property (nonatomic,strong) UIScrollView *bottomScrollView;
@property (nonatomic,strong) NSMutableArray *allViewController;
@property (nonatomic,strong) SaiShiListTableViewController*currentShowViewController;
@property (nonatomic,assign) NSInteger currentPage;
@end

@implementation SaiShiAndHuoDongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
}

-(void)initPageView
{
    [self setNavViewWithTitle:@"" isShowBack:YES];
    hkNavigationView.frame =CGRectMake(0, 0, SCREEN_WIDTH, Height_StatusBar+50+20);
    hkNavigationView.navLineView.frame =(CGRect){0, Height_StatusBar+50 - 0.5, SCREEN_WIDTH, 5};
    hkNavigationView.navLineView.backgroundColor = NAVBGCOLOR;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2.0, Height_StatusBar+5, 200, 45) delegate:self indicatorType:2];
                titleView.titlesArr = @[@"赛事",@"活动"];
                [self.view addSubview:titleView];
                titleView.titleSelectColor= WHITECOLOR;
                titleView.titleNormalColor = WHITECOLOR;
                titleView.indicatorColor = WHITECOLOR;
                titleView.backgroundColor = NAVBGCOLOR;
                titleView.delegate = self;
                titleView.titleFont = [UIFont boldSystemFontOfSize:17];
       [self.view addSubview:titleView];
    
//    UIButton *btn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(back) tag:0];
//      [btn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
//      [self.view addSubview:btn];
//      btn.frame = CGRectMake(20, Height_StatusBar+5, 40, 40);
    
    _segmentView1 = [[STSegmentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)+20, self.view.bounds.size.width, 40)];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObject:@"全部"];
    [arr addObjectsFromArray:[ToolClass getWeekArr]];
    _segmentView1.titleArray = arr;
    _segmentView1.delegate = self;
    _segmentView1.topLabelTextColor = BLACKCOLOR;
    _segmentView1.bottomLabelTextColor = BLACKCOLOR;
    _segmentView1.selectedBackgroundColor = [[UIColor alloc]initWithRed:16/255.0 green:74/255.0 blue:184/255.0 alpha:1];
    _segmentView1.selectedBgViewCornerRadius = 20;
    _segmentView1.labelFont = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_segmentView1];
    _segmentView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    
    
    
//    __strong SaiShiListTableViewController *saiShiVC = [[SaiShiListTableViewController alloc]init];
//    saiShiVC.view.frame = CGRectMake(0,CGRectGetMaxY(_segmentView1.frame), SCREEN_WIDTH, SCREEN_HEIGHT -CGRectGetMaxY(_segmentView1.frame)-10);
//    [self addChildViewController:saiShiVC];
//    titleView.delegate = saiShiVC;
//    _segmentView1.delegate = saiShiVC;
//    [self.view addSubview:saiShiVC.view];

    
      CGFloat tableViewW = SCREEN_WIDTH;
      CGFloat tableViewH = SCREEN_HEIGHT -CGRectGetMaxY(_segmentView1.frame)-20;
      
      _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentView1.frame)+10, tableViewW, tableViewH)];
      _bottomScrollView.delegate = self;
      _bottomScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
      _bottomScrollView.contentSize = CGSizeMake(tableViewW * 8, tableViewH);
      _bottomScrollView.pagingEnabled = YES;
      [self.view addSubview:_bottomScrollView];
    _allViewController = [[NSMutableArray alloc]initWithCapacity:0];
      for (int i = 0; i < 8; i++) {
              SaiShiListTableViewController *saiShiVC = [[SaiShiListTableViewController alloc]init];
              saiShiVC.view.frame = CGRectMake(i * tableViewW, 0, tableViewW, tableViewH);
              saiShiVC.GameOrAct = 2;//赛事
              NSArray *dateA = [ToolClass getDateArr];
                     if(i == 0)
                     {
                         saiShiVC.chooseTimeS = nil;
                     }else{
                         saiShiVC.chooseTimeS = [dateA objectAtIndex:i-1];
                     }
                     [saiShiVC changeTab];
          [_bottomScrollView addSubview:saiShiVC.view];
          [self addChildViewController:saiShiVC];

          [_allViewController addObject:saiShiVC];

      }
    self.currentShowViewController = [self.allViewController objectAtIndex:0];
      _segmentView1.outScrollView = _bottomScrollView;

    if( [AppManager manager].userInfo.userType == 2)
    {
        [self addFaBuButton];
    }
    
}
-(void)addFaBuButton
{
     MenuView *menvView = [[MenuView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-Height_TabBar-60*3-20, 60, 60*3) name:@[@"发布",@"活动",@"赛事"] color:@[[[UIColor alloc]initWithRed:26/255.0 green:197/255.0 blue:136/255.0 alpha:1],WHITEGRAY,WHITEGRAY]];
    [self.view addSubview:menvView];
    [self.view bringSubviewToFront:menvView];
    menvView.menuClick = ^(int index) {
        if(![[AppManager manager]userHasLogin])
        {
            [self showDefaultInfo:@"请先登录"];
            return ;
        }

         //判断是否支持发布赛事和活动
        NSString *str = nil;
        if(index==1)
        {
            str = @"ACTIVITY";
        }else{
            str = @"GAME";
        }

        NSMutableDictionary *dictR = [[NSMutableDictionary alloc]init];
//        [dictR setValue:str forKey:@"eventTypeEnum"];
        [dictR setValue:[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id] forKey:@"userId"];
//        [[ApiFetch share]spotGetFetch:SPOT_IS_PUBLISH query:dictR holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [[ApiFetch share]spotGetFetch:SPOTID_BYUSER query:dictR holder:self dataModel:IsPubishAct.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            NSLog(@"发布赛事判断 = %@",modelValue);
            [self hideHud];
            IsPubishAct *isPublish = (IsPubishAct *)modelValue;
            if(index == 1)//活动
            {
                FaBuSaiShiViewController *vc = [[FaBuSaiShiViewController alloc]init];
                vc.isSaiShi = NO;
                if(isPublish.value == 0)
                {
                    vc.isPublish = NO;
                }else{
                    vc.isPublish = YES;
                }
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }else if (index == 2)//赛事
            {
                FaBuSaiShiViewController *vc = [[FaBuSaiShiViewController alloc]init];
                vc.isSaiShi = YES;
                if(isPublish.value == 0)
                {
                    vc.isPublish = NO;
                }else{
                    vc.isPublish = YES;
                }
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];

    };
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint  pt=scrollView.contentOffset;
    if(pt.x<0)
    {
        pt.x=0;
    }
    int page=(int)(pt.x/SCREEN_WIDTH);
    if(page != self.currentPage)
    {
        self.currentPage = page;
        self.currentShowViewController = [self.allViewController objectAtIndex:page];
    }
}
- (void)buttonClick:(NSInteger)index {
    [_bottomScrollView setContentOffset:CGPointMake(self.view.frame.size.width * index, 0) animated:YES];
    NSLog(@"%ld",index);
    NSLog(@"周几 = %ld",index);
    
}
-(void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    NSLog(@"选择 = %ld",endIndex);
    if(endIndex!=startIndex)
    {
        for(int i = 0;i<8;i++)
        {
            SaiShiListTableViewController*vc = [self.allViewController objectAtIndex:i];
            if(endIndex == 0)
            {
                      vc.GameOrAct = 2;//赛事
            }else{
                      vc.GameOrAct = 1; //活动
            }
            [vc changeTab];
        }
     

    }
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
     [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
@end
