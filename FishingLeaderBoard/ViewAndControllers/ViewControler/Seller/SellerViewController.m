//
//  WoDeDiaoChangViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SellerViewController.h"
#import "SellerTableCell.h"
#import "YaoHaoViewController.h"
#import "PeerAnalysisViewController.h"
#import "FaBuSaiShiViewController.h"
#import "YuQrViewController.h"
#import "BuyFishObject.h"
#import "WalletViewController.h"
#import "SGoodsDuiHuaJiLuViewController.h"
#import "SellerConfirmViewController.h"
#import "SellerStockTableViewController.h"
#import "SGoodsDuiHuanListableViewController.h"
#import "GRStarsView.h"
#import "SpotAccountManageViewController.h"
#import "EnrollGameNewViewController.h"
@interface SellerViewController ()<UITableViewDelegate,UITableViewDataSource,ApiFetchOptionalHandler,YuQrViewControllerDelegate>

/// 钓场封面
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

/// 钓场名称
@property (weak, nonatomic) IBOutlet UILabel *spotNameView;
@property (weak, nonatomic) IBOutlet ColorLabel *spotStatusView;
/// 星级评价
@property (weak, nonatomic) IBOutlet UIView *spotStarContainerView;
@property (strong,nonatomic)GRStarsView *starsView;
/// 收藏人数
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountView;
@property (weak, nonatomic) IBOutlet UIView *grvidView;
@property (weak, nonatomic) IBOutlet UILabel *gameInfoView;
@property (weak, nonatomic) IBOutlet UITableView *sellerTableView;
@property (weak, nonatomic) IBOutlet UIView *bgSpotView;


@property(strong) SpotEventUser *spotEventUser;
@end

