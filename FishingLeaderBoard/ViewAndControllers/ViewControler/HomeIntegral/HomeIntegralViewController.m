//
//  HomeIntegralViewController.m
//  WKDemo
//
//  Created by 李雨龙 on 2020/4/6.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import "HomeIntegralViewController.h"
#import "ToolView.h"
#import "LPButton.h"
#import "EventHotCell.h"
#import "SaiShiListTableViewCell.h"
#import "FGoodsDetailViewController.h"
#import "UserCarLevel.h"
#import "EnrollGameNewViewController.h"
@interface HomeIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *grvidView;
// 人们兑换
@property (weak, nonatomic) IBOutlet UIButton *hotDuiHuanBtn;
//  获取积分
@property (weak, nonatomic) IBOutlet UIButton *gotScoreBtn;
@property(assign, nonatomic) NSInteger currentSelected;




@property(strong,nonatomic)NSMutableArray *eventGames;
@property(strong,nonatomic)NSMutableArray *eventHots;


@property(strong, nonatomic) UserCarLevel *userCardLevel;
@property (weak, nonatomic) IBOutlet HomeIntegralCirCleView *circleIndicatorVIew;

//赛事消费
@property (weak, nonatomic) IBOutlet UILabel *gameCostView;
@property (weak, nonatomic) IBOutlet UILabel *gameCoastProgress;
@property (weak, nonatomic) IBOutlet UILabel *gameCoastNeedCostView;


//赛事报名
@property (weak, nonatomic) IBOutlet UILabel *gameCountView;
@property (weak, nonatomic) IBOutlet UILabel *gameCountProgress;
@property (weak, nonatomic) IBOutlet UILabel *gameCountNeedView;


@property (weak, nonatomic) IBOutlet UILabel *activeCostView;
@property (weak, nonatomic) IBOutlet UILabel *activeCostProgress;
@property (weak, nonatomic) IBOutlet UILabel *activeCostNeedView;
@property (weak, nonatomic) IBOutlet UILabel *serviceEndTimeView;

@property (weak, nonatomic) IBOutlet UILabel *userNextLevel;
@property (weak, nonatomic) IBOutlet UILabel *currencyView;
@property (weak, nonatomic) IBOutlet UILabel *userNameView;

@end

