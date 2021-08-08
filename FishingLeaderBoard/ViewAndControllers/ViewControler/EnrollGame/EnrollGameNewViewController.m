//
//  SaiShiBaoMingNewViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "EnrollGameNewViewController.h"
#import "YuShareGameViewController.h"
#import "MyOrderViewController.h"
#import "EnrollGameObject.h"
#import "BaoMingShiJianView.h"
#import "YingXiongBangViewController.h"
#import "EventGetTypes.h"
#import "SpotPondInfo.h"
@interface EnrollGameNewViewController ()<ApiFetchOptionalHandler,UITableViewDelegate,UITableViewDataSource>
{
    BaoMingShiJianView *riqiView;
    NSInteger shenPi;
}
@property(strong,nonatomic)EventGameDetail *eventGameDetail;
@property(strong,nonatomic)NSArray *paiMingList;
@property(strong,nonatomic)NSString *nameStr;
@property(strong,nonatomic) UILabel *timerLabel;
@property(strong,nonatomic)__block YYTimer  *timer;
@property(assign,nonatomic)NSUInteger shiJianCha;
@property(strong,nonatomic)SpotPondInfo*selectSpotPond;

@end

@implementation EnrollGameNewViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.Jh_formTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.Jh_formTableView.bounces = NO;
    self.Jh_formTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getGameAndActDetail];
    
    self.Jh_hiddenDefaultFooterView = YES;
}
-(void)setNav{
    __weak typeof(self) weakSelf = self;
    [self setFishNavTitle:(self.isAct)?@"活动详情":@"赛事详情"];
    self.Jh_navLeftImage = @"nav_back_nor";
    if ([YuWeChatShareManager isWXAppInstalled]) {
        self.Jh_navRightImage = @"fenxiang";
        self.JhClickNavRightItemBlock = ^{
               //右侧分享点击事件
               [self share];
           };
    }
    self.JhClickNavLeftItemBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
}

-(void)initModel{
    //收藏，放鱼量，地址 经纬度
//    __block UIImageView *BGimageView;
    JhFormCellModel *cell_head = JhFormCellModel_AddCustumALLViewCell(HomeNewsBannerHeight+10);
    cell_head.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        NSArray *arrPs=[self.eventGameDetail.posters componentsSeparatedByString:@","];
        NSMutableArray *arrP = [[NSMutableArray alloc]initWithObjects:self.eventGameDetail.coverImage, nil];
        [arrP appendObjects:arrPs];
        [AllView removeAllSubviews];
         NSMutableArray *wM = [[NSMutableArray alloc]init];
             for(int i = 0;i<arrP.count;i++)
             {
                 WMBannerCellModel *model = [[WMBannerCellModel alloc]init];
                 model.imageName = [arrP objectAtIndex:i];
                 [wM addObject:model];
             }
             [ToolView getLunBoViewHeight:HomeNewsBannerHeight
                                       width:SCREEN_WIDTH-30
                                           y:10
                                           x:0
                                superView:AllView data:wM clickBlock:^(id anyID, NSInteger index) {
             }];
        
    };

    JhFormCellModel *cell_title = JhFormCellModel_AddCustumALLViewCell(75+20);
    cell_title.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        [AllView  removeAllSubviews];
//        NSDictionary *dict = @{@"normal":@"正钓",@"donkey":@"偷驴"};
//           NSArray *arr = @[@"日场",@"夜场"];
//           NSString *titleStr =[NSString stringWithFormat:@"%@ %@ %@ %@ (%@)",[dict objectForKey:self.eventGameDetail.tab],[arr objectAtIndex:self.eventGameDetail.eventTimes-1],self.eventGameDetail.fishes,self.eventGameDetail.spotName,self.eventGameDetail.name];
        UILabel *titleLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-60-30, 50) name:self.eventGameDetail.name font:[UIFont systemFontOfSize:17] textColor:BLACKCOLOR];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [AllView addSubview:titleLabel];
        self.timerLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 40+20, SCREEN_WIDTH-60-30, 25) name:@"倒计时中" font:[UIFont systemFontOfSize:17] textColor:[UIColor orangeColor]];
        if(self.eventGameDetail.isPast)
        {
            self.timerLabel.text = @"已结束";
            self.timerLabel.textColor = [UIColor orangeColor];
            self.timerLabel.font = [UIFont systemFontOfSize:14];
        }else{
        self.shiJianCha = [ToolClass timeToToday:self.eventGameDetail.endTime];
        NSSLog(@"倒计时中 = %@",[ToolClass timeFormatted:self.shiJianCha]);
        self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(timerDaoJiShi:) repeats:YES];
        [self.timer fire];
        }
        self.timerLabel.textAlignment = NSTextAlignmentLeft;
        [AllView addSubview:self.timerLabel];
        
        [self bindValue:self.eventGameDetail view:AllView];
