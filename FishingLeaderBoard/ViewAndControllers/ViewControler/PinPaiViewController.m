//
//  PinPaiViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/13.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PinPaiViewController.h"

@interface PinPaiViewController ()

@end

@implementation PinPaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      self.view.backgroundColor = WHITECOLOR;
      [self setNavViewWithTitle:@"品牌赛事" isShowBack:YES];
      hkNavigationView.backgroundColor = NAVBGCOLOR;
    UIScrollView *bgS = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(hkNavigationView.frame))];
    [self.view addSubview:bgS];
    UIImageView *imageView = [FViewCreateFactory createImageViewWithImageName:@"pinPaiImage"];
    imageView.userInteractionEnabled = YES;
    [bgS addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgS.mas_left).offset(0);
        make.right.equalTo(bgS.mas_right).offset(0);
        make.top.equalTo(bgS.mas_top).offset(0);
        make.height.equalTo(@700);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(bgS.mas_bottom).offset(10);
    }];
}


@end