@implementation HomeIntegralViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[ApiFetch share] eventGetFetch:EVENT_CARD_LEVEL
                              query:@{}
                             holder:nil
                          dataModel:UserCarLevel.class
                          onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        self.userCardLevel = modelValue;
        [self bindUserCarInfo];
    }];
}
-(void)bindUserCarInfo{
    self.userNameView.text = self.userCardLevel.userName;
    self.currencyView.text = [NSString stringWithFormat:@"现有积分:%lu分",self.userCardLevel.currency];
    
    self.serviceEndTimeView.text =[NSString stringWithFormat:@"会员有效期:%@", [ToolClass dateToString1:self.userCardLevel.serviceEndTime]];
    
    int progress = 0;
    NSUInteger sub = 0;
    
    //赛事消费
    self.gameCostView.text = [NSString stringWithFormat:@"%lu元/%lu元",self.userCardLevel.gamePrice,self.userCardLevel.gameGoalPrice];
  
        progress =(int)((self.userCardLevel.gamePrice*100)/self.userCardLevel.gameGoalPrice );
        self.gameCoastProgress.text = [NSString stringWithFormat:@"%d%%",progress];
        self.circleIndicatorVIew.gameUse = progress;
    
    sub = self.userCardLevel.gameGoalPrice -self.userCardLevel.gamePrice;
    self.gameCoastNeedCostView.text = @(sub).description;
    
    //赛事报名次数
    self.gameCountView.text = [NSString stringWithFormat:@"%lu次/%lu次",self.userCardLevel.gameCount,self.userCardLevel.gameGoalCount];
    
        progress = (int)((self.userCardLevel.gameCount*100)/self.userCardLevel.gameGoalCount);
        self.circleIndicatorVIew.gameRank  = progress;
        self.gameCountProgress.text = [NSString stringWithFormat:@"%d%%",progress];
    sub = self.userCardLevel.gameGoalCount -self.userCardLevel.gameCount;
    self.gameCountNeedView.text = @(sub).description;
    
    //活动费用
    
    
    self.activeCostView.text = [NSString stringWithFormat:@"%ld元/%ld元",self.userCardLevel.activityPrice,self.userCardLevel.activityGoalPrice];
    
           progress = (int)((self.userCardLevel.activityPrice*100)/self.userCardLevel.activityGoalPrice)
    ;
           self.circleIndicatorVIew.activeUse = progress;
           self.activeCostProgress.text = [NSString stringWithFormat:@"%d%%",progress];
       
    sub = self.userCardLevel.activityGoalPrice -self.userCardLevel.activityPrice;
    self.activeCostNeedView.text = @(sub).description;
//    1普通，2白银  3黄金   4白金
    NSString * nextLevel = @"白银会员";
    switch (self.userCardLevel.userLevel) {
        case 1:
            nextLevel = @"白银会员";
            break;
            case 2:
             nextLevel = @"黄金会员";
        break;
        case 3:
            nextLevel = @"白金会员";
        default:
            break;
    }
    self.userNextLevel.text = nextLevel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.eventGames = [NSMutableArray arrayWithCapacity:0];
    self.eventHots = [NSMutableArray arrayWithCapacity:0];

    
    self.myTableView.delegate = self;
    self.myTableView.dataSource  = self;
    self.myTableView.estimatedRowHeight = UITableViewAutomaticDimension;

    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"SaiShiListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SaiShiListTableViewCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"EventHotCell" bundle:nil] forCellReuseIdentifier:@"EventHotCell"];
    
    [self changeContent:self.hotDuiHuanBtn];
    self.myTableView.contentInsetAdjustmentBehavior = NO;
    [self addButton];
     
}