//        NSString *title = nil;
//        NSString *imageS = nil;
//        if(self.eventGameDetail.isCollect)
//        {
//            title  = @"已收藏";
//            imageS = @"starYes";
//        }else{
//            title  = @"收藏";
//            imageS = @"starNo1";
//        }
//        LPButton *btn =[ToolView btnTitle:title image:imageS tag:0 superView:AllView sel:@selector(storeClick:) targer:self setStyle:LPButtonStyleTop font:12];
//        btn.frame =CGRectMake(SCREEN_WIDTH-60-15, 5, 60, 60);
//        if(self.eventGameDetail.isCollect)
//        {
//            btn.isSelected = YES;
//        }else{
//            btn.isSelected = NO;
//        }
        LPButton * btn=[ToolView btnTitle:[NSString stringWithFormat:@"%ld",self.eventGameDetail.readNum] image:@"guanzhu" tag:0 superView:AllView sel:@selector(guanZhu:) targer:self setStyle:LPButtonStyleLeft font:12];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.frame =CGRectMake(SCREEN_WIDTH-100, 20, 100, 30);

    };
    float _titleWidth = 80;
     JhFormCellModel *cell_diaoChangmingcheng = JhFormCellModel_Info(@"钓场名称", @"", JhFormCellTypeInput);
    cell_diaoChangmingcheng.Jh_titleWidth = _titleWidth;
     cell_diaoChangmingcheng.Jh_info= [NSString stringWithFormat:@"%@",self.eventGameDetail.spotName];
    
    JhFormCellModel *cell_address = JhFormCellModel_AddInputCell((self.isAct)?@"活动地址":@"比赛地址", @"", NO, 0);
    cell_address.Jh_titleWidth = _titleWidth;
    cell_address.Jh_editable = NO;
    cell_address.Jh_info = self.eventGameDetail.address;
    cell_address.Jh_defaultHeight = 44;
    cell_address.Jh_intputCellRightViewWidth = 30;
     if(([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])||([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]))
     {
        UIImageView *imageView = [FViewCreateFactory createImageViewWithImageName:@"daohang"];
           imageView.userInteractionEnabled = YES;
           UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
               [self toLocation];
           }];
           [imageView addGestureRecognizer:tap];
         cell_address.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
                [RightView  addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(10);
                    make.right.mas_equalTo(0);
                    make.width.equalTo(@30);
                    make.height.equalTo(@30);
                }];
            };
     }
    NSDictionary *typeDict = @{@"1":@"黑坑",@"7":@"欢乐塘",@"8":@"练竿塘",@"9":@"竞技池",@"2":@"路亚"};
   JhFormCellModel *cell_leixing = JhFormCellModel_Info(@"类型", @"", JhFormCellTypeInput);
    cell_leixing.Jh_titleWidth = _titleWidth;
    cell_leixing.Jh_info = [typeDict objectForKey:[NSString stringWithFormat:@"%ld", self.eventGameDetail.spotType]];
    JhFormCellModel *cell_riqi = JhFormCellModel_Info(@"活动时间", @"", JhFormCellTypeInput);
     cell_riqi.Jh_titleWidth = _titleWidth;
     cell_riqi.Jh_info = [ToolClass dateToString4:self.eventGameDetail.startTime];
    
    JhFormCellModel *cell_fangyuliang = JhFormCellModel_Info(@"放鱼量", @"", JhFormCellTypeInput);
    cell_fangyuliang.Jh_titleWidth = _titleWidth;
    cell_fangyuliang.Jh_info = [NSString stringWithFormat:@"%ld斤",self.eventGameDetail.fishNum];
    JhFormCellModel *cell_huigou = JhFormCellModel_Info(@"回购", @"", JhFormCellTypeInput);
    cell_huigou.Jh_titleWidth = _titleWidth;
    cell_huigou.Jh_info = [NSString stringWithFormat:@"%.2f元/斤", self.eventGameDetail.repurchase];
    JhFormCellModel *cell_baomingfeiyong = JhFormCellModel_Info(@"报名费用", @"", JhFormCellTypeInput);
    cell_baomingfeiyong.Jh_titleWidth = _titleWidth;
    cell_baomingfeiyong.Jh_info = [NSString stringWithFormat: @"%@元/人",self.eventGameDetail.money];
    JhFormCellModel *cell_jiaonafeiyong = JhFormCellModel_Info(@"缴纳押金", @"", JhFormCellTypeInput);
    cell_jiaonafeiyong.Jh_titleWidth =_titleWidth;
    cell_jiaonafeiyong.Jh_info = [NSString stringWithFormat: @"%@元/人",(self.eventGameDetail.prepayMoney)?self.eventGameDetail.prepayMoney:@"0"];
    JhFormCellModel *cell_diaokeng = JhFormCellModel_Info(@"钓坑", @"", JhFormCellTypeInput);
    cell_diaokeng.Jh_titleWidth = _titleWidth;
    cell_diaokeng.Jh_info = [NSString stringWithFormat: @"%@",(self.selectSpotPond.name)?self.selectSpotPond.name:@"无"];
    [[ApiFetch share]spotGetFetch:SPOT_PONDBYID query:@{@"id":@(self.eventGameDetail.fishpondId)} holder:self dataModel:SpotPondInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
          SpotPondInfo*pond = (SpotPondInfo*)modelValue;
          cell_diaokeng.Jh_info=pond.name;
      }];
    JhFormCellModel *cell_xianzhirenshu = JhFormCellModel_Info(@"限制人数", @"", JhFormCellTypeInput);
      cell_xianzhirenshu.Jh_titleWidth = _titleWidth;
      cell_xianzhirenshu.Jh_info = [NSString stringWithFormat:@"限%ld人",self.eventGameDetail.peopleNumber];
     
    float height = 70;

