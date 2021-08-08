//
//  YuShareGameViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YuShareGameViewController.h"
#import "YuWeChatShareManager.h"
@interface YuShareGameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *saveLocal;
//生成snap
@property (weak, nonatomic) IBOutlet UIView *posetContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *shareTimeline;
@property (weak, nonatomic) IBOutlet UIImageView *shareWX;

/// 封面
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
/// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleView;
///活动时间
@property (weak, nonatomic) IBOutlet UILabel *activeTimeView;
//截止时间
@property (weak, nonatomic) IBOutlet UILabel *deadlineView;
// 地址
@property (weak, nonatomic) IBOutlet UILabel *addressView;
// 电话
@property (weak, nonatomic) IBOutlet UILabel *phoneVIew;
//分享人头像
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
//分享人
@property (weak, nonatomic) IBOutlet UILabel *sharedUserView;

@end

@implementation YuShareGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NAVBGCOLOR;
    // Do any additional setup after loading the view from its nib.
    IMAGE_LOAD(self.coverImageView, self.eventGameDetail.coverImage)
    if(self.isOrder == 1)
    {
        self.titleView.text = self.eventGameDetail.name;
    }else{
    self.titleView.text = [self.eventGameDetail shareTtitleInfo];
    }
    self.activeTimeView.text = [ToolClass dateToString2:self.eventGameDetail.startTime];
    self.deadlineView.text = [ToolClass dateToString2:self.eventGameDetail.endTime];
    self.addressView.text = self.eventGameDetail.address;
    self.phoneVIew.text = self.eventGameDetail.phone;
    self.sharedUserView.text = [NSString stringWithFormat:@"%@向您推荐一个赛事",[AppManager manager].userInfo.nickName];
    IMAGE_LOAD(self.min_appImg, self.eventGameDetail.miniShare);
    IMAGE_LOAD(self.avatarView, [AppManager manager].userInfo.headImg)
    
    [self saveLocalPoster];
       [self shareToTimeline];
       [self shareToWX];
    
  
    [self.coverImageView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@(HomeNewsBannerHeight));
       }];
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