-(void)addButton
{
    LPButton * btn1 =[ToolView btnTitle:@"积分商城" image:@"home_jifen_shangcheng" tag:0 superView:self.grvidView sel:@selector(jiFenShangChengClick:) targer:self setStyle:LPButtonStyleTop font:15];
     LPButton *    btn2 =[ToolView btnTitle:@"积分账单" image:@"home_jifen_zhangdan" tag:0 superView:self.grvidView sel:@selector(jifenBillClick:) targer:self setStyle:LPButtonStyleTop font:15];
      LPButton *   btn3 =[ToolView btnTitle:@"积分赛事" image:@"home_jifen_saishi" tag:0 superView:self.grvidView sel:@selector(jifenSaiShiClick:) targer:self setStyle:LPButtonStyleTop font:15];
      
    
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3]];
    float length = (SCREEN_WIDTH -30)/4.0;
    if(length<100)
    {
        length =100;
    }
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:0 tailSpacing:0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.grvidView.mas_top).offset(10);
        make.height.equalTo(@80);
    }];
   
    btn1 =[ToolView btnTitle:@"会员手册" image:@"hmoe_jifen_huiyuanshouce" tag:0 superView:self.grvidView sel:@selector(huiYuanShouCeClick:) targer:self setStyle:LPButtonStyleTop font:15];
          btn2 =[ToolView btnTitle:@"积分抽奖" image:@"home_jifen_choujiang" tag:0 superView:self.grvidView sel:@selector(jifenChouJiangClick:) targer:self setStyle:LPButtonStyleTop font:15];
           btn3 =[ToolView btnTitle:@"钓技课堂" image:@"home_jifen_diaojiketang" tag:0 superView:self.grvidView sel:@selector(diaoJiKeTangClick:) targer:self setStyle:LPButtonStyleTop font:15];
         
    
    [btnArr removeAllObjects];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3]];
    
    length = (SCREEN_WIDTH -30)/4.0;
    if(length<100)
    {
        length =100;
    }
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:0 tailSpacing:0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.grvidView.mas_top).offset(90);
        make.height.equalTo(@80);
        
    }];
}
-(void)jiFenShangChengClick:(id) sender{
    IntegralMallViewController * mallVC = [[IntegralMallViewController alloc] init];
    mallVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mallVC
                                         animated:YES];
    
}
-(void)jifenBillClick:(id) sender{
    H5ArticalDetailViewController *h5V = [[H5ArticalDetailViewController alloc] init];
    h5V.url = ScoreLog;
    h5V.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:h5V
                                         animated:YES];
    
}
-(void)jifenSaiShiClick:(id) sender{
    [self makeToask:@"敬请期待"];
}
-(IBAction)huiYuanShouCeClick:(id)sender{
    H5ArticalDetailViewController *h5V = [[H5ArticalDetailViewController alloc] init];
       h5V.url = ScoreRule;
       h5V.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:h5V
                                            animated:YES];
    
}
-(void)jifenChouJiangClick:(id) sender{
    [self makeToask:@"敬请期待"];
}
-(void)diaoJiKeTangClick:(id) sender{
//    H5ArticalDetailViewController *h5V = [[H5ArticalDetailViewController alloc] init];
    
   H5ArticalDetailViewController *h5V =  [[H5ArticalDetailViewController alloc] init];
       h5V.url = FISH_ClassRoom;
       h5V.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:h5V
                                            animated:YES];
}
- (IBAction)changeContent:(UIButton *)sender {
    
        UIColor *  normalColor= [UIColor lightGrayColor];
        UIColor *  selectedColor = [UIColor darkTextColor];
        [sender setTitleColor:selectedColor forState:UIControlStateNormal];
        
    Class cla = GoodsListsItem.class;

        if ( sender == self.hotDuiHuanBtn) {
            self.currentSelected = 1;
            //热门兑换
            [self.gotScoreBtn setTitleColor:normalColor forState:UIControlStateNormal];
            
            [[ApiFetch share] eventGetFetch:EVENT_RECOMMEND
                                        query:@{@"itemType":@(self.currentSelected)} holder:nil
                                  dataModel:GoodsListsItem.class
                                    onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                [self.eventHots removeAllObjects];
                [self.eventHots addObjectsFromArray:modelValue];
                [self.myTableView reloadData];
              }];
        } else {
            //获取积分
            [self.hotDuiHuanBtn setTitleColor:normalColor forState:UIControlStateNormal];
            self.currentSelected = 2;
            [[ApiFetch share] eventGetFetch:EVENT_RECOMMEND
                                        query:@{@"itemType":@(self.currentSelected)} holder:nil
                                  dataModel:EventSpotGameItem.class
                                    onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
                [self.eventGames removeAllObjects];
                [self.eventGames addObjectsFromArray:modelValue];
                [self.myTableView reloadData];
              }];
            
        }
    
  
   
}

-(IBAction)seeMore:(id)sender{
    if (self.currentSelected == 1) {
        //积分商城
        IntegralMallViewController * mallVc = [[IntegralMallViewController alloc] init];
        mallVc.hidesBottomBarWhenPushed  = YES;
        
        [self.navigationController pushViewController:mallVc
                                             animated:YES];
        
    }else{
        SaiShiAndHuoDongTableViewController * saishiHuoDong = [[SaiShiAndHuoDongTableViewController alloc] init];
        saishiHuoDong.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:saishiHuoDong
                                             animated:YES];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentSelected == 2) {
        return self.eventGames.count;
    } else {
        return self.eventHots.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentSelected == 1) {//人们兑换
        EventHotCell * aCell = [tableView dequeueReusableCellWithIdentifier:@"EventHotCell" forIndexPath:indexPath];
        GoodsListsItem * item = self.eventHots[indexPath.row];
        [aCell bindValue:item];
         return aCell;
    }else{
        SaiShiListTableViewCell *gameCell = [tableView dequeueReusableCellWithIdentifier:@"SaiShiListTableViewCell" forIndexPath:indexPath];

               EventSpotGameItem * item = self.eventGames[indexPath.row];
               [gameCell bindValue:item];
        return gameCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentSelected == 2) {
       EnrollGameNewViewController *vc =[[EnrollGameNewViewController alloc]init];
        EventSpotGameItem*item = [self.eventGames objectAtIndex:indexPath.row];
        vc.eventId = item.id;
        vc.isAct = NO;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        GoodsListsItem * item = self.eventHots[indexPath.row];

        FGoodsDetailViewController * detailVC  = [[FGoodsDetailViewController alloc] init];
        detailVC.goodsId = item.id;
        detailVC.hidesBottomBarWhenPushed = YES;
              [self.navigationController pushViewController:detailVC animated:YES];
              
    }
}
@end
@interface HomeIntegralCirCleView()

