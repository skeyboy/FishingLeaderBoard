//
//  LoginAndRegisterViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "YHSegmentView.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginAndRegisterViewController ()

@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self setNavViewWithTitle:@"欢迎来到钓鱼排行榜" isShowBack:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self initWidget];
}
-(void)initWidget
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"登录",@"注册"];
    LoginViewController *loginView = [[LoginViewController alloc]init];
    RegisterViewController *registerView = [[RegisterViewController alloc]init];
    registerView.pageType = FPageTypeRegist;
    [mutArr addObjectsFromArray:@[loginView,registerView]];
    YHSegmentView *segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame)-1, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(hkNavigationView.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
        [loginView.accountTextField.textField resignFirstResponder];
        [loginView.psdTextField.textField resignFirstResponder];
        [registerView.phoneTextField.textField resignFirstResponder];
        [registerView.psdTextField.textField resignFirstResponder];
        [registerView.comfirmPsdField.textField resignFirstResponder];
        [registerView.verificationTextField.textField resignFirstResponder];
    }];
    
     segmentView.yh_titleSelectedColor = [UIColor groupTableViewBackgroundColor];
     [segmentView setSelectedItemAtIndex:1];
     segmentView.yh_segmentTintColor = [UIColor groupTableViewBackgroundColor];
     segmentView.yh_bgColor = NAVBGCOLOR;
    [self.view addSubview:segmentView];
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
