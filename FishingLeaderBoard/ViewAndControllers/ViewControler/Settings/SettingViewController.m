//
//  SettingViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/8.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIView *versionActionView;
@property (weak, nonatomic) IBOutlet UIView *aboutUsActionView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"系统设置"
                   isShowBack:YES];
    
    UITapGestureRecognizer * versionAction = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(versionAction:)];
    [self.versionActionView addGestureRecognizer:versionAction];
    
    UITapGestureRecognizer * aboutUsAction = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(aboutAction:)];
       [self.aboutUsActionView addGestureRecognizer:aboutUsAction];
}
-(void)versionAction:(id) sender{
    
}
-(void)aboutAction:(id) sender{
    AboutUsViewController *aboutUsVc =[[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:aboutUsVc
                                         animated:YES];
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
