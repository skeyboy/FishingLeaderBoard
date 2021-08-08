//
//  HuoDongSaiShiShuoMingViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/9.
//  Copyright © 2020 yue. All rights reserved.
//

#import "HuoDongSaiShiShuoMingViewController.h"

@interface HuoDongSaiShiShuoMingViewController ()

@end

@implementation HuoDongSaiShiShuoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 [self setNavViewWithTitle:(self.isSaiShi?(@"发起赛事说明"):(@"发起活动说明")) isShowBack:YES];
    NSString *titleS= nil;
    if(self.isSaiShi)
    {
        titleS = @"1.发布赛事指钓场和平台达成赛事合作意向，发布的赛事活动结束后，根据发布赛事选择的模式（排名模式或抽奖模式）参与用户可进行“榜单排名”，根据鱼获总量排名，前三名将获得奖励积分，或进行积分抽奖获得奖励积分；\n\n 2,平台服务费标准：门票100元收取10元服务费、门票150—299元收取20元服务费、门票300元以上收取30元服务费\n\n3.赛事服务费优惠规则：单场报名人数≥80人以上优惠8人；单场报名人数≥100人以上优惠16人；单场报名人数≥120人以上优惠32人。例如：单场赛事报名人数最终为80人，报名费用100元，平台收取服务费为（80-8）x10=720元 ";
    }else{
        titleS = @"发布活动指钓场正常发起的鱼讯，分为普通模式和积分模式。积分模式指活动结束后，参与用户可获得50积分奖励，以此激励用户参与的积极性，平台将按活动报名人数按每人收取钓场2元服务费用；\n普通模式指活动结束后，参与用户不会获得积分奖励的机会，平台不收取钓场服务费用。";
    }
    UITextView*tview = [[UITextView alloc]init];
    tview.text = titleS;
    tview.editable = NO;
    tview.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:tview];
        [tview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hkNavigationView.mas_bottom);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.equalTo(@(SCREEN_HEIGHT-128));
            make.width.equalTo(@(SCREEN_WIDTH));
        }];
}

@end
