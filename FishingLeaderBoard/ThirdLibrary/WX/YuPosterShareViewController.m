//
//  YuPosterShareViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YuPosterShareViewController.h"
#import "YuWeChatShareManager.h"
@interface YuPosterShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *saveLocal;
@property (weak, nonatomic) IBOutlet UIImageView *shareTimeline;
@property (weak, nonatomic) IBOutlet UIImageView *shareWX;
@property (weak, nonatomic) IBOutlet UIImageView *poster;

@end

@implementation YuPosterShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.poster sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.bdstatic.com/8_V1bjqh_Q23odCf/pacific/1844741384.jpg"]];
    [self saveLocalPoster];
    [self shareToTimeline];
    [self shareToWX];
}
#pragma 分享朋友圈
-(void)shareToTimeline{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shatePosterToTimeLine:)];
    [self.shareTimeline addGestureRecognizer:tap   ];
}
-(void)shatePosterToTimeLine:(UITapGestureRecognizer *) tap{
    NSString * title = @"";
    NSString * desc = @"";
    UIImage * poster = self.poster.image;
    NSString * url = @"";
    [YuWeChatShareManager shareToWechatWithWebTitle:title description:desc thumbImage:poster webpageUrl:url type:WXSceneTimeline];
}
#pragma 分享到微信
-(void)shareToWX{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharePosterToWX:)];
                                   
    [self.shareWX addGestureRecognizer:tap];
}
-(void)sharePosterToWX:(UITapGestureRecognizer *) tap{
    NSString * title = @"";
      NSString * desc = @"";
      UIImage * poster = self.poster.image;
      NSString * url = @"";
      [YuWeChatShareManager shareToWechatWithWebTitle:title description:desc thumbImage:poster webpageUrl:url type:WXSceneSession];
}
#pragma 海报保存本地
-(void)saveLocalPoster{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveToLocal:)];
    [self.saveLocal addGestureRecognizer:tap];
}
-(void)saveToLocal:(id) sender {
    UIImageWriteToSavedPhotosAlbum(self.poster.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}



- (IBAction)cancalPosterShareVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
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
