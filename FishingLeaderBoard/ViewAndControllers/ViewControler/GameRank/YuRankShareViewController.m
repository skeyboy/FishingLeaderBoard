//
//  YuRankShareViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/16.
//  Copyright © 2020 yue. All rights reserved.
//

#import "YuRankShareViewController.h"
#import "YingXiongBangViewController.h"
#import "RankViewController.h"
@interface YuRankShareViewController (){
    RankViewController * posterVC;
}

@property (weak, nonatomic) IBOutlet UIImageView *saveLocal;
@property (weak, nonatomic) IBOutlet UIImageView *shareTimeline;
@property (weak, nonatomic) IBOutlet UIImageView *shareWX;
@property (weak, nonatomic) IBOutlet UIView *posetContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation YuRankShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self saveLocalPoster];
    [self shareToTimeline];
    [self shareToWX];
    UIView * myContentView = [self renderContentView];
    if (myContentView) {
        UIScrollView * scrollView = [UIScrollView new];
        [scrollView addSubview:myContentView];
        
        [myContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(scrollView);
            make.centerX.equalTo(scrollView.mas_centerX);
            make.width.equalTo(@(self.posetContainerView.width));
        }];
        
        [self.posetContainerView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.posetContainerView);
            make.width.equalTo(self.posetContainerView.mas_width);
        }];
    }else{
        self.contentImageView.image = self.rankImage;
    }
}
-(UIImage *)rankImage{
    return [posterVC.jieTuV snapshotImage];
}
#pragma 分享朋友圈
-(void)shareToTimeline{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shatePosterToTimeLine:)];
    [self.shareTimeline addGestureRecognizer:tap   ];
}

-(void)shatePosterToTimeLine:(UITapGestureRecognizer *) tap{
   NSString * title = @"分享测试";
        NSString * desc = @"我来自钓鱼排行榜分享";
        UIImage * poster = self.rankImage;
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
      UIImage * poster = self.rankImage;
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
    
    UIImageWriteToSavedPhotosAlbum(self.rankImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

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
-(UIView *)renderContentView{
    if (!posterVC) {
        RankViewController * vc = [[RankViewController alloc] init];
        vc.paimingLists = self.paimingLists;
        vc.nameStr = self.nameStr;
           [vc viewDidLoad];
        posterVC = vc;
    }
    
   
    return posterVC.jieTuV;
  
    
}
@end
