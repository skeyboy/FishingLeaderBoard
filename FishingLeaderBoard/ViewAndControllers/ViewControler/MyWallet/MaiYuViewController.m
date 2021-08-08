//
//  MaiYuViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MaiYuViewController.h"
#import "YuQrCreateHelper.h"
@interface MaiYuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myQrImageView;

@end

@implementation MaiYuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = NAVBGCOLOR;
    [self setNavViewWithTitle:@"收款码" isShowBack:YES];
    NSError *qrCreateError = nil;
    NSString *heads = ([AppManager manager].userInfo.headImg==nil)?@"":[AppManager manager].userInfo.headImg;
    NSString *nickName =([AppManager manager].userInfo.nickName==nil)?@"":[AppManager manager].userInfo.nickName;
    NSString *str = [NSString stringWithFormat:@"%ld#%@#%@",[AppManager manager].userInfo.id,heads,nickName];
    str =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  self.myQrImageView.image =  [YuQrCreateHelper createQr:str imageSize:self.myQrImageView.frame.size
                     withError:&qrCreateError];
    if (qrCreateError!=nil) {
        [self showWithInfo:@"二维码生成出错" delayToHideAfter:0.75];
    }
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
