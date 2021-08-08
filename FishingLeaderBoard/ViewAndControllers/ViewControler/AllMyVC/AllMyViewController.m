//
//  AllMyViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AllMyViewController.h"
#import "MyAllHeadView.h"
#import "AllMyCenterView.h"
#import "MyAllBottomView.h"
#import "ChooseRenZhengViewController.h"
#import "ShiMingRenZhengViewController.h"
#import "GameRankSelectTableViewController.h"
#import "AboutUsViewController.h"
#import "MyOrderViewController.h"
#import "DiaoChangZhuRenZhengViewController.h"
#import "AddDiaoKengViewController.h"
#import "SaiShiJingLiViewController.h"
#import "FTabBarClass.h"
@interface AllMyViewController ()<ApiFetchOptionalHandler>

@end

@implementation AllMyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.Jh_formTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.Jh_formTableView.backgroundColor = WHITECOLOR;
    [self initViewModel];
    [self initPageData];
    self.Jh_formTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(frashData)];
       
}
-(void)frashData
{
    [self initPageData];

}
#pragma mark -获取数据
-(void)initPageData
{
    @weakify(self)
    [[ApiFetch share] userGetFetch:USER_GETMYPAGE
                               query:@{}
                              holder:self
                           dataModel:UserPageInfo.class
                           onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSSLog(@"modelValue = %@",modelValue);
        weak_self.userPageInfo = (UserPageInfo*)modelValue;
        [self initViewModel];
        [self hideHud];
        [self.Jh_formTableView.mj_header endRefreshing];
      }];
      
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self.Jh_formTableView.mj_header endRefreshing];
     [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
-(void)initViewModel
{
    [self.Jh_formModelArr removeAllObjects];
    //用户头像
    MyAllHeadView *headView = [[MyAllHeadView alloc]initWithFrame:CGRectMake(-15, 0, SCREEN_WIDTH, Height_StatusBar +110 + 70 )];
    JhFormCellModel *cell_head = JhFormCellModel_AddCustumALLViewCell(headView.height);
    cell_head.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        
        [AllView addSubview:headView];
        
    };
    //两行活动赛事金额显示部分
    AllMyCenterView *centerView = [[AllMyCenterView alloc]initWithFrame:CGRectMake(-15, 0, SCREEN_WIDTH, 0) typePage:FPageTypeDiaoChangZhu data:self.userPageInfo];
    JhFormCellModel *cell_center = JhFormCellModel_AddCustumALLViewCell(centerView.height);
    cell_center.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
        
        [AllView addSubview:centerView];
        
    };
    NSString *leftName = @"切换至代理人";
    JhFormCellModel *cell0 = nil;
    if([AppManager manager].barPageType ==FPageTypeDaiLiRenAndDiaochangZhu1)
    {
      leftName = @"切换至代理人";
    }else{
      leftName = @"切换至钓场主";
    }
    cell0 = JhFormCellModel_AddRightArrowCell(leftName, @"");
    cell0.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [FTabBarClass intoTabBarControll];
    };
    JhFormCellModel *cell1 = JhFormCellModel_AddRightArrowCell(@"协会赛事排名", @"");
    cell1.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self paiMping];
    };
    JhFormCellModel *cell2 = JhFormCellModel_AddRightArrowCell(@"我的订单", @"");
    cell2.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self toMyOrder];
    };
    
    JhFormCellModel *cell3 = JhFormCellModel_AddInputCell(@"实名认证", @"", NO, 0);
    cell3.Jh_editable = NO;
    cell3.Jh_placeholder = @"";
    cell3.Jh_intputCellRightViewWidth = 200;
    cell3.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
        [RightView removeAllSubviews];
        NSString *titleS=nil;
        NSString *imageS=nil;
       if( self.userPageInfo.sign==nil)
       {
           titleS =  @"兑换积分之前先进行积分认证";
           imageS = @"rightInto_b";
       }else{
           titleS =  @"已认证";
           imageS = @"close";

       }
        LPButton *rbtn = [ToolView btnTitle:titleS image:imageS tag:0 superView:RightView sel:@selector(toRenZheng) targer:self setStyle:LPButtonStyleRight font:12];
        rbtn.titleLabel.numberOfLines = 0;
        if( self.userPageInfo.sign==nil)
            {
                 [rbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }else{
                [rbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            }
        rbtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [rbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
        }];
    };
    cell3.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self toRenZheng];
    };
    
    JhFormCellModel *cell33 = JhFormCellModel_AddInputCell(@"钓场认证", @"", NO, 0);
    cell33.Jh_editable = NO;
    cell33.Jh_placeholder = @"";
    cell33.Jh_intputCellRightViewWidth = 200;
    cell33.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
        LPButton *rbtn = [ToolView btnTitle:@"" image:@"rightInto_b" tag:0 superView:RightView sel:@selector(toDiaoChangRenZheng) targer:self setStyle:LPButtonStyleRight font:12];
        rbtn.titleLabel.numberOfLines = 0;
        [rbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [rbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
        }];
    };

    cell33.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self toDiaoChangRenZheng];
    };
    JhFormCellModel *cell3333 = JhFormCellModel_AddRightArrowCell(@"赛事推广经理申请", @"");
    cell3333.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel){
        [self saiShiJingliShenQin];
    };
    JhFormCellModel *cell333 = JhFormCellModel_AddInputCell(@"设置钓坑", @"", NO, 0);
    cell333.Jh_editable = NO;
    cell333.Jh_placeholder = @"";
    cell333.Jh_intputCellRightViewWidth = 200;
    cell333.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
        LPButton *rbtn = [ToolView btnTitle:@"" image:@"rightInto_b" tag:0 superView:RightView sel:@selector(toSheZhiDiaoKeng) targer:self setStyle:LPButtonStyleRight font:12];
        rbtn.titleLabel.numberOfLines = 0;
        [rbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [rbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
        }];
    };

    cell333.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self toSheZhiDiaoKeng];
    };
    JhFormCellModel *cell7 = JhFormCellModel_AddRightArrowCell(@"收货地址管理", @"");
      cell7.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
          [self manageAddress];
      };
    JhFormCellModel *cell4 = JhFormCellModel_AddRightArrowCell(@"帮助中心", @"");
    cell4.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self helpCenter];
    };
    JhFormCellModel *cell5 = JhFormCellModel_AddInputCell(@"版本信息", @"", NO, 0);
    cell5.Jh_editable = NO;
    cell5.Jh_placeholder = @"";
    cell5.Jh_intputCellRightViewWidth = 100;
    //
    NSString*version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    cell5.Jh_intputCellRightViewBlock = ^(UIView * _Nonnull RightView) {
        LPButton *rbtn = [ToolView btnTitle:version image:@"close" tag:0 superView:RightView sel:@selector(version1Click:) targer:self setStyle:LPButtonStyleRight font:13];
        [rbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        rbtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [rbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
        }];
    };
    cell5.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        
    };
    JhFormCellModel *cell6 = JhFormCellModel_AddRightArrowCell(@"了解我们", @"");
    cell6.Jh_CellSelectCellBlock = ^(JhFormCellModel * _Nonnull cellModel) {
        [self aboutUS];
    };
    
    //底部退出
      MyAllBottomView *bottomView = [[MyAllBottomView alloc]initWithFrame:CGRectMake(-15, 0, SCREEN_WIDTH, 200)];
      JhFormCellModel *cell_bottom = JhFormCellModel_AddCustumALLViewCell(bottomView.height);
      cell_bottom.Jh_custumALLViewBlock = ^(UIView * _Nonnull AllView) {
          
          [AllView addSubview:bottomView];
          AllView.userInteractionEnabled = YES;
          [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(AllView.mas_left).offset(-15);
                   make.right.equalTo(AllView.mas_right).offset(15);
                   make.top.equalTo(AllView.mas_top);
                   make.bottom.equalTo(AllView.mas_bottom);
               }];
          
      };
