//
//  FaBuSaiShiViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/8.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FaBuSaiShiViewController.h"
#import "QuRenZhengView.h"
#import "DiaoChangZhuRenZhengViewController.h"
#import "RemovableView.h"
#import "CXDatePickerView.h"
#import "SelectView.h"
#import "RITLPhotosViewController.h"
#import "IQKeyboardManager.h"
#import "ChooseFaBuDateViewController.h"
#import "MonthOpeartion.h"
#import "CalendarModel.h"
#import "HuoDongSaiShiShuoMingViewController.h"
#import "ChooseMoRenTuPianViewController.h"
@interface FaBuSaiShiViewController ()<UITextFieldDelegate,RITLPhotosViewControllerDelegate,ApiFetchOptionalHandler>
{
    
    
    NSArray *moshiArr;
    NSArray *baomingjiezhiArr;
    
    QuRenZhengView *noRenZhengView;
    UIScrollView *bgScrollView;
    UIView *bgView;
    
    __block MySelButton *fengMianTuBtn;
    GreenLineTextField *jianJieGreenTF;
    UITextField *titleSaiShiActTextField;
    
    RemovableViewContainer *container;
    LPButton *lpxieYi;
    GreenLineTextField* saiShiriqi;
    
    
    GreenLineTextField* type;
    NSInteger spotType;
    GreenLineTextField* wanFa;
    NSInteger playType;
    GreenLineTextField* fangshi;
    NSString *tab;
    GreenLineTextField* moshi;
    NSInteger pattern;
    
    GreenLineTextField* kaishishijian;
    GreenLineTextField* jieshushijian;
    GreenLineTextField* yaohaoshijian;
    GreenLineTextField* baomingjiezhi;
    NSInteger endTimeInt;
    
    GreenLineTextField* diaokeng;
    GreenLineTextField* fangyu;
    GreenLineTextField* yupiao;
    GreenLineTextField* dingjin;
    GreenLineTextField* huigou;
    GreenLineTextField* renshu;
    UILabel *renshuSlabel;
    SelectView *yuzhongS;
    
    GreenLineTextField * yuzhongBg;
}
@property(strong,nonatomic)EventGameDetail*eventGameDetail;
@property(strong,nonatomic)EventGetTypes *eventGetTypes;
@property(strong,nonatomic)SpotPondInfo *selectSpotPond;
@end

