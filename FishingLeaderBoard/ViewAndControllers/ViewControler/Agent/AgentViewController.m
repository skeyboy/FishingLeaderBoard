//
//  DaiLiViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AgentViewController.h"
#import "FAgentViewController.h"
@interface AgentViewController ()

@end

@implementation AgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self image];
 
}

-(void)image{
    [self setNavViewWithTitle:@"代理钓场功能展示" isShowBack:NO];
     self.view.backgroundColor = WHITECOLOR;
    UIScrollView *bgS = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(hkNavigationView.frame))];
    [self.view addSubview:bgS];
    UIImageView *imageView = [FViewCreateFactory createImageViewWithImageName:@"daiLiImage"];
    imageView.userInteractionEnabled = YES;
    [bgS addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgS.mas_left).offset(0);
        make.right.equalTo(bgS.mas_right).offset(0);
        make.top.equalTo(bgS.mas_top).offset(0);
        make.height.equalTo(@(900));
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(bgS.mas_bottom).offset(10);
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
//        FAgentViewController *a = [[FAgentViewController alloc]initWithNibName:@"FAgentViewController" bundle:nil];
//        a.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:a animated:YES];
//     }];
//    [imageView addGestureRecognizer:tap];
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
