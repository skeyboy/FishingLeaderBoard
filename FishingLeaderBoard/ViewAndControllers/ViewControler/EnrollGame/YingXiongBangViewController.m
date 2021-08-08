//
//  YingXiongBangViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import "YingXiongBangViewController.h"
#import "YuRankShareViewController.h"
#import "UIImageView+QR.h"
@interface YingXiongBangViewController ()

@end

@implementation YingXiongBangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"赛事排名" isShowBack:YES];
       hkNavigationView.backgroundColor = NAVBGCOLOR;
    self.view.backgroundColor = NAVBGCOLOR;
    if ([YuWeChatShareManager isWXAppInstalled]) {
         UIButton *share = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(SCREEN_WIDTH-50, Height_StatusBar+10, 30, 30) name:@"" delegate:self selector:@selector(shareClick:) tag:0];
         [share setImage:[UIImage imageNamed: @"share_nav"] forState:UIControlStateNormal];
         [hkNavigationView addSubview:share];
     }
    IMAGE_LOAD(self.yingxiongbangBottomImageView, @"https://app.diaoyuphb.com/apk/brand.jpeg");
    if(self.paimingLists.count==3)
    {
           PaiMingItem *paimingitem = [self.paimingLists objectAtIndex:0];
          [self.headImgV1 sd_setImageWithURL:[NSURL URLWithString:paimingitem.headImg]];
          self.nameLabel1.text = paimingitem.nickName;
          self.jifenLabel1.text = [NSString stringWithFormat:@"%ld",paimingitem.currencyCount];
          self.chengjiLabel1.text =[NSString stringWithFormat:@"%ld",paimingitem.buyBackCount];
          paimingitem = [self.paimingLists objectAtIndex:1];
         [self.headImgV2 sd_setImageWithURL:[NSURL URLWithString:paimingitem.headImg]];
         self.nameLabel2.text = paimingitem.nickName;
         self.jifenLabel2.text = [NSString stringWithFormat:@"%ld",paimingitem.currencyCount];
         self.chengjiLabel2.text =[NSString stringWithFormat:@"%ld",paimingitem.buyBackCount];
        paimingitem = [self.paimingLists objectAtIndex:2];
         [self.headImgV3 sd_setImageWithURL:[NSURL URLWithString:paimingitem.headImg]];
        self.nameLabel3.text = paimingitem.nickName;
         self.jifenLabel3.text = [NSString stringWithFormat:@"%ld",paimingitem.currencyCount];
         self.chengjiLabel3.text =[NSString stringWithFormat:@"%ld",paimingitem.buyBackCount];
    }
}

-(void)shareClick:(UIButton *)btn
{
       if(![[AppManager manager]userHasLogin])
         {
             [self showDefaultInfo:@"请先登录"];
             return;
         }
//    self.erWeiMaImgV.hidden = NO;
//    [self.erWeiMaImgV createQr:@"https://apps.apple.com/cn/app/%E9%92%93%E9%B1%BC%E6%8E%92%E8%A1%8C%E6%A6%9C/id1468248783"];
    UIImage * rankSnapShotImg = [self.jieTuV snapshotImage];
//    self.erWeiMaImgV.hidden = YES;
    YuRankShareViewController * rankShareVc = [[YuRankShareViewController alloc] init];
    rankShareVc.rankImage = rankSnapShotImg;
    [self presentViewController:rankShareVc
                       animated:YES
                     completion:^{
        
    }];
}
@end
