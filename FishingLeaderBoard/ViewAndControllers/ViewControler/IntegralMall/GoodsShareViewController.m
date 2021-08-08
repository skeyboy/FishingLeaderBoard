//
//  GoodsShareViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/27.
//  Copyright © 2020 yue. All rights reserved.
//

#import "GoodsShareViewController.h"

@interface GoodsShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *miniShareImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property (weak, nonatomic) IBOutlet UIImageView *saveLocal;
//生成snap
@property (weak, nonatomic) IBOutlet UIImageView *posetContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *shareTimeline;
@property (weak, nonatomic) IBOutlet UIImageView *shareWX;


@end

@implementation GoodsShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = NAVBGCOLOR;
    IMAGE_LOAD(self.miniShareImageView, self.miniShareUrl)
    IMAGE_LOAD(self.coverImageView, self.goodsImageUrl)
    [self shareToTimeline];
    [self shareToWX];
    [self saveLocalPoster];
    self.posetContainerView.image = [UIImage imageNamed:@"goods_share_bg"];
    self.titleView.text = self.title;
}

#pragma 分享朋友圈
-(void)shareToTimeline{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shatePosterToTimeLine:)];
    [self.shareTimeline addGestureRecognizer:tap   ];
}
-(void)shatePosterToTimeLine:(UITapGestureRecognizer *) tap{
   NSString * title = @"分享测试";
        NSString * desc = @"我来自钓鱼排行榜分享";
        UIImage * poster = self.posetContainerView.snapshotImage;
        NSString * url = @"https://www.baidu.com";
    [YuWeChatShareManager shareToWechatWithImage:poster
                                      thumbImage:poster type:WXSceneTimeline];
//    [YuWeChatShareManager shareToWechatWithWebTitle:title description:desc thumbImage:poster webpageUrl:url type:WXSceneTimeline];
}
#pragma 分享到微信
-(void)shareToWX{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharePosterToWX:)];
                                   
    [self.shareWX addGestureRecognizer:tap];
}
-(void)sharePosterToWX:(UITapGestureRecognizer *) tap{
    NSString * title = @"分享测试";
      NSString * desc = @"我来自钓鱼排行榜分享";
      UIImage * poster = self.posetContainerView.snapshotImage;
      NSString * url = @"https://www.baidu.com";
    [YuWeChatShareManager shareToWechatWithImage:poster
                                      thumbImage:poster type:WXSceneSession];
    
//      [YuWeChatShareManager shareToWechatWithWebTitle:title
//                                          description:desc
//                                           thumbImage:poster
//                                           webpageUrl:url type:WXSceneSession];
}
#pragma 海报保存本地
-(void)saveLocalPoster{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveToLocal:)];
    [self.saveLocal addGestureRecognizer:tap];
}
-(void)saveToLocal:(id) sender {
    
    UIImageWriteToSavedPhotosAlbum(self.posetContainerView.snapshotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
[self showWithInfo:msg
   delayToHideAfter:0.75];
}



- (IBAction)cancalPosterShareVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
