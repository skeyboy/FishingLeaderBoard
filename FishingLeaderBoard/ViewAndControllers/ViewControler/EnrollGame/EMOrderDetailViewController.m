//
//  EMOrderDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "EMOrderDetailViewController.h"
#import "YuShareGameViewController.h"
#import "EventGameDetail.h"
@interface EMOrderDetailViewController ()

@end

@implementation EMOrderDetailViewController

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
    [self initModel];
    [self setNav];
    self.view.backgroundColor = WHITECOLOR;
    self.Jh_formTableView.backgroundColor = WHITECOLOR;
    self.Jh_formTableView.bounces = NO;
    self.Jh_formTableView.frame = CGRectMake(0, Height_NavBar, SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar-10);

}
-(void)setNav{
    __weak typeof(self) weakSelf = self;
    [self setFishNavTitle:(self.isOrder==0)?@"待支付订单":@"订单详情"];
//    self.Jh_navRightImage = @"share";
    self.Jh_navLeftImage = @"nav_back_nor";
//    self.JhClickNavRightItemBlock = ^{
////        //右侧分享点击事件
////        [self share];
//    };
    self.JhClickNavLeftItemBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

-(void)initModel{
    
    
    
    JhFormCellModel *cell_head = JhFormCellModel_AddCustumALLViewCell(HomeNewsBannerHeight);
    cell_head.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        //详情图片展示
        UIImageView *imageView =[FViewCreateFactory createImageViewWithFrame:CGRectMake(-15, 0, SCREEN_WIDTH, HomeNewsBannerHeight) imageName:@"page1"];
        IMAGE_LOAD(imageView, self.orderApplyGame.icon);
        [AllView addSubview:imageView];
        
    };
    
    
    JhFormCellModel *cell_title = JhFormCellModel_AddCustumALLViewCell(60);
    cell_title.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
       
        UILabel *titleLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 60) name:self.orderApplyGame.eventName font:[UIFont systemFontOfSize:17] textColor:BLACKCOLOR];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [AllView addSubview:titleLabel];
    };
    JhFormCellModel *cell_time = JhFormCellModel_Info(@"比赛时间", @"", JhFormCellTypeInput);
    
   cell_time.Jh_placeholder = [NSString stringWithFormat:@"%@",[ToolClass dateToString1:self.orderApplyGame.startDate]];
    JhFormCellModel *cell_money = JhFormCellModel_Info(@"报名费用", @"", JhFormCellTypeInput);
    cell_money.Jh_placeholder = [NSString stringWithFormat:@"%@元/人",self.orderApplyGame.price];
    JhFormCellModel *cell_count = JhFormCellModel_Info(@"放鱼量", @"", JhFormCellTypeInput);
    cell_count.Jh_placeholder = [NSString stringWithFormat:@"%ldh斤",self.orderApplyGame.fishNum];
    JhFormCellModel *cell_address = JhFormCellModel_AddInputCell(@"比赛地址", @"", NO, 0);
    cell_address.Jh_editable = NO;
    cell_address.Jh_placeholder =self.orderApplyGame.address;
    cell_address.Jh_intputCellRightViewWidth = 40;
    cell_address.Jh_defaultHeight=60;
    if(([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])||([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]))
    {
        UIImageView *btn = [FViewCreateFactory createImageViewWithImageName:@"navigate"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [self toLocation];
        }];
        [btn addGestureRecognizer:tap];
        cell_address.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView){
            [RightView  addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.left.mas_equalTo(0);
                make.bottom.mas_equalTo(-10);
                make.right.mas_equalTo(0);
            }];
        };
    }
    JhFormCellModel *cell_allM = JhFormCellModel_AddInputCell((self.isOrder==0)?@"待付金额":@"实付金额", @"", NO, 0);
    cell_allM.Jh_placeholder = @"";
    cell_allM.Jh_editable = NO;
    cell_allM.Jh_intputCellRightViewWidth = 150;
    cell_allM.Jh_defaultHeight = 60;
    cell_allM.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentRight;
        label.text =[NSString stringWithFormat:@"%@元",self.orderApplyGame.tranAmount];
        label.textColor = [UIColor orangeColor];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.frame=CGRectMake(0, 0, 150, 45);
        [RightView addSubview:label];
    };
    
    ShowOrderNumberView *showOrderNumberView = [[ShowOrderNumberView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,(self.isOrder == 0)?235:381)];
    [showOrderNumberView isOrder:self.isOrder order:self.orderApplyGame vc:self fvc:self.vc type:self.intoPageType];
    JhFormCellModel *cell_bottom = JhFormCellModel_AddCustumALLViewCell((self.isOrder == 0)?235:381);
    cell_bottom.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        [AllView addSubview:showOrderNumberView];
        [showOrderNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(AllView.mas_left).offset(-15);
            make.right.equalTo(AllView.mas_right).offset(15);
            make.top.equalTo(AllView.mas_top);
            make.bottom.equalTo(AllView.mas_bottom);
        }];
    };
    
    
    
    JhFormSectionModel *section =JhSectionModel_Add(@[
        cell_head,
        cell_title,
        cell_time,
        cell_money,
        cell_count,
        cell_address,
        cell_allM,
        cell_bottom
    ]);
    
    
    [self.Jh_formModelArr addObjectsFromArray:@[section]];
    self.Jh_hiddenDefaultFooterView = YES;
}
-(void)toLocation
{
    @weakify(self)
    UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"App导航" message:@"" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
     UIAlertAction * baiduApp = [UIAlertAction actionWithTitle:@"百度导航" style:0 handler:^(UIAlertAction * _Nonnull action) {
         [ToolClass openBaiduMapAppTo:weak_self.orderApplyGame.lat
                                  lng:weak_self.orderApplyGame.lng
                         withSpotName:weak_self.orderApplyGame.eventName
                               result:^(BOOL success) {
             if (!success) {
                 [self showDefaultInfo:@"打开百度导航失败，请检查是否安装了App"];
             }
         }];
     }];
     UIAlertAction * gaodeApp = [UIAlertAction actionWithTitle:@"高德导航" style:0 handler:^(UIAlertAction * _Nonnull action) {
         [ToolClass openGaodeMapAppTo:weak_self.orderApplyGame.lat
                                          lng:weak_self.orderApplyGame.lng
                         withSpotName:weak_self.orderApplyGame.eventName
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
//分享
-(void)share
{
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    YuShareGameViewController *posterShareVC = [[YuShareGameViewController alloc] init];
    EventGameDetail *detail = [[EventGameDetail alloc]init];
    detail.coverImage = self.orderApplyGame.icon;
    detail.startTime = self.orderApplyGame.startDate;
    detail.endTime = self.orderApplyGame.endDate;
    detail.address = self.orderApplyGame.address;
    detail.name = self.orderApplyGame.eventName;
    detail.phone = self.orderApplyGame.phone;
    posterShareVC.eventGameDetail = detail;
    posterShareVC.isOrder = YES;
    [self presentViewController:posterShareVC
                       animated:YES
                     completion:^{

    }];
}
@end
