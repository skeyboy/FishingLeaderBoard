//
//  MyTwoQiHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/3/23.
//  Copyright © 2020 yue. All rights reserved.
//

#import "MyTwoQiHeadView.h"

@implementation MyTwoQiHeadView

- (instancetype)init {
    
    self = [super init];
    self = [[[NSBundle mainBundle] loadNibNamed:@"MyTwoQiHeadView" owner:self options:nil] lastObject];
    if (self) {
        self.backgroundColor = NAVBGCOLOR;
        self.bgheadView.backgroundColor = NAVBGCOLOR;
        self.headView.layer.cornerRadius = 27.5;
        self.xiugaiziliaoBtn.layer.borderColor = WHITECOLOR.CGColor;
        self.xiugaiziliaoBtn.layer.borderWidth = 1;
        self.xiugaiziliaoBtn.layer.cornerRadius = 15;
        self.xiugaiziliaoBtn.clipsToBounds = YES;
    }
    return self;
}

- (IBAction)xiugaiziliaoClick:(id)sender {
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
       vc.hidesBottomBarWhenPushed = YES;
       vc.vc = self.viewController;
       [self.viewController.navigationController pushViewController:vc animated:NO];

}
@end
