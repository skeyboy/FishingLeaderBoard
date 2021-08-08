//
//  RankViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/2/23.
//  Copyright © 2020 yue. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController ()
{
    YingXiongBangViewController * aVC;
}
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     aVC = [[YingXiongBangViewController alloc] init];
    aVC.paimingLists = self.paimingLists;
    [self.view addSubview:aVC.view];
    aVC.spotNameLabel.text = self.nameStr;

    [aVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.width.lessThanOrEqualTo(self.view.mas_width);
        make.centerX.equalTo(self.view);
    }];
}
-(UIView *)jieTuV{
    return aVC.jieTuV;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
