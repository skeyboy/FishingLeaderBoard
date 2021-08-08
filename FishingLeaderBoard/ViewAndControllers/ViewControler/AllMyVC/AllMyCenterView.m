//
//  AllMyCenterView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AllMyCenterView.h"
#import "MyHDCanYuTableViewController.h"
#import "AllMyViewController.h"
#import "MyOrderViewController.h"
#import "WalletViewController.h"
@implementation AllMyCenterView

-(instancetype)initWithFrame:(CGRect)frame typePage:(FTabBarTypePage)typePage
data:(UserPageInfo *)userPageInfo{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userPageInfo = userPageInfo;
        self.height = 15+70+15+80+15;
        float y = 15;
        [self addThreeView:y];
        y = 15+70+15;
        [self addTwoView:y];
        y = 15+70+15+80+15;
        if(typePage == FPageTypeYouKeLogin)
        {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, y, SCREEN_WIDTH-35, 80)];
            [self addSubview:view];
            [view addShadowCornerRadius:5 cornerRadius:10 shadowOpacity:0.5];
            UIImageView *sellerCorverImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,view.width,view.height)];
            sellerCorverImgV.image = [UIImage imageNamed:@""];
            [sellerCorverImgV addShadowCornerRadius:5 cornerRadius:10 shadowOpacity:0.2];
            sellerCorverImgV.clipsToBounds = YES;
            [view addSubview:sellerCorverImgV];
            self.height = y +80 +15;
        }
        
        
        
    }
    return self;
}

-(void)addThreeView:(float)y
{
    UIView *threeView = [TwoLabel addSomeTwoLabelTopColor:BLACKCOLOR
                                              BottomColor:BLACKCOLOR
                                                  topFont:[UIFont systemFontOfSize:17]
                                               bottomFont:[UIFont systemFontOfSize:13]
                                          textDataArrDict:@[@{@"top":[NSString stringWithFormat:@"%ld",self.userPageInfo.activity],@"bottom":@"参与的活动"},
                                                            @{@"top":[NSString stringWithFormat:@"%ld",(long)self.userPageInfo.game],@"bottom":@"参与的赛事"},
                                                            @{@"top":[NSString stringWithFormat:@"%ld",(long)self.userPageInfo.collect],@"bottom":@"我的收藏"}]
                                                    frame:CGRectMake(15, y, SCREEN_WIDTH-30, 70)
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
    [threeView addShadowCornerRadius:2 cornerRadius:5 shadowOpacity:0.2];
    
    [self addSubview:threeView];
    
}
-(void)addTwoView:(float)y
{
    UIView *twoView = [TwoLabel addSomeTwoLabelTopColor:BLACKCOLOR
                                            BottomColor:[UIColor lightGrayColor]
                                                topFont:[UIFont systemFontOfSize:17]
                                             bottomFont:[UIFont systemFontOfSize:12]
                                        textDataArrDict:@[@{@"top":@"钱包金额"
                                                            ,@"bottom":[NSString stringWithFormat:@"%@",self.userPageInfo.money]},
                                                          @{@"top":@"我的代金券",@"bottom":[NSString stringWithFormat:@"%ld张",(long)self.userPageInfo.coupons]},]
                                                  frame:CGRectMake(15, y, SCREEN_WIDTH-30, 80)
                                         twoLabelHeight:40
                                                  click:^(NSInteger index) {
        if(index==0)
        {
            [self toWallet];
        }else{
            [self myVoucher];
        }
    }];
    [twoView addShadowCornerRadius:2 cornerRadius:5 shadowOpacity:0.2];
    [self addSubview:twoView];
    
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
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(void)myCanYuAct
{
    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
     vc.hidesBottomBarWhenPushed = YES;
    vc.intoPageType = 1;
    [self.viewController.navigationController pushViewController:vc animated:YES];
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
    
    [self.viewController.navigationController pushViewController:h5Vc
                                                        animated:YES];
//    MyHDCanYuTableViewController *vc = [[MyHDCanYuTableViewController alloc]init];
//       vc.hidesBottomBarWhenPushed = YES;
//       [self.viewController.navigationController pushViewController:vc animated:NO];
}
-(void)toWallet
{
         WalletViewController *walletVc = [[WalletViewController alloc] init];
         walletVc.hidesBottomBarWhenPushed = YES;
         walletVc.vc = self.viewController;
         [self.viewController.navigationController pushViewController:walletVc
                                              animated:YES];
}
-(void)myVoucher
{
    [self.viewController showDefaultInfo:@"暂未开通，敬请期待"];
}
@end