@implementation SellerViewController
#define Identifier @"SellerTableCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"我的钓场" isShowBack:NO];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [self initPageView];
    [self getData];
    
    
}
-(void)getData
{
    @weakify(self)
    [[ApiFetch share] spotGetFetch:SPOT_EVENT_USER
                             query:@{}
                            holder:self
                         dataModel:SpotEventUser.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        SpotEventUser * spotEventUser = ( SpotEventUser *  )modelValue;
        [weak_self bindValue:spotEventUser];
        [weak_self.sellerTableView.mj_header endRefreshing];
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self.sellerTableView.mj_header endRefreshing];
    [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    return YES;
}
-(void)bindValue:(SpotEventUser *) spotEventUser{
    self.spotEventUser = spotEventUser;
    @weakify(self)
    IMAGE_LOAD(self.coverImageView, spotEventUser.extend.icon)
    self.gameInfoView.text =[NSString stringWithFormat:@"我的发布(%ld)",spotEventUser.page.totalCount];
    weak_self.spotNameView.text = spotEventUser.extend.name;
    weak_self.favoriteCountView.text =[NSString stringWithFormat:@"%@个人收藏", @(spotEventUser.extend.collectNum).description];
//    weak_self.spotStatusView.text = spotEventUser.extend.attestation?@"v已认证":@"";
    self.starsView.score = spotEventUser.extend.star;
    [self.sellerTableView reloadData];
}
-(void)initPageView
{
    self.coverImageView.layer.cornerRadius = 5;

    [self.bgSpotView addShadowCornerRadius:3 cornerRadius:5 shadowOpacity:0.2];
    [self.sellerTableView registerNib:[UINib nibWithNibName:@"SellerTableCell" bundle:nil] forCellReuseIdentifier:Identifier];
    self.sellerTableView.delegate = self;
    self.sellerTableView.dataSource = self;
    self.sellerTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sellerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sellerTableView.estimatedRowHeight  = UITableViewAutomaticDimension;
    [self.sellerTableView reloadData];
    self.sellerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self addButton];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
     UIButton*bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [bt setTitle:@"查看全部" forState:UIControlStateNormal];
     [bt addTarget:self action:@selector(toAllMyGames:) forControlEvents:UIControlEventTouchUpInside];
     [footerView addSubview:bt];
     bt.frame = CGRectMake((SCREEN_WIDTH - 100)/2.0, 10, 100, 30);
    bt.layer.cornerRadius = 5;
    bt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bt.layer.borderWidth = 1;
    [bt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.sellerTableView.tableFooterView = footerView;
 [self.sellerTableView.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.height.greaterThanOrEqualTo(@(490-150+HomeNewsBannerHeight));
     make.width.equalTo(@(SCREEN_WIDTH));
 }];
 [self.coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hkNavigationView.mas_bottom).offset(10);
        make.left.equalTo(self.headView.mas_left).offset(10);
        make.height.equalTo(@(HomeNewsBannerHeight));
        make.right.equalTo(self.headView.mas_right).offset(-10);
    }];
    
}
-(void)addButton
{
    LPButton *btn1 =[ToolView btnTitle:@"抽号" image:@"se_chouhao" tag:0 superView:self.grvidView sel:@selector(chouHaoClick:) targer:self setStyle:LPButtonStyleTop font:15];
    UIButton *btn2 =[ToolView btnTitle:@"收鱼" image:@"se_shouyu" tag:0 superView:self.grvidView sel:@selector(shouYuClick:) targer:self setStyle:LPButtonStyleTop font:15];
    UIButton *btn3 =[ToolView btnTitle:@"商品库存" image:@"se_shangjiakucun" tag:0 superView:self.grvidView sel:@selector(kuCunClick:) targer:self setStyle:LPButtonStyleTop font:15];
    UIButton *btn4 =[ToolView btnTitle:@"商品兑换" image:@"se_shangpinkuihuan" tag:0 superView:self.grvidView sel:@selector(duiHuanClick:) targer:self setStyle:LPButtonStyleTop font:15];
    
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3,btn4]];
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
    btn1 =[ToolView btnTitle:@"出库记录" image:@"se_chukujilu" tag:0 superView:self.grvidView sel:@selector(chuKuClick:) targer:self setStyle:LPButtonStyleTop font:15];
    btn2 =[ToolView btnTitle:@"同行分析" image:@"se_tonghangfenxi" tag:0 superView:self.grvidView sel:@selector(fenXiClick:) targer:self setStyle:LPButtonStyleTop font:15];
    btn3 =[ToolView btnTitle:@"账目管理" image:@"se_xiangmuguanli" tag:0 superView:self.grvidView sel:@selector(guanLiClick:) targer:self setStyle:LPButtonStyleTop font:15];
    
    btn4 =[ToolView btnTitle:@"钓场钱包" image:@"se_diaochangqianbao" tag:0 superView:self.grvidView sel:@selector(qianBaoClick:) targer:self setStyle:LPButtonStyleTop font:15];
    
    [btnArr removeAllObjects];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3,btn4]];
    
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
    self.starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(18, 18) margin:0 numberOfStars:5];
    self.starsView.frame = CGRectMake(0, 0, self.spotStarContainerView.frame.size.width, self.spotStarContainerView.frame.size.height);
    [self.spotStarContainerView addSubview:self.starsView];
    self.starsView.allowSelect = YES;  // 默认可点击
    self.starsView.allowDecimal = YES;  //默认可显示小数
    self.starsView.allowDragSelect = NO;//默认不可拖动评分，可拖动下需可点击才有效
    self.starsView.score = 0;
}
/// 发布赛事活动
/// @param sender <#sender description#>
- (IBAction)postGame:(id)sender {
    
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return ;
    }
    NSMutableDictionary *dictR = [[NSMutableDictionary alloc]init];
    [dictR setValue:[NSString stringWithFormat:@"%ld",[AppManager manager].userInfo.id] forKey:@"userId"];
    [[ApiFetch share]spotGetFetch:SPOTID_BYUSER query:dictR holder:self dataModel:IsPubishAct.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        NSLog(@"发布赛事判断 = %@",modelValue);
        [self hideHud];
        IsPubishAct *isPublish = (IsPubishAct *)modelValue;
        [self faBuHuoDongAndSaiShi:isPublish];
    }];
   
}
-(void)faBuHuoDongAndSaiShi:(IsPubishAct *)isPublish
{
    @weakify(self)
       UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"请选择发布类型" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
       UIAlertAction * baiduApp = [UIAlertAction actionWithTitle:@"发布活动" style:0 handler:^(UIAlertAction * _Nonnull action) {
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
       }];
       UIAlertAction * gaodeApp = [UIAlertAction actionWithTitle:@"发布赛事" style:0 handler:^(UIAlertAction * _Nonnull action) {
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
       }];
       [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
       }]];
       [actionSheet addAction:baiduApp];
       [actionSheet addAction:gaodeApp];
       
       [self presentViewController:actionSheet
                          animated:YES
                        completion:^{
           
       }];
}
/// 查看全部赛事活动
/// @param sender <#sender description#>
- (IBAction)goToHistory:(id)sender {
    
    
}
- (IBAction)toAllMyGames:(id)sender {
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.hidesBottomBarWhenPushed = YES;
    h5Vc.url = BUSSINESS_ACTIVE_LIST(1);
    
    [self.navigationController pushViewController:h5Vc
                                         animated:YES];
}