@implementation FaBuSaiShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:(self.isSaiShi?(@"发布鱼讯"):(@"发布鱼讯")) isShowBack:YES];
    [hkNavigationView setNavBarViewRightBtnWithName:@"说明" target:self action:@selector(shuoMing:)];
    //    LPButton *lp = [ToolView btnTitle:@"1111111" image:@"shuoming" tag:0 superView:hkNavigationView sel:@selector() targer:self setStyle:LPButtonStyleLeft font:14];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(SCREEN_WIDTH/2.0+50, Height_StatusBar+12, 20, 20);
    [btn setImage:[UIImage imageNamed:@"shuoming_w"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shuomingBiaoTiclick:) forControlEvents:UIControlEventTouchUpInside];
    [hkNavigationView addSubview:btn];
    [[MonthOpeartion defaultMonthOpeartion].selectedDays removeAllObjects];
    NSLog(@"eventid = %ld",self.eventGameDetail.id);
    //没有认证，就认证
    if(self.isPublish == NO)
    {
        [self addNoRenZhengView];
    }else{
        [self getKeXuanLeiXing];
        
        
    }
    
}
-(void)shuomingBiaoTiclick:(UIButton *)btn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"1、一个赛事/活动多次报名情况，只统计第一次报名时的排名；\n2、一次报名多人，只算1人成绩；" preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alert.view.subviews[0];

    UIView *subView2 = subView1.subviews[0];

    UIView*subView3 = subView2.subviews[0];

    UIView*subView4 = subView3.subviews[0];

    UIView*subView5 = subView4.subviews[0];

    for(int i=0;i<subView5.subviews.count;i++)
    {
        if([subView5.subviews[i] isKindOfClass:UILabel.class])
        {
            UILabel *label = subView5.subviews[i];
            if([label.text isEqualToString:@"1、一个赛事/活动多次报名情况，只统计第一次报名时的排名；\n2、一次报名多人，只算1人成绩；"])
            {
                label.textAlignment = NSTextAlignmentLeft;
            }
        }
    }
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)getKeXuanLeiXing
{
    NSLog(@"认证在进入发布活动页面=");

    [[ApiFetch share]eventGetFetch:EVENT_GETTYPE query:@{} holder:self dataModel:EventGetTypes.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        self.eventGetTypes =(EventGetTypes*) modelValue;
        [self addFaQiHuoDong];
        @weakify(self)
        [[ApiFetch share]eventGetFetch:EVENT_EVENTMODEL query:@{@"type":@(self.isSaiShi?2:1)} holder:self dataModel:EventGameDetail.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            NSLog(@"认证在进入发布活动页面=%@",modelValue);
            weak_self.eventGameDetail = (EventGameDetail*)modelValue;
            //认证在进入发布活动页面
            if(weak_self.eventGameDetail.id != 0)
            {
                [self addData];
            }
            
        }];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = YES;
    
    if([MonthOpeartion defaultMonthOpeartion].selectedDays.count==0)
    {
        saiShiriqi.enterTextField.text = @"";
    }else if([MonthOpeartion defaultMonthOpeartion].selectedDays.count==1){
        DayModel *model = [MonthOpeartion defaultMonthOpeartion].selectedDays[0];
        saiShiriqi.enterTextField.text = [NSString stringWithFormat:@"%ld-%ld-%ld",model.year,model.month,model.day];
        
    }else{
        saiShiriqi.enterTextField.text = [NSString stringWithFormat:@"共%ld天",[MonthOpeartion defaultMonthOpeartion].selectedDays.count];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = NO;
}
-(void)addData{
    NSDictionary *typeDict = @{@"1":@"黑坑",@"7":@"欢乐塘",@"8":@"练竿塘",@"9":@"竞技池",@"2":@"路亚"};
    type.enterTextField.text = [typeDict objectForKey:[NSString stringWithFormat:@"%ld", self.eventGameDetail.spotType]];
    spotType = self.eventGameDetail.spotType;
    playType = self.eventGameDetail.playType;
    if(playType!=0)
    {
    NSArray *playArr = @[@"抽号模式",@"计时模式"];
    wanFa.enterTextField.text = [playArr objectAtIndex:(playType-1)];
    }
    NSDictionary*fangShiDict = @{@"normal":@"正钓",@"donkey":@"偷驴",@"positive":@"正场",@"sub":@"副场",@"pick":@"捡漏"};
    tab =self.eventGameDetail.tab;
    if([tab isEqualToString:@"normal"]||[tab isEqualToString:@"positive"])
    {
        [fangyu.leftLabel setRedStarText:@"*放鱼"];
    }else{
        [fangyu.leftLabel setRedStarText:@"放鱼"];
    }
    fangshi.enterTextField.text = [fangShiDict objectForKey:tab];
        NSArray *moshiArr =@[@"赛事排名",@"赛事抽奖",@"活动普通",@"活动积分"];
    pattern = self.eventGameDetail.pattern;
    if(self.eventGameDetail.pattern!=0)
    {
    LPButton*btnmoshi = [bgView viewWithTag:(((self.isSaiShi)?(pattern-1):(pattern-3))+100)];
    [self moshiclick:btnmoshi];
    }
    
    kaishishijian.enterTextField.text=self.eventGameDetail.startTimeStr;
    jieshushijian.enterTextField.text=self.eventGameDetail.finishTimeStr;
    yaohaoshijian.enterTextField.text=self.eventGameDetail.lotTimeStr;
    
    LPButton * btn = [bgView viewWithTag:(self.eventGameDetail.endTimeInt-1+200)];
    [self baomingjiezhiclick:btn];
    
    NSArray *arr1 = [self.eventGetTypes.fishes componentsSeparatedByString:@","];
    NSArray *fishArr = [self.eventGameDetail.fishes componentsSeparatedByString:@","];
    NSMutableArray*fishArrs = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSString*s in fishArr) {
        for (int i=0; i<arr1.count; i++) {
            NSString *ts = [arr1 objectAtIndex:i];
            if([ts isEqualToString:s])
            {
                [fishArrs addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    [yuzhongS setMoRenSelectedMarkArray:fishArrs];
    fangyu.enterTextField.text = [NSString stringWithFormat:@"%ld", self.eventGameDetail.fishNum];
    yupiao.enterTextField.text = self.eventGameDetail.money;
    dingjin.enterTextField.text = self.eventGameDetail.prepayMoney;
    huigou.enterTextField.text =[NSString stringWithFormat:@"%.2f", self.eventGameDetail.repurchase];
    renshu.enterTextField.text = [NSString stringWithFormat:@"%ld", self.eventGameDetail.peopleNumber];
    jianJieGreenTF.textView.text = self.eventGameDetail.content;
    
    [[ApiFetch share]spotGetFetch:SPOT_PONDBYID query:@{@"id":@(self.eventGameDetail.fishpondId)} holder:self dataModel:SpotPondInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        self.selectSpotPond = (SpotPondInfo*)modelValue;
        self->diaokeng.enterTextField.text = self.selectSpotPond.name;
        self->renshuSlabel.text =[NSString stringWithFormat:@"不能大于钓场钓位总数：%ld个",self.selectSpotPond.spotCount];

    }];
    if(self.eventGameDetail.playType == 2)
    {
        [self->yaohaoshijian mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@0);
                }];
        self->yaohaoshijian.hidden = YES;
    }else{
        [self->yaohaoshijian mas_updateConstraints:^(MASConstraintMaker *make) {
                          make.height.equalTo(@50);
                      }];
        self->yaohaoshijian.hidden = NO;
    }
    
    saiShiriqi.switchView.on= self.eventGameDetail.overDay;
    titleSaiShiActTextField.text = self.eventGameDetail.name;
}
-(void)addFaQiHuoDong
{
    bgScrollView = [[UIScrollView alloc]init];
    bgScrollView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar);
    [self.view addSubview:bgScrollView];
    bgView = [FViewCreateFactory createViewWithBgColor:WHITECOLOR];
    [bgScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgScrollView);
        make.width.equalTo(bgScrollView);
        make.height.greaterThanOrEqualTo(bgScrollView.mas_height);
    }];
    __weak __typeof(self) weakSelf = self;
    
    type = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:type];
    [type.leftLabel setRedStarText:@"*类型"];
    type.enterTextField.tag =0;
    type.enterTextField.placeholder=(self.isSaiShi?(@"请选择鱼讯类型"):(@"请选择鱼汛类型"));
    type.enterTextField.tag =TEXTFIELD_SAISHISHIJIAN_TAG;
    type.textFieldClick = ^(UITextField * textField) {
        @weakify(type)
        //1黑坑2路亚7欢乐塘8练竿9竞技
        UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:(self.isSaiShi?(@"请选择赛事类型"):(@"请选择活动类型")) preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        NSDictionary *typeDict = @{@"1":@"黑坑",@"7":@"欢乐塘",@"8":@"练竿塘",@"9":@"竞技池",@"2":@"路亚"};
        NSArray *typeSArr=[self.eventGetTypes.spotType componentsSeparatedByString:@","];
        for(int i=0;i<typeSArr.count;i++)
        {
            NSString*s = [typeSArr objectAtIndex:i];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:[typeDict objectForKey:s] style:0 handler:^(UIAlertAction * _Nonnull action) {
                weak_type.enterTextField.text = [typeDict objectForKey:s];
                self->spotType = [s intValue];
            }];
            [actionSheet addAction:action1];
        }
        
        [self presentViewController:actionSheet
                           animated:YES
                         completion:^{
        }];
    };
    type.rightButton.hidden = NO;
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(-5);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    fangyu = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
      [bgView addSubview:fangyu];
    fangshi = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:fangshi];
    [fangshi.leftLabel setRedStarText:@"*方式"];
    fangshi.enterTextField.tag =0;
    fangshi.enterTextField.placeholder=@"请选择参与方式";
    fangshi.enterTextField.tag =TEXTFIELD_SAISHISHIJIAN_TAG;
    @weakify(fangshi);
    fangshi.textFieldClick = ^(UITextField * textField) {
        //"tab": string,                            是    normal:正钓donkey:偷驴positive:正场sub:副场pick:捡漏单选
        UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"请选择参与方式" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"正钓" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_fangshi.enterTextField.text = @"正钓";
            self->tab = @"normal";
            [self->fangyu.leftLabel setRedStarText:@"*放鱼"];

            
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"偷驴" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_fangshi.enterTextField.text = @"偷驴";
            self->tab = @"donkey";
            [self->fangyu.leftLabel setRedStarText:@"放鱼"];

            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"正场" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_fangshi.enterTextField.text = @"正场";
            self->tab = @"positive";
            [self->fangyu.leftLabel setRedStarText:@"*放鱼"];
        }];
        UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"副场" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_fangshi.enterTextField.text = @"副场";
            self->tab = @"sub";
            [self->fangyu.leftLabel setRedStarText:@"放鱼"];

            
        }];
        UIAlertAction * action5 = [UIAlertAction actionWithTitle:@"捡漏" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_fangshi.enterTextField.text = @"捡漏";
            self->tab = @"pick";
            [self->fangyu.leftLabel setRedStarText:@"放鱼"];

            
        }];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [actionSheet addAction:action1];
        [actionSheet addAction:action2];
        [actionSheet addAction:action3];
        [actionSheet addAction:action4];
        [actionSheet addAction:action5];
        [self presentViewController:actionSheet
                           animated:YES
                         completion:^{
            
        }];
    };
    fangshi.rightButton.hidden = NO;
    [fangshi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(type.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    //模式1赛事排名，2赛事抽奖，3活动普通，4活动积分
    moshi = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:moshi];
    [moshi.leftLabel setRedStarText:@"*模式"];
    moshi.enterTextField.hidden = YES;
    [moshi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fangshi.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    LPButton *lp = [ToolView btnTitle:(self.isSaiShi)?@"排名模式":@"普通模式" image:@"unselect" tag:0 superView:moshi sel:@selector(moshiclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    [lp setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    lp.tag = 100;
    LPButton *lp1 = [ToolView btnTitle:(self.isSaiShi)?@"抽奖模式":@"积分模式" image:@"unselect" tag:0 superView:moshi sel:@selector(moshiclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    [lp1 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    lp1.tag = 100+1;
    moshiArr = @[lp,lp1];
    LPButton *lp4 = [ToolView btnTitle:@"" image:@"shuoming" tag:0 superView:moshi sel:@selector(shuomingclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    lp4.hidden= self.isSaiShi;
    [lp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moshi.leftLabel.mas_right).offset(10);
        make.width.equalTo(@(100));
        make.centerY.equalTo(moshi.leftLabel.mas_centerY);
        make.height.equalTo(@35);
    }];
    [lp1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lp.mas_right);
        make.width.equalTo(@(100));
        make.centerY.equalTo(moshi.leftLabel.mas_centerY);
        make.height.equalTo(@35);
    }];
    [lp4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lp1.mas_right);
        make.width.equalTo(@(35));
        make.centerY.equalTo(moshi.leftLabel.mas_centerY);
        make.height.equalTo(@35);
    }];
    wanFa = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:wanFa];
    [wanFa.leftLabel setRedStarText:@"*玩法"];
    wanFa.enterTextField.tag =0;
    wanFa.enterTextField.placeholder=(self.isSaiShi?(@"请选择赛事玩法"):(@"请选择活动玩法"));
    wanFa.enterTextField.tag =TEXTFIELD_SAISHISHIJIAN_TAG;
    @weakify(wanFa);
    wanFa.textFieldClick = ^(UITextField * textField) {
        UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:(self.isSaiShi?(@"请选择赛事玩法"):(@"请选择活动玩法")) preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"抽号模式" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_wanFa.enterTextField.text = @"抽号模式";
            self->playType = 1;
            self->yaohaoshijian.hidden = NO;
            [self->yaohaoshijian mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@50);
            }];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"计时模式" style:0 handler:^(UIAlertAction * _Nonnull action) {
            weak_wanFa.enterTextField.text = @"计时模式";
            self->playType = 2;
            self->yaohaoshijian.hidden = YES;
            [self->yaohaoshijian mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@0);
            }];
        }];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [actionSheet addAction:action1];
        [actionSheet addAction:action2];
        [self presentViewController:actionSheet
                           animated:YES
                         completion:^{
            
        }];
    };
    wanFa.rightButton.hidden = NO;
    [wanFa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moshi.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    UILabel *slabel = [FViewCreateFactory createLabelWithName:@"--------------------------------------------------------------------------------------------------------------------------------------------------------" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    slabel.lineBreakMode = NSLineBreakByClipping;
    [bgView addSubview:slabel];
    [slabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wanFa.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@(SCREEN_WIDTH-30));
    }];
    
    
    
    
    
    saiShiriqi = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:saiShiriqi];
    [saiShiriqi.leftLabel setRedStarText:(self.isSaiShi?(@"*垂钓日期"):(@"*垂钓日期"))];
    saiShiriqi.enterTextField.tag =TEXTFIELD_SAISHISHIJIAN_TAG;
    saiShiriqi.enterTextField.placeholder=(self.isSaiShi?(@"请选择垂钓日期"):(@"请选择垂钓日期"));
    saiShiriqi.switchView.hidden = NO;
    saiShiriqi.switchView.on = NO;
    saiShiriqi.switchRLabel.hidden = NO;
    saiShiriqi.switchRLabel.text = @"跨天";
    [saiShiriqi.switchView addTarget:self action:@selector(switchClickKuaiTian:) forControlEvents:UIControlEventValueChanged];
    saiShiriqi.textFieldClick = ^(UITextField * textField) {
        ChooseFaBuDateViewController *vc = [[ChooseFaBuDateViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [saiShiriqi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slabel.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    
    kaishishijian = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:kaishishijian];
    kaishishijian.rightButton.hidden = NO;
    [kaishishijian.leftLabel setRedStarText:@"*开竿时间"];
    kaishishijian.enterTextField.tag = TEXTFIELD_BAOMINGJIEZHI_TAG;
    kaishishijian.enterTextField.placeholder=@"请选择开竿时间";
    kaishishijian.textFieldClick = ^(UITextField * textField) {
        //时-分
        NSDate * scrollToDate;
        if(![kaishishijian.enterTextField.text  isEqual: @""])
        {
            scrollToDate =  [ToolClass dateFromString2:kaishishijian.enterTextField.text];
        }else{
            scrollToDate = nil;
        }
        CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate stringWithFormat:@"HH:mm"];
            NSLog(@"选择的日期：%@",dateString);
            kaishishijian.enterTextField.text = dateString;
        }];
        datepicker.dateLabelColor = [UIColor blackColor];//时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
        datepicker.cancelButtonColor = datepicker.doneButtonColor;
        datepicker.headerViewColor = [UIColor groupTableViewBackgroundColor];
        datepicker.hideSegmentedLine=YES;
        datepicker.hideBackgroundYearLabel=YES;
        [datepicker show];
    };
    [kaishishijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(saiShiriqi.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    jieshushijian = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    jieshushijian.rightButton.hidden = NO;
    [bgView addSubview:jieshushijian];
    [jieshushijian.leftLabel setRedStarText:@"*结束时间"];
    jieshushijian.enterTextField.tag = TEXTFIELD_BAOMINGJIEZHI_TAG;
    jieshushijian.enterTextField.placeholder=@"请选择结束时间";
    jieshushijian.textFieldClick = ^(UITextField * textField) {
        //时-分
        NSDate * scrollToDate;
        if(![jieshushijian.enterTextField.text  isEqual: @""])
        {
            scrollToDate =  [ToolClass dateFromString2:jieshushijian.enterTextField.text];
        }else{
            scrollToDate = nil;
        }
        CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate stringWithFormat:@"HH:mm"];
            NSLog(@"选择的日期：%@",dateString);
            jieshushijian.enterTextField.text = dateString;
        }];
        datepicker.dateLabelColor = [UIColor blackColor];//时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
        datepicker.cancelButtonColor = datepicker.doneButtonColor;
        datepicker.headerViewColor = [UIColor groupTableViewBackgroundColor];
        datepicker.hideSegmentedLine=YES;
        datepicker.hideBackgroundYearLabel=YES;
        [datepicker show];
    };
    [jieshushijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kaishishijian.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    yaohaoshijian = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:yaohaoshijian];
    yaohaoshijian.hidden = NO;
    yaohaoshijian.rightButton.hidden = NO;
    [yaohaoshijian.leftLabel setRedStarText:@"*摇号时间"];
    yaohaoshijian.enterTextField.tag = TEXTFIELD_BAOMINGJIEZHI_TAG;
    yaohaoshijian.enterTextField.placeholder=@"请选择摇号时间";
    yaohaoshijian.textFieldClick = ^(UITextField * textField) {
        //时-分
        NSDate * scrollToDate;
        if(![yaohaoshijian.enterTextField.text  isEqual: @""])
        {
            scrollToDate =  [ToolClass dateFromString2:yaohaoshijian.enterTextField.text];
        }else{
            scrollToDate = nil;
        }
        CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate stringWithFormat:@"HH:mm"];
            NSLog(@"选择的日期：%@",dateString);
            yaohaoshijian.enterTextField.text = dateString;
        }];
        datepicker.dateLabelColor = [UIColor blackColor];//时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
        datepicker.cancelButtonColor = datepicker.doneButtonColor;
        datepicker.headerViewColor = [UIColor groupTableViewBackgroundColor];
        datepicker.hideSegmentedLine=YES;
        datepicker.hideBackgroundYearLabel=YES;
        [datepicker show];
    };
    [yaohaoshijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jieshushijian.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    baomingjiezhi = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:baomingjiezhi];
    [baomingjiezhi.leftLabel setRedStarText:@"*报名截止"];
    baomingjiezhi.enterTextField.hidden = YES;
    [baomingjiezhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yaohaoshijian.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    LPButton *lp2 = [ToolView btnTitle:@"开始时间前" image:@"unselect" tag:0 superView:baomingjiezhi sel:@selector(baomingjiezhiclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    [lp2 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    lp2.tag = 200;
    LPButton *lp3 = [ToolView btnTitle:@"结束时间前" image:@"unselect" tag:0 superView:baomingjiezhi sel:@selector(baomingjiezhiclick:) targer:self setStyle:LPButtonStyleLeft font:14];
    [lp3 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    lp3.tag = 200+1;
    baomingjiezhiArr = @[lp2,lp3];
    [lp2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baomingjiezhi.leftLabel.mas_right).offset(10);
        make.width.equalTo(@(120));
        make.centerY.equalTo(baomingjiezhi.leftLabel.mas_centerY);
        make.height.equalTo(@35);
    }];
    [lp3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lp2.mas_right);
        make.width.equalTo(@(120));
        make.centerY.equalTo(baomingjiezhi.leftLabel.mas_centerY);
        make.height.equalTo(@35);
    }];
    
    slabel = [FViewCreateFactory createLabelWithName:@"--------------------------------------------------------------------------------------------------------------------------------------------------------" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    slabel.lineBreakMode = NSLineBreakByClipping;
    [bgView addSubview:slabel];
    [slabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baomingjiezhi.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@(SCREEN_WIDTH-30));
    }];
    
    
    
    
    diaokeng = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaokeng];
    diaokeng.rightButton.hidden = NO;
    [diaokeng.leftLabel setRedStarText:@"*钓坑"];
    diaokeng.enterTextField.tag = TEXTFIELD_BAOMINGJIEZHI_TAG;
    diaokeng.enterTextField.placeholder=@"请选择本次活动钓坑";
    diaokeng.textFieldClick = ^(UITextField * textField) {
        UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"请选择钓坑" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        for(int i=0;i<self.eventGetTypes.spotFishponds.count;i++)
        {
            SpotPondInfo*spotPondInfo = [self.eventGetTypes.spotFishponds objectAtIndex:i];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:spotPondInfo.name style:0 handler:^(UIAlertAction * _Nonnull action) {
                diaokeng.enterTextField.text = spotPondInfo.name;
                self.selectSpotPond = spotPondInfo;
                self->renshuSlabel.text = [NSString stringWithFormat:@"不能大于钓场钓位总数：%ld个",spotPondInfo.spotCount];
            }];
            [actionSheet addAction:action1];
        }
        
        [self presentViewController:actionSheet
                           animated:YES
                         completion:^{
            
        }];
    };
    [diaokeng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slabel.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    yuzhongBg= [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview: yuzhongBg];
    [yuzhongBg.leftLabel setRedStarText:@"*鱼种"];
    yuzhongBg.enterTextField.hidden = YES;
    
    NSArray*fishesArr = [self.eventGetTypes.fishes componentsSeparatedByString:@","];
    yuzhongS = [[SelectView alloc]initWithArr:fishesArr row:@"4" cornerRadius:12 height:24];
    [yuzhongBg addSubview:yuzhongS];
    int hang = (int)((fishesArr.count/4)+((fishesArr.count%4==0)?0:1));
    yuzhongS.isMuli = YES;//单选
    [yuzhongBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaokeng.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@(50+(hang-1)*34));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [yuzhongS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuzhongBg.mas_top).offset(13);
        make.height.equalTo(@(24+30));
        make.left.equalTo(yuzhongBg.leftLabel.mas_right).offset(5);
        make.right.equalTo(yuzhongBg.mas_right).offset(-10);
    }];
  
    fangyu.rightLabel.hidden = NO;
    fangyu.rightLabel.text = @"斤";
    [fangyu.leftLabel setRedStarText:@"*放鱼"];
    fangyu.enterTextField.placeholder=@"请填写放鱼量";
    fangyu.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    fangyu.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    [fangyu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuzhongBg.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    slabel = [FViewCreateFactory createLabelWithName:@"--------------------------------------------------------------------------------------------------------------------------------------------------------" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    slabel.lineBreakMode = NSLineBreakByClipping;
    [bgView addSubview:slabel];
    [slabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fangyu.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@(SCREEN_WIDTH-30));
    }];
    
    yupiao = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:yupiao];
    yupiao.rightLabel.hidden = NO;
    yupiao.rightLabel.text = @"元/人";
    [yupiao.leftLabel setRedStarText:@"*鱼票"];
    yupiao.switchView.hidden = NO;
    yupiao.switchView.on = NO;
    yupiao.switchRLabel.hidden = NO;
    yupiao.enterTextField.keyboardType =  UIKeyboardTypeNumbersAndPunctuation;
    
    [yupiao.switchView addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    yupiao.enterTextField.placeholder=@"请填写鱼票金额";
    yupiao.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    [yupiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slabel.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    dingjin = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    dingjin.hidden = YES;
    [bgView addSubview:dingjin];
    dingjin.rightLabel.hidden = NO;
    dingjin.rightLabel.text = @"元/人";
    [dingjin.leftLabel setRedStarText:@"*定金"];
    dingjin.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    dingjin.enterTextField.placeholder=@"请填写定金金额";
    dingjin.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    [dingjin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yupiao.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    huigou = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:huigou];
    huigou.rightLabel.hidden = NO;
    huigou.rightLabel.text = @"元/斤";
    huigou.leftLabel.text = @" 回购";
    huigou.enterTextField.placeholder=@"请填写回购金额";
    huigou.enterTextField.keyboardType =  UIKeyboardTypeNumbersAndPunctuation;
    huigou.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    [huigou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dingjin.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    slabel = [FViewCreateFactory createLabelWithName:@"--------------------------------------------------------------------------------------------------------------------------------------------------------" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    slabel.lineBreakMode = NSLineBreakByClipping;
    [bgView addSubview:slabel];
    [slabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(huigou.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@(SCREEN_WIDTH-30));
    }];
    renshu = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:renshu];
    renshu.rightLabel.hidden = NO;
    renshu.rightLabel.text = @"人";
    [renshu.leftLabel setRedStarText:@"*人数"];
    renshu.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    renshu.enterTextField.placeholder=@"请填写人数上限";
    renshu.enterTextField.keyboardType =  UIKeyboardTypeNumberPad;
    [renshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slabel.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    renshuSlabel = [FViewCreateFactory createLabelWithName:@"不能大于钓场钓位总数：0个" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [bgView addSubview:renshuSlabel];
    [renshuSlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renshu.enterTextField.mas_left);
        make.top.equalTo(renshu.mas_bottom);
        make.height.equalTo(@21);
    }];
    slabel = [FViewCreateFactory createLabelWithName:@"--------------------------------------------------------------------------------------------------------------------------------------------------------" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    slabel.lineBreakMode = NSLineBreakByClipping;
    [bgView addSubview:slabel];
    [slabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(renshuSlabel.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@(SCREEN_WIDTH-30));
    }];
    UILabel* label = [FViewCreateFactory createLabelWithName:(@"鱼讯标题") font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slabel.mas_bottom).offset(15);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@21);
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    titleSaiShiActTextField = [FViewCreateFactory createTextFiledWithPlaceHolder:@"请输入标题（最多30个" delegate:self tag:0];
    [bgView addSubview:titleSaiShiActTextField];
    titleSaiShiActTextField.font = [UIFont systemFontOfSize:12];
    [titleSaiShiActTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(15);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@30);
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    titleSaiShiActTextField.layer.cornerRadius =5;
    titleSaiShiActTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    titleSaiShiActTextField.layer.borderWidth = 1;
    label = [FViewCreateFactory createLabelWithName:(@"鱼讯详情") font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:label];
    [label setRedStarText:@"*鱼讯详情"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleSaiShiActTextField.mas_bottom).offset(15);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@21);
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    jianJieGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:jianJieGreenTF];
    [jianJieGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.centerX.equalTo(bgView.mas_centerX);
        make.height.equalTo(@200);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    jianJieGreenTF.leftLabel.hidden = YES;
    jianJieGreenTF.enterTextField.hidden =YES;
    jianJieGreenTF.textView.hidden = NO;
    jianJieGreenTF.placeHolderLabel.text =@"请输入详细规则";
    jianJieGreenTF.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    jianJieGreenTF.textView.layer.borderWidth = 1;
    jianJieGreenTF.textView.layer.cornerRadius = 5;
    
    
    
    label = [FViewCreateFactory createLabelWithName:@"鱼汛封面" font:[UIFont systemFontOfSize:14] textColor:BLACKCOLOR];
    [bgView addSubview:label];
    [label setRedStarText:@"*鱼汛封面"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jianJieGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@50);
    }];
    
    UIButton *btnf=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnf setTitle:@"选择默认图片" forState:UIControlStateNormal];
    btnf.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnf setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnf addTarget:self action:@selector(chooseMoRenTuPian:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnf];
    [btnf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.height.equalTo(@50);
        make.left.equalTo(label.mas_right).offset(10);
    }];
    fengMianTuBtn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(fengmianClick:) tag:0];
    [fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
    fengMianTuBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    fengMianTuBtn.layer.borderWidth = 1;
    [bgView addSubview:fengMianTuBtn];
    [fengMianTuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@200);
        make.width.equalTo(@(SCREEN_WIDTH - 40));
    }];
    
    label = [FViewCreateFactory createLabelWithName:@"鱼讯图片" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:label];
    [label setRedStarText:@"鱼讯图片"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianTuBtn.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@21);
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    
    container = [[RemovableViewContainer alloc]initWithFrame:CGRectMake(40,CGRectGetMaxY(label.frame) , SCREEN_WIDTH-80, (SCREEN_WIDTH-80)/3.0) columCount:3];
    container.imageWidthAndHieight = (SCREEN_WIDTH-80)/3.0;
    container.OnAddClicked = ^(RemovableViewContainer *__weak  _Nonnull selfView){
        
    };
    UIView * av = [UIView new];
    [av addSubview:container];
    [bgView addSubview:av];
    
    UIView* lineView =  [UIView new];
    lineView.backgroundColor = WHITEGRAY;
    [bgView addSubview:lineView];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(av.mas_left);
        make.top.equalTo(av.mas_top);
        make.right.equalTo(av.mas_right);
        make.bottom.equalTo(av.mas_bottom);
        make.height.greaterThanOrEqualTo(@((SCREEN_WIDTH-80)/3.0));
    }];
    [av mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.width.equalTo(@(bgView.width-20));
        make.height.greaterThanOrEqualTo(@((SCREEN_WIDTH-80)/3.0));
        make.top.equalTo(label.mas_bottom);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(1));
        make.top.equalTo(av.mas_bottom).offset(10);
    }];
    
    
    
    label = [FViewCreateFactory createLabelWithName:(self.isSaiShi?(@"提交信息后耐心等待2~3个工作日，审核通过后会在赛事频道显示"):(@"提交信息后耐心等待2~3个工作日，审核通过后会在活动频道显示")) font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor]];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.width.equalTo(@(SCREEN_WIDTH - 40));
        make.height.equalTo(@50);
    }];
    
    lpxieYi = [ToolView btnTitle:@"发布鱼讯之前请勾选\"相关协议\"" image:@"nomorl" tag:0 superView:bgView sel:@selector(xieYiClick:) targer:self setStyle:LPButtonStyleLeft font:12];

    UIButton * xieYiSee =   [FViewCreateFactory createCustomButtonWithName:@"协议查看" delegate:self selector:@selector(pushXieYiClick:) tag:0];
    [xieYiSee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xieYiSee.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [bgView addSubview:lpxieYi];
    [bgView addSubview:xieYiSee];
    
    [lpxieYi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.right.equalTo(xieYiSee.mas_left).offset(5);
        make.width.greaterThanOrEqualTo(@200);
        make.height.equalTo(@30);
    }];
    
    [xieYiSee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lpxieYi.mas_right).offset(5);

        make.centerY.equalTo(lpxieYi.mas_centerY);
        make.width.equalTo(@75);
