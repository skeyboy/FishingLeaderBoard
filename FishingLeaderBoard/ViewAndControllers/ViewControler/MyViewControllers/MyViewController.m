//
//  MyViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyViewController.h"
#import "ChooseRenZhengViewController.h"
#import "WalletViewController.h"
#import "SettingViewController.h"
#import "ChooseRenZhengViewController.h"
#import "ShiMingRenZhengViewController.h"
#import "GameRankSelectTableViewController.h"
#import "AboutUsViewController.h"
#import "MyOrderViewController.h"
#import "DiaoChangZhuRenZhengViewController.h"
#import "AddDiaoKengViewController.h"
#import "SaiShiJingLiViewController.h"
#import "FTabBarClass.h"
#import "UserPageInfo.h"
#import "MySectionHeadView.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *myIconArr;
    __block MySectionHeadView *view3;
    __block MyTwoQiHeadView *headView;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPageView];
    self.view.backgroundColor = LOGINBGCOLOR;
   self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initPageData)];
    [self initPageData];
    if (@available(iOS 11.0, *)) {
            self.userTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

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
        weak_self.userPageInfo = (UserPageInfo*)modelValue;
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
//        [self addSubviewTwoView];
        self->view3.jiELabel.text = [NSString stringWithFormat:@"%.2f",weak_self.userPageInfo.money];
        self->view3.daiJinQuanLabel.text = [NSString stringWithFormat:@"%ld张",(long)weak_self.userPageInfo.coupons];
      }];
     
}
-(void)initPageView
{
    myIconArr = [MyDataObject getMyData];
    self.view.backgroundColor = NAVBGCOLOR;
    self.userTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - Height_TabBar ) style:UITableViewStyleGrouped];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.view addSubview:self.userTableView];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];

}
-(void)addSubviewTwoView
{
    [headView.bottomView removeAllSubviews];
    UIView *threeView = [TwoLabel addSomeTwoLabelTopColor:NAVBGCOLOR
                                               BottomColor:NAVBGCOLOR
                                                   topFont:[UIFont systemFontOfSize:17]
                                                bottomFont:[UIFont systemFontOfSize:13]
                                           textDataArrDict:@[@{@"top":[NSString stringWithFormat:@"%ld",self.userPageInfo.activity],@"bottom":@"参与的活动"},
                                                             @{@"top":[NSString stringWithFormat:@"%ld",(long)self.userPageInfo.game],@"bottom":@"参与的赛事"},
                                                             @{@"top":[NSString stringWithFormat:@"%ld",(long)self.userPageInfo.collect],@"bottom":@"我的收藏"}]
                                                     frame:CGRectMake(15, 0, SCREEN_WIDTH-30, 70)
                                            twoLabelHeight:40
                                                     click:^(NSInteger index) {
         if(index == 0)
         {
              [self myCanYuAct];
            
         }else if(index == 1)
         {
             [self myCanYuGame];
         }else{
             [self myStore];
         }
     }];
     [headView.bottomView addSubview:threeView];
}
-(void)myCanYuGame
{
//    MyHDCanYuTableViewController *vc = [[MyHDCanYuTableViewController alloc]init];
//    vc.isAct = NO;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController:vc animated:NO];
    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
     vc.hidesBottomBarWhenPushed = YES;
    vc.intoPageType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myCanYuAct
{
    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
     vc.hidesBottomBarWhenPushed = YES;
    vc.intoPageType = 1;
    [self.navigationController pushViewController:vc animated:YES];
//    MyHDCanYuTableViewController *vc = [[MyHDCanYuTableViewController alloc]init];
//      vc.isAct = YES;
//       vc.hidesBottomBarWhenPushed = YES;
//       [self.viewController.navigationController pushViewController:vc animated:NO];
}
-(void)myStore
{
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = MINE_COLLECTION;
    h5Vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:h5Vc
                                                        animated:YES];
//    MyHDCanYuTableViewController *vc = [[MyHDCanYuTableViewController alloc]init];
//       vc.hidesBottomBarWhenPushed = YES;
//       [self.viewController.navigationController pushViewController:vc animated:NO];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [myIconArr objectAtIndex:section];
    return arr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分普通用户和钓场主
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArr = [myIconArr objectAtIndex:indexPath.section];
    NSDictionary *dict =[sectionArr objectAtIndex:indexPath.row];
    MyTableViewCell *cell =[self.userTableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImage.image=[UIImage imageNamed:[dict objectForKey:@"imageName"]];
    cell.centerLabel.text = [dict objectForKey:@"name"];
    if([[dict objectForKey:@"name"] isEqualToString:@"实名认证"])
    {
        if(self.userPageInfo!=nil)
        {
            if(self.userPageInfo.sign==nil)
            {
                cell.rightLabel.text = @"兑换积分之前先进行积分认证";
                cell.rightLabel.textColor = [UIColor orangeColor];
            }else{
                cell.rightLabel.text = @"已认证";
                cell.rightLabel.textColor = [UIColor grayColor];
                cell.rightView.image = [UIImage imageNamed:@""];
            }
        }
    }
    if([[dict objectForKey:@"name"] isEqualToString:@"版本信息"]){
        NSString*version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        cell.rightLabel.text = version;
        cell.rightLabel.textColor = [UIColor grayColor];
        cell.rightView.image = [UIImage imageNamed:@""];
    }else{
        cell.rightLabel.text = @"";

    }
        
    if(indexPath.section == 1)
    {
        [cell.iconImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    }else{
        [cell.iconImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
        }];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *sectionArr = [myIconArr objectAtIndex:indexPath.section];
    NSDictionary *dict =[sectionArr objectAtIndex:indexPath.row];
    NSString *name = [dict objectForKey:@"name"];
    [self gotoViewController:name];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
         UIView*view = [[UIView alloc]init];
    //    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.equalTo(@(SCREEN_WIDTH));
    //        make.height.equalTo(@(128+220+20+10));
    //    }];
        UserInfo *userInfo = [AppManager manager].userInfo;
        headView = [[MyTwoQiHeadView alloc]init];
        headView.nameLabel.text = [NSString stringWithFormat:@"%@",userInfo.nickName];
        [headView.headView sd_setImageWithURL:[NSURL URLWithString:userInfo.headImg] placeholderImage:[UIImage imageNamed:@"user_my"]];
        [view addSubview:headView];
           [headView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.width.equalTo(@(SCREEN_WIDTH));
               make.height.equalTo(@(220+20));
               make.top.equalTo(view.mas_top);
               make.left.equalTo(view.mas_left);
           }];
        UIView*view2 = [[UIView alloc]init];
        view2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:view2];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@10);
            make.top.equalTo(headView.mas_bottom);
            make.left.equalTo(view.mas_left);
        }];
        view3 = [[MySectionHeadView alloc]init];
             view3.jiELabel.text = [NSString stringWithFormat:@"%.2f",self.userPageInfo.money];
             view3.daiJinQuanLabel.text = [NSString stringWithFormat:@"%ld张",(long)self.userPageInfo.coupons];
        [view addSubview:view3];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.width.equalTo(@(SCREEN_WIDTH));
                 make.height.equalTo(@128);
                 make.top.equalTo(view2.mas_bottom);
                 make.left.equalTo(view.mas_left);
             }];
        [self  addSubviewTwoView];
         return view;
    }
   
    return nil;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 128+220+20+10;
    else
        return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==1)
    {
        MyAllBottomView *bottomView = [[MyAllBottomView alloc]init];
        return bottomView;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==1)
    {
        return 200;
    }
    return 0;
}
#pragma mark - 点击跳转事件
-(void)gotoViewController:(NSString*)nameStr
{

    if ([nameStr isEqualToString:@"协会赛事排名"]) {
        [self paiMping];
    }else if([nameStr isEqualToString:@"设置钓坑"]){
      [self  toSheZhiDiaoKeng];
        
    }else if([nameStr isEqualToString:@"切换至代理人"]||[nameStr isEqualToString:@"切换至钓场主"])
    {
        [FTabBarClass intoTabBarControll];
    }else if([nameStr isEqualToString:@"我的订单"])
    {
        [self toMyOrder];
    }else if([nameStr isEqualToString:@"实名认证"])
    {
        [self toRenZheng];
    }else if ([nameStr isEqualToString:@"钓场认证"]){
        [self toDiaoChangRenZheng];
    }else if ([nameStr isEqualToString:@"推广申请"]){
        [self saiShiJingliShenQin];
    }else if ([nameStr isEqualToString:@"收货地址管理"]){
        [self manageAddress];
    }else if ([nameStr isEqualToString:@"版本信息"]){
        
    }else if ([nameStr isEqualToString:@"隐私保护指引"]){

    }else if ([nameStr isEqualToString:@"了解我们"]){
        [self aboutUS];
    }else if([nameStr isEqualToString:@"收鱼管理"]){
        [self shouYuManage];
    }
}
-(void)shouYuManage{
    
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
          h5Vc.url = ShouYuManage;
       h5Vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:h5Vc
                                                           animated:YES];
    
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
