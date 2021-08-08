//
//  YuPosterShareViewController.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YuPosterShareViewController.h"
#import "YuWeChatShareManager.h"
#import "UIImageView+QR.h"
#import "GRStarsView.h"
@interface YuPosterShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *saveLocal;
@property (weak, nonatomic) IBOutlet UIImageView *shareTimeline;
@property (weak, nonatomic) IBOutlet UIImageView *shareWX;

//钓场封面
@property (weak, nonatomic) IBOutlet UIImageView *spotImageView;
@property (weak, nonatomic) IBOutlet UILabel *spotNameView;

@property (weak, nonatomic) IBOutlet UILabel *spotAddressView;
@property (weak, nonatomic) IBOutlet UILabel *spotPhoneView;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarView;
@property (weak, nonatomic) IBOutlet UIImageView *qrView;
@property (weak, nonatomic) IBOutlet UILabel *currentUserView;
@property (weak, nonatomic) IBOutlet UIView *starsContainerView;
@property (weak, nonatomic) IBOutlet ColorLabel *right0Label;
@property (weak, nonatomic) IBOutlet ColorLabel *right1Label;
@property (weak, nonatomic) IBOutlet ColorLabel *right2Label;
@property (weak, nonatomic) IBOutlet ColorLabel *right3Label;

@property (weak, nonatomic) IBOutlet UIView *bgView;

//生成snap
@property (weak, nonatomic) IBOutlet UIView *posetContainerView;

@end

@implementation YuPosterShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NAVBGCOLOR;
    self.bgView.backgroundColor = NAVBGCOLOR;
    // Do any additional setup after loading the view from its nib.
    [self saveLocalPoster];
    [self shareToTimeline];
    [self shareToWX];
    self.spotNameView.text = self.spotInfo.name;
    self.spotAddressView.text = self.spotInfo.address;
    self.spotAddressView.text = self.spotInfo.address;
    self.spotPhoneView.text = self.spotInfo.phone;
    self.currentUserView.text = [NSString stringWithFormat:@"%@向您推荐了一个钓场", [AppManager manager].userInfo.nickName];
    [self.spotImageView sd_setImageWithURL:[NSURL URLWithString:[self.spotInfo.posters componentsSeparatedByString:@","][0]]];
   GRStarsView * starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(18, 18) margin:0 numberOfStars:5];
    starsView.frame = CGRectMake(0, 0, self.starsContainerView.frame.size.width, self.starsContainerView.frame.size.height);
    [self.starsContainerView addSubview:starsView];
    starsView.allowSelect = YES;  // 默认可点击
    starsView.allowDecimal = YES;  //默认可显示小数
    starsView.allowDragSelect = NO;//默认不可拖动评分，可拖动下需可点击才有效
    starsView.score = self.spotInfo.status;
    self.right2Label.text =((self.spotInfo.attestation==2)?@"认证":@"");
    self.right0Label.text =((self.spotInfo.activity==2)?@"活动":@"");
    self.right1Label.text =((self.spotInfo.game==2)?@"赛事":@"");
    self.right3Label.text =(([self.spotInfo.spotType intValue]==1)?@"黑坑":
       (([self.spotInfo.spotType intValue]==7)?@"欢乐塘":
    (([self.spotInfo.spotType intValue]==8)?@"练竿塘":
     (([self.spotInfo.spotType intValue]==9)?@"竞技池":
       (([self.spotInfo.spotType intValue]==2)?@"路亚":@"")))));
    IMAGE_LOAD(self.userAvatarView, [AppManager manager].userInfo.headImg)
    IMAGE_LOAD(self.qrImagView, self.spotInfo.miniShare)
    [self.spotImageView mas_updateConstraints:^(MASConstraintMaker *make) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