//        make.right.greaterThanOrEqualTo(0);
           make.height.equalTo(@30);
       }];
    
    
    UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"确定发布" delegate:self selector:@selector(tijiao:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lpxieYi.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(40));
        make.bottom.equalTo(bgView.mas_bottom).offset(-20);
    }];
    btn.layer.cornerRadius = 5;
    
    
}
-(void)pushXieYiClick:(id) sender{
    H5ArticalDetailViewController *h5VC = [[H5ArticalDetailViewController alloc] init];
    h5VC.url = CooperateAgreement;
//    [self.navigationController pushViewController:[[XieYiViewController alloc] init] animated:YES];
    [self.navigationController pushViewController:h5VC
                                         animated:YES];

}
-(void)xieYiClick:(LPButton *)btn
{
    if(btn.isSelected == NO)
    {
        [btn setImage:[UIImage imageNamed: @"select"] forState:UIControlStateNormal];
        btn.isSelected = YES;
    }else{
        [btn setImage:[UIImage imageNamed:@"nomorl"] forState:UIControlStateNormal];
        btn.isSelected = NO;
    }
}
-(void)tijiao:(UIButton *)btn
{
    [self upLoadData];
}
-(void)addNoRenZhengView
{
    __weak __typeof(self) weakSelf = self;
    noRenZhengView = [[[NSBundle mainBundle]loadNibNamed:@"QuRenZhengView" owner:self options:nil]firstObject];
    [self.view addSubview:noRenZhengView];
    [noRenZhengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hkNavigationView.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [noRenZhengView.renZhenButton addTarget:self action:@selector(renzhengClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)renzhengClick:(UIButton *)btn
{
    DiaoChangZhuRenZhengViewController *vc =[[DiaoChangZhuRenZhengViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)fengmianClick:(MySelButton *)btn
{
    if (btn.isChoosed == YES)
    {
        return;
    }
    JJImagePicker *picker = [ToolView selectImageFromAlbum];
    [picker actionSheetWithTakePhotoTitle:@"" albumTitle:@"从相册选择一张图片" cancelTitle:@"取消" InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
        [[ApiFetch share]upload:image success:^(NSString *msg) {
            [self hideHud];
            btn.isChoosed = YES;
            btn.str=msg;
            [btn setImage:image forState:UIControlStateNormal];
            //添加删除按钮
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self->fengMianTuBtn.frame)-10, CGRectGetMinY(self->fengMianTuBtn.frame)-10, 20, 20)];
            imageView.image = [UIImage imageNamed:@"delete.png"];
            [self->bgView addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
                UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
                [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
                [t.view removeFromSuperview];
                self->fengMianTuBtn.isChoosed = NO;
                self->fengMianTuBtn.str = @"";
            }];
            [imageView addGestureRecognizer:tap];
        } failure:^{
            [self hideHud];
        }];
    }];
}
- (void)photosViewController:(UIViewController *)viewController thumbnailImages:(NSArray<UIImage *> *)thumbnailImages infos:(NSArray<NSDictionary *> *)infos
{
    for (UIImage * thumbnailImage in thumbnailImages) {
        
        fengMianTuBtn.imageView.image = thumbnailImage;
        [fengMianTuBtn setImage:thumbnailImage forState:UIControlStateNormal];
    }
    
    //添加删除按钮
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-15, CGRectGetMinY(fengMianTuBtn.frame)-15, 30, 30)];
    imageView.image = [UIImage imageNamed:@"delete.png"];
    [bgView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
        [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
        [t.view removeFromSuperview];
    }];
    [imageView addGestureRecognizer:tap];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    // text field 上实际字符长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    return (strLength <= 30);
}