//    JhFormSectionModel *section =JhSectionModel_Add(@[
//        cell_head,
//        cell_center,
//        cell1,
//        cell2,
//        cell3,
//        cell3333,
//        cell333,
//        cell7,
//        cell5,
//        cell6,
//        cell_bottom
//    ]);
  
    if([AppManager manager].userInfo.userType == 4)
    {
        JhFormSectionModel *section2 =JhSectionModel_Add(@[
                 cell_head,
                 cell_center,
                 cell0,
                 cell1,
                 cell2,
                 cell3,
                 cell33,
                 cell3333,
                 cell333,
                 cell7,
                 cell5,
                 cell6,
                 cell_bottom
             ]);
        [self.Jh_formModelArr addObjectsFromArray:@[section2]];
    }else{
        JhFormSectionModel *section1 =JhSectionModel_Add(@[
                cell_head,
                cell_center,
                cell1,
                cell2,
                cell3,
                cell33,
                cell3333,
                cell333,
                cell7,
                cell5,
                cell6,
                cell_bottom
            ]);
        [self.Jh_formModelArr addObjectsFromArray:@[section1]];

    }
    

    
    [self.Jh_formTableView reloadData];
    self.Jh_hiddenDefaultFooterView = YES;
}

#pragma mark - 点击跳转事件
-(void)saiShiJingliShenQin
{
    if( [[AppManager manager]userHasLogin]==NO)
         {
             [self showDefaultInfo:@"请先登录"];
             return;
         }
    
    
    if([AppManager manager].userInfo.userType>=3)
    {
        [self showDefaultInfo:@"您已经是赛事推广经理了"];
        return;
    }
    SaiShiJingLiViewController*vc = [[SaiShiJingLiViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)manageAddress
{
    if( [[AppManager manager]userHasLogin]==NO)
         {
             [self showDefaultInfo:@"请先登录"];
             return;
         }
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
          h5Vc.url = ADDRESS_MANAGE;
          h5Vc.addressChoseResult = ^(NSInteger id, NSString * _Nonnull address) {
          };
       h5Vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:h5Vc
                                                           animated:YES];
}
-(void)toDiaoChangRenZheng
{
    if( [[AppManager manager]userHasLogin]==NO)
      {
          [self showDefaultInfo:@"请先登录"];
          return;
      }
      if(![[AppDelegate appDelegate]hasAuthor])
      {
          [self showDefaultInfo:@"钓场认证，请先打开定位"];
          return;
      }
       NSMutableDictionary *dictR = [[NSMutableDictionary alloc]init];
       [dictR setValue:[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id] forKey:@"userId"];
       [[ApiFetch share]spotGetFetch:SPOTID_BYUSER query:dictR holder:self dataModel:IsPubishAct.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
           NSLog(@"发布赛事判断 = %@",modelValue);
           [self hideHud];
           IsPubishAct *isPublish = (IsPubishAct *)modelValue;
           if(isPublish.value == 0)
           {
               DiaoChangZhuRenZhengViewController *vc = [[ DiaoChangZhuRenZhengViewController  alloc]init];
               vc.hidesBottomBarWhenPushed = YES;
               vc.spotId = nil;
               [self.navigationController pushViewController:vc animated:YES];
           }else{
//               [self makeToask:@"你已经有钓场了"];
               DiaoChangZhuRenZhengViewController *vc = [[ DiaoChangZhuRenZhengViewController  alloc]init];
               vc.spotId = [NSString stringWithFormat:@"%ld",isPublish.value];
               vc.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:vc animated:YES];
           }
       }];

}

