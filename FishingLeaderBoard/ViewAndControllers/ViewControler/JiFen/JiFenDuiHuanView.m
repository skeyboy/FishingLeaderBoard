//
//  JiFenDuiHuanView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "JiFenDuiHuanView.h"

@implementation JiFenDuiHuanView
-(instancetype)init
{
    self = [super init];
    self = [[[NSBundle mainBundle]loadNibNamed:@"JiFenDuiHuanView" owner:self options:nil]firstObject];
    if(self)
    {
        
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.bgjiFenLabelView.backgroundColor = NAVBGCOLOR;
    self.diaoJiKeTangImageView.layer.cornerRadius = 5;
    self.saiShiBaoMingView.layer.cornerRadius = 5;
    self.jiFenShangChengImageView.layer.cornerRadius = 5;
    self.jifenChouJIangImageView.layer.cornerRadius = 5;
    self.bgQianDaoView.layer.shadowOffset =CGSizeMake(3,3);
    self.bgQianDaoView.layer.shadowColor =[UIColor blackColor].CGColor;
    self.bgQianDaoView.layer.shadowOpacity = 0.3;
    self.bgQianDaoView.layer.shadowRadius = 5;
    self.quQianDaoButton.layer.cornerRadius = 10;
    self.bgLunBoView.layer.cornerRadius =5;
    self.bgLunBoView.clipsToBounds = YES;
    
    
}
//签到
- (IBAction)goToMySignIn:(id)sender {
    H5ArticalDetailViewController * h5Vc = [[H5ArticalDetailViewController alloc] init];
    
    h5Vc.url = MINE_SIGIN;
    h5Vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:h5Vc
                                                        animated:YES];
}

- (IBAction)toIntegallLottery:(id)sender {
    [self.viewController showDefaultInfo:@"暂未开通，敬请期待"];
}

- (IBAction)toIntegallMall:(id)sender {
//    IntegralMallViewController*vc =[[IntegralMallViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController:vc animated:YES];
//    [self.viewController showDefaultInfo:@"暂未开通，敬请期待"];
     if(![[AppManager manager]userHasLogin])
        {
            [self.viewController showDefaultInfo:@"请先登录"];
            return;
        }
    //    [self.viewController showDefaultInfo:@"暂未开通，敬请期待"];
        UIViewController*vc =[[NSClassFromString(@"IntegralMallViewController") alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toEnrollGame:(id)sender {
    SaiShiAndHuoDongTableViewController*vc =[[SaiShiAndHuoDongTableViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toFishClass:(id)sender {
    H5ArticalDetailViewController * h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = FISH_ClassRoom;
    h5Vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:h5Vc
                                                        animated:YES];
}
@end
