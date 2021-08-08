//
//  JiFenDuiHuanView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "JiFenDuiHuanView.h"

@implementation JiFenDuiHuanView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.diaoJiKeTangImageView.layer.cornerRadius = 5;
    self.saiShiBaoMingView.layer.cornerRadius = 5;
    self.jiFenShangChengImageView.layer.cornerRadius = 5;
    self.jifenChouJIangImageView.layer.cornerRadius = 5;
    self.bgQianDaoView.layer.shadowOffset =CGSizeMake(0,0);
    self.bgQianDaoView.layer.shadowColor =[UIColor blackColor].CGColor;
    self.bgQianDaoView.layer.shadowOpacity = 0.3;
    self.bgQianDaoView.layer.shadowRadius = 5;
    self.quQianDaoButton.layer.cornerRadius = 10;
    self.bgLunBoView.layer.cornerRadius =5;
    self.bgLunBoView.clipsToBounds = YES;
}

- (IBAction)toIntegallLottery:(id)sender {
    
}

- (IBAction)toIntegallMall:(id)sender {
    IntegralMallViewController*vc =[[IntegralMallViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toEnrollGame:(id)sender {
    EnrollGameNewViewController *vc =[[EnrollGameNewViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toFishClass:(id)sender {
    
}
@end