-(void)toSheZhiDiaoKeng
{
    if( [[AppManager manager]userHasLogin]==NO)
         {
             [self showDefaultInfo:@"请先登录"];
             return;
         }
          NSMutableDictionary *dictR = [[NSMutableDictionary alloc]init];
          [dictR setValue:[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id] forKey:@"userId"];
          [[ApiFetch share]spotGetFetch:SPOTID_BYUSER query:dictR holder:self dataModel:IsPubishAct.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
              NSLog(@"发布赛事判断 = %@",modelValue);
              [self hideHud];
              IsPubishAct *isPublish = (IsPubishAct *)modelValue;
              if(isPublish.value == 0)
              {
                  [self showDefaultInfo:@"请先进行钓场认证"];

              }else{
                  AddDiaoKengViewController *vc = [[AddDiaoKengViewController alloc]init];
                  vc.spotId = [NSString stringWithFormat:@"%ld",isPublish.value];
                  vc.hidesBottomBarWhenPushed = YES;
                  [self.navigationController pushViewController:vc animated:YES];
              }
          }];

    
}
-(void)toRenZheng
{
    if( self.userPageInfo.sign==nil)
    {
          ShiMingRenZhengViewController*vc = [[ShiMingRenZhengViewController alloc]init];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:NO];
    }else{
        [self showDefaultInfo:@"您已认证"];
    }

}
-(void)version1Click:(LPButton*)btn
{
    
}
-(void)aboutUS
{
    AboutUsViewController*vc = [[AboutUsViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)helpCenter
{
    
}
//协会排名
-(void)paiMping
{
    [self showDefaultInfo:@"暂未开通，敬请期待"];
//    GameRankSelectTableViewController*vc = [[GameRankSelectTableViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
//我的订单
-(void)toMyOrder
{
    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
     vc.hidesBottomBarWhenPushed = YES;
    vc.intoPageType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
