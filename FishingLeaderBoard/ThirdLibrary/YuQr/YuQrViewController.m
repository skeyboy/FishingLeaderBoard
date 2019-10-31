//
//  YuQrViewController.m
//  QrScan
//
//  Created by sk on 2019/10/28.
//  Copyright © 2019 sk. All rights reserved.
//

#import "YuQrViewController.h"
#import "LBXScanViewController.h"
#import "LBXScanViewStyle.h"
#import "YuQrViewController.h"

@interface YuQrViewController ()<LBXScanViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *qrBackBtn;

@end

@implementation YuQrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showQr];

}
-(void)showQr{
      //设置扫码区域参数
            LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
            style.centerUpOffset = 44;
            style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
            style.photoframeLineW = 3;
            style.photoframeAngleW = 18;
            style.photoframeAngleH = 18;
            style.isNeedShowRetangle = NO;
            style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;

            //qq里面的线条图片
            UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
            style.animationImage = imgLine;

            style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            LBXScanViewController *vc = [[LBXScanViewController alloc] init];
        vc.delegate = self;
    //        vc.style = style;
        [vc setValue:style forKey:@"style"];
            vc.isOpenInterestRect = YES;
            vc.libraryType = SLT_ZBar;
        vc.scanCodeType = SCT_QRCode;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [self.view bringSubviewToFront:self.qrBackBtn];
 
}

- (IBAction)dismissQrViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)scanResultWithArray:(NSArray<LBXScanResult *> *)array{
    if (self.qrDelegate) {
        [self.qrDelegate yuQrScanResultWithArray:array];
    }
    if (self.qrResult) {
        self.qrResult(array);
    }
}

@end