//    riqiView = [[BaoMingShiJianView alloc]initWithFrame:CGRectMake(-15, 0, SCREEN_WIDTH, height)];
//        JhFormCellModel *cell_riqi = JhFormCellModel_AddCustumALLViewCell(height);
//        riqiView.timeLabel.text =[NSString stringWithFormat:@"%@  限%d人", [ToolClass dateToString4:self.eventGameDetail.startTime],20];
//                NSDictionary *dict = @{@"normal":@"正钓",@"donkey":@"偷驴",@"positive":@"正场",@"sub":@"副场",@"pick":@"捡漏"};
//                   NSArray *arr = @[@"日场",@"夜场"];
//    NSArray*fishesA = [self.eventGameDetail.fishes componentsSeparatedByString:@","];
//    if(fishesA.count>=1)
//    {
//        riqiView.fishesLabel.text=[fishesA objectAtIndex:0];
//    }else{
//        riqiView.fishesLabel.text=@"鲫鱼";
//    }
//    riqiView.richangLabel.text = [arr objectAtIndex:self.eventGameDetail.eventTimes-1];
//    riqiView.typeLabel.text = [dict objectForKey:self.eventGameDetail.tab];
//        cell_riqi.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
//
//            [AllView addSubview:self->riqiView];
//            AllView.userInteractionEnabled = YES;
//            [self->riqiView mas_makeConstraints:^(MASConstraintMaker *make) {
//                     make.left.equalTo(AllView.mas_left).offset(-15);
//                     make.right.equalTo(AllView.mas_right).offset(15);
//                     make.top.equalTo(AllView.mas_top);
//                     make.bottom.equalTo(AllView.mas_bottom);
//                 }];
//
//        };
    JhFormCellModel *cell_paiming;
    if(self.paiMingList!=nil)
    {
         if(self.paiMingList.count>0){
             cell_paiming = JhFormCellModel_AddInputCell(@"榜单排名:", @"", NO, 0);
             cell_paiming.Jh_editable = NO;
             cell_paiming.Jh_info =@" ";
             cell_paiming.Jh_defaultHeight = 44;
             cell_paiming.Jh_intputCellRightViewWidth = 210;
             cell_paiming.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
                    NSMutableArray *arrM=[[NSMutableArray alloc]initWithCapacity:0];
                    for(int i=0;i<self.paiMingList.count;i++)
                    {
                        PaiMingItem *paimingItem = [self.paiMingList objectAtIndex:i];
                        UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(intoPaiMingViewController:) tag:0];
                        [btn sd_setImageWithURL:[NSURL URLWithString:paimingItem.headImg] forState:UIControlStateNormal];
                        btn.layer.cornerRadius = 20;
                        btn.clipsToBounds = YES;
                        [RightView addSubview:btn];
                        [arrM addObject:btn];
                    }
                    UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(intoPaiMingViewController:) tag:0];
                    [btn setImage:[UIImage imageNamed:@"rightInto_b"] forState:UIControlStateNormal];
                    btn.layer.cornerRadius = 20;
                    btn.clipsToBounds = YES;
                    [RightView addSubview:btn];
                    [arrM addObject:btn];
                    
                    [arrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:40 leadSpacing:0 tailSpacing:0];
                    [arrM mas_makeConstraints:^(MASConstraintMaker *make){
                        make.height.equalTo(@(40));
                        make.centerY.equalTo(RightView.mas_centerY);
                    }];
                };
               
         }
    }
    
    JhFormCellModel *cell_tishi = JhFormCellModel_Info(@"温馨提示：", @"", JhFormCellTypeInput);
    cell_tishi.Jh_info = @"";
    cell_tishi.Jh_defaultHeight = 21;
    JhFormCellModel *cell_tishi1 = JhFormCellModel_Info(@"", @"", JhFormCellTypeInput);
      cell_tishi1.Jh_info = @"1、一个赛事/活动多次报名情况，只统计第一次报名时的排名；\n2、一次报名多人，只算1人成绩；";
    cell_tishi1.Jh_defaultHeight = 44;
    DetailCommonView *detailView = [[DetailCommonView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1000)];
    detailView.detailContent=  self.eventGameDetail.content;
    detailView.detailTitleLabel.text = (self.isAct)?@"":@"";
    if(detailView.height>770)
    {
        detailView.detailView.scrollEnabled = YES;
    }
    JhFormCellModel *cell_bottom = JhFormCellModel_AddCustumALLViewCell(detailView.height);
    cell_bottom.Jh_cellBgColor = [UIColor groupTableViewBackgroundColor];
    cell_bottom.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        [AllView removeAllSubviews];
        AllView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        detailView.layer.cornerRadius = 5;
        [AllView addSubview:detailView];
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(AllView.mas_left).offset(-15);
            make.right.equalTo(AllView.mas_right).offset(15);
            make.top.equalTo(AllView.mas_top).offset(10);
            make.bottom.equalTo(AllView.mas_bottom);
        }];
    };
    
    JhFormSectionModel *section;
     section =JhSectionModel_Add(@[
        cell_head,
        cell_title,
        cell_diaoChangmingcheng,
        cell_address,
        cell_riqi,
        cell_leixing,
        cell_fangyuliang,
        cell_huigou,
        cell_baomingfeiyong,
        cell_jiaonafeiyong,
        cell_diaokeng,
        cell_xianzhirenshu,
        cell_tishi,
        cell_tishi1,
        cell_bottom
    ]);
    if(self.paiMingList!=nil)
      {
           if(self.paiMingList.count>0){
                section =JhSectionModel_Add(@[
                   cell_head,
                   cell_title,
                   cell_diaoChangmingcheng,
                   cell_address,
                   cell_riqi,
                   cell_leixing,
                   cell_fangyuliang,
                   cell_huigou,
                   cell_baomingfeiyong,
                   cell_jiaonafeiyong,
                   cell_diaokeng,
                   cell_xianzhirenshu,
                   cell_paiming,
                   cell_tishi,
                   cell_tishi1,
                   cell_bottom
               ]);
           }
          
      }
    
 
    [self.Jh_formModelArr removeAllObjects];
    [self.Jh_formModelArr addObjectsFromArray:@[section]];
    self.Jh_hiddenDefaultFooterView = YES;
    [self.Jh_formTableView reloadData];
    
    
    
    
    
    
    if((!self.eventGameDetail.isPast)&&(self.isShenPi==NO))
    {
        UIButton *enrollBtn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, SCREEN_HEIGHT-20-40-20, 80, 50) name:@""
                                                                            delegate:self selector:@selector(shenPi:) tag:102];
                         enrollBtn.layer.cornerRadius = 10.0;
                        [enrollBtn setBackgroundImage:[UIImage imageNamed:@"bgshoucang"]
                                             forState:UIControlStateNormal];

                         [self.view addSubview:enrollBtn];
        
                NSString *title = nil;
                NSString *imageS = nil;
                if(self.eventGameDetail.isCollect)
                {
                    title  = @"已收藏";
                    imageS = @"yishoucang";
                }else{
                    title  = @"收藏";
                    imageS = @"shoucang";
                }
                LPButton *btn =[ToolView btnTitle:title image:imageS tag:0 superView:enrollBtn sel:@selector(storeClick:) targer:self setStyle:LPButtonStyleTop font:12];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.frame =CGRectMake(0, 0, 80, 50);
                if(self.eventGameDetail.isCollect)
                {
                    btn.isSelected = YES;
                }else{
                    btn.isSelected = NO;
                }
        
        
               enrollBtn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(100+5, SCREEN_HEIGHT-20-40-20,SCREEN_WIDTH - 100 - 5 - 20, 50) name:@"立即报名"
                                                                                            delegate:self selector:@selector(enrollGame:) tag:103];
                               enrollBtn.layer.cornerRadius = 10.0;
        UIImage*image1 =[UIImage imageNamed:@"baoming"];
        image1=[image1 stretchableImageWithLeftCapWidth:image1.size.width*0.3 topCapHeight:image1.size.height*0.7];

                              [enrollBtn setBackgroundImage:image1 forState:UIControlStateNormal];
                               [self.view addSubview:enrollBtn];
    }
    if(self.isShenPi == 1)//待审批
    {
        UIButton *enrollBtn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, SCREEN_HEIGHT-20-40-5, (SCREEN_WIDTH - 30 *2)/2.0, 40) name:@"不通过"
                                                                     delegate:self selector:@selector(shenPi:) tag:103];
                  enrollBtn.backgroundColor = [UIColor lightGrayColor];
                  enrollBtn.layer.cornerRadius = 10.0;
                  [self.view addSubview:enrollBtn];
        enrollBtn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20+(SCREEN_WIDTH - 30 *2)/2.0+20, SCREEN_HEIGHT-20-40-5, (SCREEN_WIDTH - 30 *2)/2.0, 40) name:@"通过"
                                                                                     delegate:self selector:@selector(shenPi:) tag:102];
                        enrollBtn.backgroundColor = NAVBGCOLOR;
                        enrollBtn.layer.cornerRadius = 10.0;
                        [self.view addSubview:enrollBtn];
    }
}
-(void)shenPi:(UIButton*)btn
{
    //2通过 3拒绝
    int  l =btn.tag -100;
    NSString *sIDs =[NSString stringWithFormat:@"%ld",self.eventGameDetail.id];
    NSLog(@"sids = %@",sIDs);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:sIDs forKey:@"eventId"];
    [dict setValue:@(l) forKey:@"status"];
    [[ApiFetch share] eventGetFetch:EVENT_DAILISHENPI query:dict holder:self dataModel:EventSpotGame.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self addAlert];
    }];
}
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审批成功" message:@"审批结果在赛事审批的\"已审批\"中查看" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}
-(void)timerDaoJiShi:(YYTimer*)timer
{
    self.timerLabel.text = [ToolClass timeFormatted:self.shiJianCha];
    self.shiJianCha = self.shiJianCha - 1;
}
#pragma mark -button 点击事件
-(void)enrollGame:(UIButton*)btn
{
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    if (self.eventGameDetail.isPay) {
        //有待支付跳转至订单列表
        MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
        myOrderVC.intoPageType = 2;
        myOrderVC.vc= self;
        [self.navigationController pushViewController:myOrderVC
                                             animated:YES];
        return;
    }
    EnrollGameObject *obj = [[EnrollGameObject alloc]init];
    [obj enrollGame:self.eventGameDetail eventId:self.eventId vc:self];
    obj.createOrderSuccessClick = ^(BOOL success) {
        self.eventGameDetail.isPay = success;
    };
}