///抽号
-(void)chouHaoClick:(LPButton*)btn
{
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.hidesBottomBarWhenPushed = YES;

       h5Vc.url = BUSSINESS_ACTIVE_LIST(2);
       
       [self.navigationController pushViewController:h5Vc
                                            animated:YES];
    return;
    YaoHaoViewController*vc = [[YaoHaoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//收鱼
-(void)shouYuClick:(LPButton *)btn
{
    
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    //    TODO
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    //读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请在iOS设置中打开App相机使用权限";
        [hud hideAnimated:YES
               afterDelay:1.0];
        
        return;
        
    }
    
    YuQrViewController *qrScanVC  =[[YuQrViewController alloc] init];
    qrScanVC.modalPresentationStyle = UIModalPresentationFullScreen;
    qrScanVC.qrResult = ^(NSArray<LBXScanResult *> * result) {
        if(result.count)
        {
            LBXScanResult *r =[result objectAtIndex:0];
            NSString *spotIdS = [r.strScanned stringByRemovingPercentEncoding];
            NSArray *arr = [spotIdS componentsSeparatedByString:@"#"];
            NSLog(@"YuQrViewController = %@  ,%@",spotIdS,arr);
            if(spotIdS &&(arr.count == 3))
            {
                if([[arr objectAtIndex:0] intValue]!=0)
                {
                    [[[BuyFishObject alloc]init] buyFish:qrScanVC sellerID:spotIdS vc:self.tabBarController];
                }else{
                    [self showDefaultInfo:@"二维码格式化错误，请重新扫描"];
                    [qrScanVC dismissViewControllerAnimated:NO completion:^{
                    }];
                }
                
            }else{
                [self showDefaultInfo:@"二维码格式化错误，请重新扫描"];
                [qrScanVC dismissViewControllerAnimated:NO completion:^{
                }];
            }
            
        }
    };
    [self presentViewController:qrScanVC animated:YES completion:^{
        
    }];
}
//库存
-(void)kuCunClick:(LPButton *)btn
{
//    [self showDefaultInfo:@"暂未开通，敬请期待"];
    SellerStockTableViewController * stockVc = [[SellerStockTableViewController alloc] init];
    stockVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:stockVc
                                         animated:YES];
}
//兑换
-(void)duiHuanClick:(LPButton *)btn
{
//    [self showDefaultInfo:@"暂未开通，敬请期待"];
    SGoodsDuiHuaJiLuViewController*vc = [[SGoodsDuiHuaJiLuViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titles = @[@"未兑换",@"已兑换"];
    [self.navigationController pushViewController:vc animated:YES];

    return;
    @weakify(self)
     __block  YuQrViewController *qrVc = [[YuQrViewController alloc] init];
       qrVc.qrDelegate = self;
       qrVc.qrResult = ^(NSArray<LBXScanResult *> *result) {
           if (result.count) {
               LBXScanResult * item = result.firstObject;
               SellerConfirmViewController *sellerConfirmVc = [[SellerConfirmViewController alloc] init];
               sellerConfirmVc.code = item.strScanned;
               sellerConfirmVc.hidesBottomBarWhenPushed = YES;
               [qrVc dismissViewControllerAnimated:NO
                                        completion:^{
                   [weak_self.navigationController pushViewController:sellerConfirmVc
                   animated:YES];
               }];
           }
       };
       [self presentViewController:qrVc
                          animated:YES
                        completion:^{
           
       }];
}
//出库记录
-(void)chuKuClick:(LPButton *)btn
{
//    [self showDefaultInfo:@"暂未开通，敬请期待"];
//    SGoodsDuiHuaJiLuViewController*vc = [[SGoodsDuiHuaJiLuViewController alloc]init];
ChuKuHistoryViewController *    vc = [[ChuKuHistoryViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}
-(void)guanLiClick:(LPButton *)btn
{
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    [self showDefaultInfo:@"暂未开通，敬请期待"];
    SpotAccountManageViewController*vc = [[SpotAccountManageViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//同行分析
-(void)fenXiClick:(LPButton *)btn
{
//    [self showDefaultInfo:@"暂未开通，敬请期待"];
    
    H5ArticalDetailViewController * h5VC = [[H5ArticalDetailViewController alloc] init];
    h5VC.url = ColleagueAnalysis;
    h5VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:h5VC
                                         animated:YES];
    //    PeerAnalysisViewController*vc = [[PeerAnalysisViewController alloc]init];
    //           vc.hidesBottomBarWhenPushed = YES;
    //           [self.navigationController pushViewController:vc animated:YES];
    //
}
//钓场钱包
-(void)qianBaoClick:(LPButton *)btn
{
    WalletViewController *walletVc = [[WalletViewController alloc] init];
    walletVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:walletVc
                                         animated:YES];
}
#pragma tableview的代理函数

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   SpotEventUserItem * item =
    self.spotEventUser.list[indexPath.row];
    
    EnrollGameNewViewController * detailVC = [[EnrollGameNewViewController alloc] init];
       detailVC.eventId = item.id;
    detailVC.isAct = item.type == 1;
       detailVC.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:detailVC
                                                           animated:YES];
    
    return;
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = BUSSINESS_ACTIVEDETAILS(item.id);
    
//    EnrollGameNewViewController *enRollVc = [[EnrollGameNewViewController alloc] init];
//    enRollVc.eventId = item.id;
//    enRollVc.isAct = item.type == 1;
//
    h5Vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:h5Vc
                                         animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:Identifier
                                           forIndexPath:indexPath];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.spotEventUser==nil?0:self.spotEventUser.list.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //TOD 补全数据
    SellerTableCell * sellerCell = cell;
    
    [sellerCell bindValue:self.spotEventUser.list[indexPath.row]];
    
}
@end
