//
//  ReleaseFishGetViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ReleaseFishGetViewController.h"

@interface ReleaseFishGetViewController ()

@end

@implementation ReleaseFishGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setNavViewWithTitle:@"发布渔获" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    ChooseMutlPicturesView *choosePictureView =[[ChooseMutlPicturesView alloc]init];
    [self.view addSubview:choosePictureView];
    [choosePictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(hkNavigationView.mas_bottom).offset(30);
        make.height.equalTo(@(200));
    }];
}
@end
