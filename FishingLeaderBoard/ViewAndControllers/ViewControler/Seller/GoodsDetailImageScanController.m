//
//  GoodsDetailImageScanController.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/20.
//  Copyright © 2020 yue. All rights reserved.
//

#import "GoodsDetailImageScanController.h"

@interface GoodsDetailImageScanController ()<UIScrollViewDelegate>
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIImageView *imageView;
   __weak IBOutlet  UIScrollView *scrolleView;
    UIImageView *imgV;
}

@end

@implementation GoodsDetailImageScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavViewWithTitle:@"详情预览" isShowBack:YES];
   //初始化滚动视图

     
    IMAGE_LOAD(imageView, self.imageUrl);
    scrolleView.delegate = self;
        [scrolleView addSubview:imgV];

        //设置代理,设置最大缩放和虽小缩放
        scrolleView.delegate = self;
        scrolleView.maximumZoomScale = 5;
        scrolleView.minimumZoomScale = 0.1;
    scrolleView.bouncesZoom = NO;
    scrolleView.zoomScale =1;
        //设置UIScrollView的滚动范围和图片的真实尺寸一致
        scrolleView.contentSize = self.view.frame.size;
    scrolleView.contentSize = imageView.image.size;

    [self makeToask:@"缩放查看图文介绍"];
    }

    //代理方法，告诉ScrollView要缩放的是哪个视图
    -(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
    {
        return contentView;
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
