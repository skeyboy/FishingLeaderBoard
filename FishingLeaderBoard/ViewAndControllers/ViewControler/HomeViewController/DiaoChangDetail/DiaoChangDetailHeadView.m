//
//  DiaoChangHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailHeadView.h"
#import "FSSegmentTitleView.h"
#import "WMZBannerView.h"
#import "FImagePageViewCellCollectionViewCell.h"
#import "GRStarsView.h"
#import "TwoLabel.h"
#import "FaBuPingJiaView.h"
#import "QiDongFaBuSaiShiView.h"
@interface DiaoChangDetailHeadView()

@end
@implementation DiaoChangDetailHeadView
-(void)awakeFromNib{
    [super awakeFromNib];
 if((![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])&&(![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]))
 {
     self.locationBtn.hidden = YES;
 }
}
- (IBAction)phoneClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumberLabel.text]]];
}

- (IBAction)locationClick:(id)sender {
    [self.viewController performSelector:@selector(showNavSheet)];
}

-(void)addAllViewDelegate:(id)de {
    self.starsView = [self addstars];
    
    self.actLabel = [self addLabelsSuperView:self.bgActLabel topText:@"0" bottomText:@"活动场次"];
    self.baoMingLabel = [self addLabelsSuperView:self.bgBaoMingLabel topText:@"0" bottomText:@"报名人次"];
    self.guanZhuLabel = [self addLabelsSuperView:self.bgGuanzhuLabel topText:@"0" bottomText:@"关注人数"];
    
    
    FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) delegate:de indicatorType:1];
    titleView.titlesArr = @[@"活动/赛事",@"简介",@"渔获"];
    [self.bgChooseCardView addSubview:titleView];
    titleView.titleSelectColor= BLACKCOLOR;
    titleView.indicatorColor = BLACKCOLOR;
    titleView.backgroundColor = WHITECOLOR;
}
-(void)bindDataToView:(SpotInfo *)spotInfo
{
    if(spotInfo== nil)
    {
        return ;
    }
    self.titleLabel.text =spotInfo.name;
    self.actLabel.topLabel.text =[NSString stringWithFormat:@"%ld",spotInfo.activityCount];
    self.baoMingLabel.topLabel.text =[NSString stringWithFormat:@"%ld",spotInfo.enrollCount];
    self.guanZhuLabel.topLabel.text =[NSString stringWithFormat:@"%ld",spotInfo.collectCount];
    self.starsView.score = spotInfo.star;
    self.addressLabel.text = spotInfo.address;
    self.phoneNumberLabel.text = spotInfo.phone;
    //attestation 1 未认证 2认证
    self.right2Label.text =((spotInfo.attestation==2)?@"认证":@"");
    self.right0Label.text =((spotInfo.activity==2)?@"活动":@"");
    self.right1Label.text =((spotInfo.game==2)?@"赛事":@"");

    self.right3Label.text =(([spotInfo.spotType intValue]==1)?@"黑坑":
                           (([spotInfo.spotType intValue]==7)?@"欢乐塘":
                        (([spotInfo.spotType intValue]==8)?@"练竿塘":
                         (([spotInfo.spotType intValue]==9)?@"竞技池":
                           (([spotInfo.spotType intValue]==2)?@"路亚":@"")))));

    [self OnePageView:spotInfo];
    
}

- (IBAction)faBuPingJiaAction:(id)sender {
    FaBuPingJiaView*fabuView = [[FaBuPingJiaView alloc]init];
//    QiDongFaBuSaiShiView*fabuView = [[QiDongFaBuSaiShiView alloc]init];
    [self.viewController.view addSubview:fabuView];
    [fabuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewController.view.mas_left);
        make.right.equalTo(self.viewController.view.mas_right);
        make.top.equalTo(self.viewController.view.mas_top);
        make.bottom.equalTo(self.viewController.view.mas_bottom);

    }];
}

- (IBAction)pingJiaDetailAction:(id)sender {
    DetailPingJiaViewController *vc =[[DetailPingJiaViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(TwoLabel *)addLabelsSuperView:(UIView*)superView topText:(NSString *)text bottomText:(NSString *)bText{
    TwoLabel *act = [[TwoLabel alloc]init];
    act.topLabel.text = text;
    act.bottomLabel.text =bText;
    act.bottomLabel.textColor = [UIColor lightGrayColor];
    [superView addSubview:act];
    [act mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
    return act;
}

-(GRStarsView *)addstars{
    _starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(18, 18) margin:0 numberOfStars:5];
    _starsView.frame = CGRectMake(0, 0, 100,18);
    [self.bgStarImageView addSubview:_starsView];
    _starsView.allowSelect = YES;  // 默认可点击
    _starsView.allowDecimal = YES;  //默认可显示小数
    _starsView.allowDragSelect = NO;//默认不可拖动评分，可拖动下需可点击才有效
    _starsView.score = 0;
    return _starsView;
}
//轮播图
- (void)OnePageView:(SpotInfo *)spotInfo{
    NSArray *arrP=[spotInfo.posters componentsSeparatedByString:@","];
    NSLog(@"arr = %@",arrP);
    NSMutableArray *wM = [[NSMutableArray alloc]init];
        for(int i = 0;i<arrP.count;i++)
        {
            WMBannerCellModel *model = [[WMBannerCellModel alloc]init];
            model.imageName = [arrP objectAtIndex:i];
            [wM addObject:model];
        }
        [ToolView getLunBoViewHeight:HomeNewsBannerHeight
                                  width:SCREEN_WIDTH-20
                                      y:0
                                      x:0
                           superView:self.bgLunBoTuImageView data:wM clickBlock:^(id anyID, NSInteger index) {
        }];
    
}
@end