#pragma mark - 数据提交

-(void)upLoadData
{
    if(lpxieYi.isSelected == NO)
    {
        [self showDefaultInfo:@"请先勾选相关协议"];
        return;
    }
    NSMutableDictionary *dictR = [[NSMutableDictionary alloc]init];
    if(spotType==0)
    {
        [self showDefaultInfo:@"请先选择类型"];
        return;
    }
    [dictR setValue:@(spotType) forKey:@"spotType"];
    if(playType==0)
    {
        [self showDefaultInfo:@"请先选择玩法"];
        return;
    }
    [dictR setValue:@(playType) forKey:@"playType"];
    if((tab==nil)||(tab.length==0))
    {
            [self showDefaultInfo:@"请先选择方式"];
            return;
    }
    [dictR setValue:tab forKey:@"tab"];
    if(pattern==0)
    {
        [self showDefaultInfo:@"请先选择模式"];
        return;
    }
    [dictR setValue:@(pattern) forKey:@"pattern"];
    
    if([MonthOpeartion defaultMonthOpeartion].selectedDays.count==0)
    {
        [self showDefaultInfo:@"请先选择赛事活动日期"];
        return;
    }

    NSMutableArray *dayStrArr = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i=0;i<[MonthOpeartion defaultMonthOpeartion].selectedDays.count;i++)
    {
        DayModel *dayModel = [[MonthOpeartion defaultMonthOpeartion].selectedDays objectAtIndex:i];
        NSString *dateS = [NSString stringWithFormat:@"%ld-%ld-%ld",dayModel.year,dayModel.month,dayModel.day];
        [dayStrArr addObject:dateS];
    }
    NSString *dateStr = [dayStrArr componentsJoinedByString:@","];
    [dictR setValue:dateStr forKey:@"dateStr"];
    [dictR setValue:@(saiShiriqi.switchView.on) forKey:@"overDay"];    if((kaishishijian.enterTextField.text==nil)||(kaishishijian.enterTextField.text.length==0))
    {
        [self showDefaultInfo:@"请先选择赛事活动开始时间"];
        return;
    }
    [dictR setValue:kaishishijian.enterTextField.text forKey:@"startTimeStr"];
    if((jieshushijian.enterTextField.text==nil)||(jieshushijian.enterTextField.text.length==0))
    {
        [self showDefaultInfo:@"请先选择赛事活动结束时间"];
        return;
    }
    [dictR setValue:jieshushijian.enterTextField.text forKey:@"finishTimeStr"];
    if((playType==1)||(playType==3))
    {
        [dictR setValue:yaohaoshijian.enterTextField.text forKey:@"lotTimeStr"];
    }
    if(endTimeInt==0)
    {
        [self showDefaultInfo:@"请先选择报名截止"];
        return;
    }
    [dictR setValue:@(endTimeInt) forKey:@"endTimeInt"];
    if(self.selectSpotPond==nil)
    {
        [self showDefaultInfo:@"请先选择钓坑"];
        return;
    }
    [dictR setValue:self.selectSpotPond.id forKey:@"fishpondId"];
    if(yuzhongS.selectedMarkArray.count==0)
    {
        [self showDefaultInfo:@"请先选择鱼种"];
        return;
    }
    NSArray *fishesY = [self.eventGetTypes.fishes componentsSeparatedByString:@","];
    NSMutableArray *selectFishArr = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i=0;i<yuzhongS.selectedMarkArray.count;i++)
    {
        NSString *indexS = [yuzhongS.selectedMarkArray objectAtIndex:i];
        [selectFishArr addObject:[fishesY objectAtIndex:[indexS intValue] ]];
    }
    [dictR setValue:[selectFishArr componentsJoinedByString:@","]  forKey:@"fishes"];
    NSLog(@"tab = %@",tab);
    if((fangyu.enterTextField.text==nil)||(fangyu.enterTextField.text.length==0))
    {
        if([tab isEqualToString:@"normal"]||[tab isEqualToString:@"positive"])
        {
            [self showDefaultInfo:@"请先输入放鱼量"];
            return;
        }else{
            
        }
    }
    [dictR setValue:fangyu.enterTextField.text  forKey:@"fishNum"];
    if((yupiao.enterTextField.text==nil)||(yupiao.enterTextField.text.length==0))
    {
        [self showDefaultInfo:@"请先输入鱼票金额"];
        return;
    }
    [dictR setValue:yupiao.enterTextField.text  forKey:@"money"];
    
    [dictR setValue:@((yupiao.switchView.on)?1:2) forKey:@"prepay"];
    if(yupiao.switchView.on)
    {
        if((dingjin.enterTextField.text==nil)||(dingjin.enterTextField.text.length==0))
        {
            [self showDefaultInfo:@"请先输入定金金额"];
            return;
        }
        [dictR setValue:dingjin.enterTextField.text forKey:@"prepayMoney"];
    }
    
    [dictR setValue:huigou.enterTextField.text forKey:@"repurchase"];
    
    int peopleNumber = [renshu.enterTextField.text intValue];
    if(peopleNumber==0)
    {
        [self showDefaultInfo:@"请先输入人数"];
        return;
    }else if(peopleNumber>self.selectSpotPond.spotCount)
    {
        [self showDefaultInfo:@"人数不能超过钓位数"];
        return;
    }
    [dictR setValue:@(peopleNumber) forKey:@"peopleNumber"];
    [dictR setValue:jianJieGreenTF.textView.text forKey:@"content"];
    [dictR setValue:titleSaiShiActTextField.text forKey:@"name"];
    [dictR setValue:fengMianTuBtn.str forKey:@"coverImage"];
    NSString *postersStr = @"";
    for(int i =0;i< container.imageUrls.count;i++)
    {
        if(postersStr.length ==0)
        {
            postersStr = [container.imageUrls objectAtIndex:i];
            continue;
        }
        postersStr = [NSString stringWithFormat:@"%@,%@",postersStr,[container.imageUrls objectAtIndex:i]];
    }
    [dictR setValue:postersStr forKey:@"posters"];
    [dictR setValue:@((self.isSaiShi+1)) forKey:@"type"];
    NSLog(@"dictR = %@",dictR);
    [[ApiFetch share]eventPostFetch:EVENT_ADD_INFO body:dictR holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self hideHud];
        [self addAlert];
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
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发布成功,等待审核" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //弹出请输入正确的手机号
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
-(NSString *)sub20Mins:(NSString *) timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    date =    [date dateByAddingTimeInterval:- 20*60];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