@end

@implementation HomeIntegralCirCleView
-(void)awakeFromNib{
    [super awakeFromNib];
    for (NSString *keyPath in @[@"gameUse",@"gameUseColor"
                              ,@"gameRank",@"gameRankColor"
                                ,@"activeUse",@"activeUseColor"
                                ,@"angleDefaultColor"
                              ]) {
        
    [self addObserver:self
           forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self setNeedsDisplay];
}
-(void)setGameUse:(CGFloat)gameUse{
    _gameUse = gameUse;
    [self setNeedsFocusUpdate];
}

- (void)drawRect:(CGRect)rect{
    
    CGFloat radius = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))/2;
    
    [self drawArc:UIGraphicsGetCurrentContext() radius:radius*0.4 endAngle:self.activeUse withColor:self.activeUseColor];
    [self drawArc:UIGraphicsGetCurrentContext() radius:radius*0.6 endAngle:self.gameRank withColor:self.gameRankColor];
    [self drawArc:UIGraphicsGetCurrentContext() radius:radius*0.8 endAngle:self.gameUse withColor:self.gameUseColor];


}
#pragma mark 绘制圆弧
- (void)drawArc:(CGContextRef)context radius:(CGFloat) radius endAngle:(CGFloat) endAngle withColor:(UIColor *) forgroundColor
{
    //1.获取上下文- 当前绘图的设备
//    CGContextRef *context = UIGraphicsGetCurrentContext();
    //设置路径
    /*
     CGContextRef c:上下文
     CGFloat x ：x，y圆弧所在圆的中心点坐标
     CGFloat y ：x，y圆弧所在圆的中心点坐标
     CGFloat radius ：所在圆的半径
     CGFloat startAngle ： 圆弧的开始的角度  单位是弧度  0对应的是最右侧的点；
     CGFloat endAngle  ： 圆弧的结束角度
     int clockwise ： 顺时针（0） 或者 逆时针(1)
     */
    UIColor *grayColor = [UIColor lightGrayColor];
    if (self.angleDefaultColor) {
        grayColor = self.angleDefaultColor;
    }

    CGContextSetStrokeColorWithColor(context, grayColor.CGColor);
    CGContextSetLineWidth(context, 5);
     CGFloat XY = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))/2;
    CGContextAddArc(context, XY, XY, radius, M_PI/4*3, (2*M_PI/4*3 -M_PI/4+ M_PI), 0);
    //绘制圆弧
    CGContextDrawPath(context, kCGPathStroke);
    
    
    CGContextSetStrokeColorWithColor(context, forgroundColor.CGColor);
       CGContextSetLineWidth(context, 5);
    CGContextAddArc(context, XY, XY, radius, M_PI/4*3, (M_PI*1.5)*(endAngle/100.0)+M_PI/4*3, 0);
       //绘制圆弧
       CGContextDrawPath(context, kCGPathStroke);
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];

    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];

    UIImage *shareImage= [UIImage imageNamed:icon];

    
    [shareImage drawInRect:CGRectMake(XY-10, XY-10, 20, 20)];
}
@end
