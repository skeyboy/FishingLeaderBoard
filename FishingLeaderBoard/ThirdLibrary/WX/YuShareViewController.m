//
//  YuShareViewController.m
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import "YuShareViewController.h"
#import "YuWeChatShareManager.h"
#import "WXApiObject.h"
@interface YuShareViewController ()
@property (weak, nonatomic) IBOutlet UIView *wxShareContainer;
@property (weak, nonatomic) IBOutlet UIView *wxFriendShare;

@end

@implementation YuShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NAVBGCOLOR;
    
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer * friendShareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareToQuan:)];
    [self.wxFriendShare addGestureRecognizer:friendShareTap];
}

-(void)shareToQuan:(UITapGestureRecognizer *)tap{
 [YuWeChatShareManager shareToWechatWithWebTitle:self.shareTittle
                                     description:self.shareContent thumbImage:self.shareImage webpageUrl:self.shareUrl type:WXSceneTimeline];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    return;

    [self dismissViewControllerAnimated:YES
                                completion:^{
           
       }];
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