-(void)moshiclick:(LPButton *)btn
{
    int index = btn.tag -100;
    if(self.isSaiShi)
    {
        if(index==0)
        {
            self->pattern = 1;
        }else{
            self->pattern = 2;
            
        }
    }else{
        if(index==0)
        {
            self->pattern = 3;
        }else{
            self->pattern = 4;
            
        }
    }
    LPButton *lp = [moshiArr objectAtIndex:( 1-index)];
    lp.isSelected = NO;
    
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
}
-(void)baomingjiezhiclick:(LPButton *)btn
{
    int index = btn.tag -200;
    LPButton *lp = [baomingjiezhiArr objectAtIndex:( 1-index)];
    lp.isSelected = NO;
    if(index == 0)
    {
        self->endTimeInt = 1;
    }else{
        self->endTimeInt = 2;
    }
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
}
-(void)shuomingclick:(LPButton*)btn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"选择积分模式，报名用户可获得积分奖励；选择普通模式，报名用户不会获得积分奖励" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
-(void)shuoMing:(UIButton*)btn
{
    HuoDongSaiShiShuoMingViewController*vc = [[HuoDongSaiShiShuoMingViewController alloc]init];
    vc.isSaiShi = self.isSaiShi;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)chooseMoRenTuPian:(UIButton*)btn
{
    if (fengMianTuBtn.isChoosed == YES) {
        return;
    }
    ChooseMoRenTuPianViewController*vc =[[ChooseMoRenTuPianViewController alloc]init];
    vc.moRenTuPianArr = [[NSMutableArray alloc]initWithArray:self.eventGetTypes.defaultImg];
    vc.selectBtnClick = ^(UIImage * image,NSString*msg) {
        self->fengMianTuBtn.isChoosed = YES;
        self->fengMianTuBtn.str=msg;
        btn.hidden = YES;
        [self->fengMianTuBtn sd_setImageWithURL:[NSURL URLWithString:msg] forState:UIControlStateNormal];
        //添加删除按钮
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self->fengMianTuBtn.frame)-10, CGRectGetMinY(self->fengMianTuBtn.frame)-10, 20, 20)];
        imageView.image = [UIImage imageNamed:@"delete.png"];
        [self->bgView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
            UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
            [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
            [t.view removeFromSuperview];
            self->fengMianTuBtn.isChoosed = NO;
            self->fengMianTuBtn.str = @"";
            btn.hidden = NO;
            
        }];
        [imageView addGestureRecognizer:tap];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)switchClick:(UISwitch*)st
{
    if(st.on)
    {
        self->dingjin.hidden = NO;
        [self->dingjin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
    }else{
        self->dingjin.hidden = YES;
        [self->dingjin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}
-(void)switchClickKuaiTian:(UISwitch*)st
{
    
}
@end