-(void)storeClick:(LPButton *)btn
{
    if(![[AppManager manager]userHasLogin])
       {
           [self showDefaultInfo:@"请先登录"];
           return;
       }
    @weakify(self)
    if(btn.isSelected == YES)
    {
        [[ApiFetch share] eventGetFetch:EVENT_STORE_CANCEL query:@{@"eventId":@(self.eventId)} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response)
        {
                    [weak_self hideHud];
                    [weak_self makeToask:@"取消收藏"];
              [btn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
              btn.isSelected = NO;
          }];
        return;
    }
    [[ApiFetch share] eventGetFetch:EVENT_STORE query:@{@"userId":@([AppManager manager].userInfo.id),@"eventId":@(self.eventId)} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
              [weak_self hideHud];
              [weak_self makeToask:@"收藏成功"];
        [btn setImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateNormal];
        btn.isSelected = YES;
    }];
}
//分享
-(void)share
{
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    YuShareGameViewController *posterShareVC = [[YuShareGameViewController alloc] init];
    posterShareVC.eventGameDetail = self.eventGameDetail;
    [self presentViewController:posterShareVC
                       animated:YES
                     completion:^{

    }];
}
#pragma mark -数据请求
//活动赛事
-(void)getGameAndActDetail
{
    [self.timer invalidate];
    self.timer = nil;
    self.timerLabel.text = nil;
    [[ApiFetch share] eventGetFetch:EVENT_DETAIL_BYID query:@{@"eventId":@((self.eventId==0)?1:self.eventId)} holder:self dataModel:EventGameDetail.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                  NSLog(@"modelValue = %@",modelValue);
        self.eventGameDetail =(EventGameDetail*)modelValue;
        if(self.eventGameDetail.fishpondId)
        {
            [[ApiFetch share]spotGetFetch:SPOT_PONDBYID query:@{@"id":@(self.eventGameDetail.fishpondId)} holder:self dataModel:SpotPondInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                self.selectSpotPond = (SpotPondInfo*)modelValue;
                if(self.eventGameDetail.isPast)
                {
                    [self getPaiMingLieBiao];
                }else{
                    [self initModel];
                }
                
            }];
            
        }else{
            if(self.eventGameDetail.isPast)
            {
                [self getPaiMingLieBiao];
            }else{
                [self initModel];
            }
        }
    }];
}
-(void)getPaiMingLieBiao
{
    NSLog(@"bbbbbbbb%s",__func__);
//    {
//      "code": 0,
//      "data": [
//        {
//          "createTime": "2020-02-15T12:50:27.671Z",
//          "currencyCount": 0,
//          "eventId": 0,
//          "headImg": "string",
//          "id": 0,
//          "nickName": "string",
//          "updateTime": "2020-02-15T12:50:27.671Z",
//          "userId": 0
//        }
//      ],
//      "message": "string"
//    }
    [[ApiFetch share] orderGetFetch:EVENT_NEWCURRENTLIST query:@{@"eventId":@((self.eventId==0)?1:self.eventId)} holder:self dataModel:PaiMingList.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                   NSLog(@"modelValue 排名列表= %@",modelValue);
        PaiMingList *paiminglist = (PaiMingList*)modelValue;
         self.paiMingList =(NSArray *)paiminglist.list;
        self.nameStr = [NSString stringWithFormat:@"%@ (%@)", paiminglist.eventName,[ToolClass dateToString1:paiminglist.startTime]];
        [self initModel];
         [self hideHud];
     }];
}
-(void)intoPaiMingViewController:(UIButton *)btn
{
    IntegralRankTableViewController *vc = [[IntegralRankTableViewController alloc]init];
//    YingXiongBangViewController *vc =[[YingXiongBangViewController alloc]init];
    vc.paimingLists =self.paiMingList;
    vc.nameStr = self.nameStr;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
     [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}

-(void)toLocation
{
    @weakify(self)
    
    UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"App导航" message:@"" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
     UIAlertAction * baiduApp = [UIAlertAction actionWithTitle:@"百度导航" style:0 handler:^(UIAlertAction * _Nonnull action) {
         [ToolClass openBaiduMapAppTo:weak_self.eventGameDetail.latitude
                                  lng:weak_self.eventGameDetail.longitude
                         withSpotName:weak_self.eventGameDetail.name
                               result:^(BOOL success) {
             if (!success) {
                 [self showDefaultInfo:@"打开百度导航失败，请检查是否安装了App"];
             }
         }];
     }];
     UIAlertAction * gaodeApp = [UIAlertAction actionWithTitle:@"高德导航" style:0 handler:^(UIAlertAction * _Nonnull action) {
         [ToolClass openGaodeMapAppTo:weak_self.eventGameDetail.latitude
                                          lng:weak_self.eventGameDetail.longitude
                         withSpotName:weak_self.eventGameDetail.name
                               result:^(BOOL success) {
             if (!success) {
                 [self showDefaultInfo:@"打开高德导航失败，请检查是否安装了App"];
             }
         }];
     }];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                    style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        [actionSheet addAction:baiduApp];
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        [actionSheet addAction:gaodeApp];
    }
    
    [self presentViewController:actionSheet
                       animated:YES
                     completion:^{
        
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.paiMingList!=nil)
       {
           if(self.paiMingList.count>0){
               
           }
       }
}
-(void)guanZhu:(UIButton*)btn
{
    
}
-(void)bindValue:(EventGameDetail *)gameItem view:(UIView*)view
{

    NSMutableArray *titleLabelArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    ColorLabel *colorLabel1=[[ColorLabel alloc]init];
    [view addSubview:colorLabel1];
    [titleLabelArr1 addObject:colorLabel1];
    ColorLabel *colorLabel2=[[ColorLabel alloc]init];
    [view addSubview:colorLabel2];
    [titleLabelArr1 addObject:colorLabel2];
    ColorLabel *colorLabel3=[[ColorLabel alloc]init];
    [view addSubview:colorLabel3];
    [titleLabelArr1 addObject:colorLabel3];

    colorLabel1.text = (gameItem.type == 1)?@"活动":@"赛事";
    colorLabel2.text = (gameItem.eventTimes ==1)?@"日场":@"夜场";
    colorLabel3.text = (gameItem.isPast == 1)?@"已过期":@"报名中";
    colorLabel1.font = [UIFont systemFontOfSize:10];
    colorLabel2.font = [UIFont systemFontOfSize:10];
    colorLabel3.font = [UIFont systemFontOfSize:10];
    colorLabel1.textAlignment = NSTextAlignmentCenter;
    colorLabel2.textAlignment = NSTextAlignmentCenter;
    colorLabel3.textAlignment = NSTextAlignmentCenter;

    [titleLabelArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:(SCREEN_WIDTH-180) tailSpacing:0];
    [titleLabelArr1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(view.mas_top).offset(40+20+5);
            make.height.equalTo(@(20));
    }];

}
@end
