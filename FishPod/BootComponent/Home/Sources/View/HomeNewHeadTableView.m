//
//  HomeNewHeadTableView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import "HomeNewHeadTableView.h"
#import "FImagePageViewCellCollectionViewCell.h"
#import "EventCurrency.h"
#import "AppManager.h"
#import "UserInfo.h"
#import "FConstont.h"
#import <SDWebImage/SDWebImage.h>
#import "ApiFetch+Event.h"
#import "UIViewController+ShowHud.h"
#import "ToolView.h"
#import "Masonry.h"
#import "JLRoutes.h"
//#import "MaiYuViewController.h"
//#import "FindDiaoChangViewController.h"
@interface HomeNewHeadTableView()

@property(nonatomic) __block EventCurrency * currency;
@end
@implementation HomeNewHeadTableView
-(IBAction)moreBtnClick:(UIButton *)btn
{
    //FindDiaoChangViewController
    [[JLRoutes globalRoutes] routeURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"/find/more/spot"]] withParameters:@{
        
    }];
    
//        UIViewController*vc =[[NSClassFromString(@"FindDiaoChangViewController") alloc]init];
//           vc.hidesBottomBarWhenPushed = YES;
//           [self.viewController.navigationController pushViewController:vc animated:YES];
    }
-(void)refresh{
    UserInfo *userInfo    = [AppManager manager].userInfo ;

    if (userInfo) {
        @weakify(self)
        IMAGE_LOAD(self.avatarView, userInfo.headImg)
        self.userNameView.text = userInfo.nickName;
        [[ApiFetch share] eventGetFetch:EVENT_CURRENCY_REFRESH
                                  query:@{}
                                 holder:nil dataModel:EventCurrency.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
             weak_self.currency = (EventCurrency * )modelValue;
            self.jifenView.text= [NSString stringWithFormat:@"现有积分：%.1f分",weak_self.currency.currency];
            switch (weak_self.currency.userLevel) {
                case 0:
                    case 1:
                    self.cupView.image = nil;

                    break;
                case 2:
                    self.cupView.image = [UIImage imageNamed:@"baiyin_member"];

                    break;
                    case 4:
                                  self.cupView.image = [UIImage imageNamed:@"baijin_member"];

                                  break;
                case 3:
                    self.cupView.image = [UIImage imageNamed:@"huangjin_member"];
                    break;
                default:
                    break;
            }
        }];
        
    }else{
        self.userNameView.text = @"钓鱼排行榜";
        self.cupView.image = nil;
        self.avatarView.image = [UIImage imageNamed:@"user_my"];
        self.jifenView.text= [NSString stringWithFormat:@"现有积分：0分"];

    }
}

//首页不跳转会员积分
- (IBAction)showLogin:(id)sender {
    
    if (![AppManager manager].userInfo) {
       
        [self.viewController makeToask:@"请先登录"];
        return;
    }
    self.viewController.tabBarController.selectedIndex = 3;
    return;
    //TODO 跳转H5
//    H5ArticalDetailViewController *h5VC =[[H5ArticalDetailViewController alloc] init];
//    h5VC.hidesBottomBarWhenPushed = YES;
//    h5VC.url = RewardScore;
//    [self.viewController.navigationController pushViewController:h5VC
//                                                        animated:YES];
}
-(void)addButton
{
    LPButton *btn1 =[ToolView btnTitle:@"赛事报名" image:@"saishi_baoming" tag:0 superView:self.grvidView sel:@selector(tapBaoMingClick:) targer:self setStyle:LPButtonStyleTop font:15];
    UIButton *btn2 =[ToolView btnTitle:@"积分商城" image:@"jifen_shangcheng" tag:0 superView:self.grvidView sel:@selector(tapJiFenSCClick:) targer:self setStyle:LPButtonStyleTop font:15];
    UIButton *btn3 =[ToolView btnTitle:@"我要卖鱼" image:@"woyao_maiyu" tag:0 superView:self.grvidView sel:@selector(tapMaiYuClick:) targer:self setStyle:LPButtonStyleTop font:15];
    UIButton *btn4 =[ToolView btnTitle:@"品牌赛事" image:@"pinpai_saishi" tag:0 superView:self.grvidView sel:@selector(tapPinPaiSaiShiClick:) targer:self setStyle:LPButtonStyleTop font:15];
    
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3,btn4]];
    float length = (SCREEN_WIDTH -20)/4.0;
    if(length<100)
    {
        length =100;
    }
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:length leadSpacing:0 tailSpacing:0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.grvidView.mas_top).offset(0);
        make.height.equalTo(@120);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self addButton];
    self.bgWearthView.backgroundColor = NAVBGCOLOR;
    self.saiShiBaoMingImageView.layer.cornerRadius = 5;
    self.jiFenShangChengImageView.layer.cornerRadius = 5;
    self.pinPaiSaiShiImageView.layer.cornerRadius = 5;
    self.woYaoMaiYuImageView.layer.cornerRadius = 5;
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBaoMingClick:)];
    [self.saiShiBaoMingImageView addGestureRecognizer:tap];
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapJiFenSCClick:)];
    [self.jiFenShangChengImageView addGestureRecognizer:tap];
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPinPaiSaiShiClick:)];
    [self.pinPaiSaiShiImageView addGestureRecognizer:tap];
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaiYuClick:)];
    [self.woYaoMaiYuImageView addGestureRecognizer:tap];
    
}
-(void)tapBaoMingClick:(UITapGestureRecognizer *)tap
{
       UIViewController *vc =[[NSClassFromString(@"SaiShiAndHuoDongTableViewController") alloc]init];
       vc.hidesBottomBarWhenPushed = YES;
       [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(void)tapJiFenSCClick:(UITapGestureRecognizer *)tap
{
    if(![[AppManager manager]userHasLogin])
    {
        [self.viewController showDefaultInfo:@"请先登录"];
        return;
    }
    [self.viewController showDefaultInfo:@"暂未开通，敬请期待"];
    UIViewController*vc =[[NSClassFromString(@"IntegralMallViewController") alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
 
}
-(void)tapPinPaiSaiShiClick:(UITapGestureRecognizer *)tap
{
    UIViewController*vc = [[NSClassFromString(@"PinPaiViewController") alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(void)tapMaiYuClick:(UITapGestureRecognizer *)tap
{
    if(![[AppManager manager]userHasLogin])
    {
        [self.viewController showDefaultInfo:@"请先登录"];
        return;
    }
    //MaiYuViewController
    UIViewController *maiYuVc = [[NSClassFromString(@"MaiYuViewController") alloc] init];
    maiYuVc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:maiYuVc
                                           animated:YES];
}
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.segmentCtrlClick((int)startIndex, (int)endIndex);
    
}

@end

@implementation HomeNewUserContainerView

- (void)drawRect:(CGRect)rect{
     CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);//标记

    UIColor * fillColor = [UIColor whiteColor];
//    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextMoveToPoint(ctx,SCREEN_WIDTH, 40);
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, CGRectGetHeight(self.frame));
    CGContextAddLineToPoint(ctx, 0, CGRectGetHeight(self.frame));

    CGContextAddLineToPoint(ctx, 0, CGRectGetHeight(self.frame)*3/5);
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, 40);
    CGContextClosePath(ctx);//路径结束标志，不写默认封闭

    [fillColor setFill];
    [fillColor setStroke];
    CGContextDrawPath(ctx, kCGPathFillStroke);//绘制路径path

 


 }

@end
