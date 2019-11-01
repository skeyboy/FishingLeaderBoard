//
//  FViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewController.h"

@interface FViewController ()<CAAnimationDelegate>
{
    BaseViewClickBlock  clickBlock;
}

@end

@implementation FViewController

- (id)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.title = title;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.modalPresentationCapturesStatusBarAppearance = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - 导航动画效果

////模态视图动画
//- (void)createViewCtrl:(UIViewController *)viewCtrl
//{
//    viewCtrl.modalPresentationStyle = UIModalPresentationCustom;
//    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:viewCtrl];
//    self.animator.dragable = NO;
//    self.animator.bounces = NO;
//    self.animator.behindViewAlpha = 1.0f;
//    self.animator.behindViewScale = 1.0f;
//    self.animator.transitionDuration = 0.7f;
//    self.animator.direction = ZFModalTransitonDirectionRight;
//
//    viewCtrl.transitioningDelegate = self.animator;
//    [self presentViewController:viewCtrl animated:NO completion:nil];
//}

////模态视图渐变消失
//- (void)dismissModalViewAnimated
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.backgroundColor = CLEARCOLOR;
//        self.view.alpha = 0.1;
//    }completion:^(BOOL finished) {
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }];
//}

/**
 *  设置导航页面进入动画(上去)
 */
- (void)setViewControllerPushAnimation
{
    CATransition *showTransition = [CATransition animation];
    showTransition.duration = 0.3f;
    showTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showTransition.type = @"moveIn";
    showTransition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:showTransition forKey:@"showTransition"];
}

/**
 *  设置导航页面弹出动画(下来)
 */
- (void)setViewControllerPopAnimation
{
    CATransition *showTransition = [CATransition animation];
    showTransition.duration = 0.3f;
    showTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showTransition.type = @"reveal";
    showTransition.subtype = kCATransitionFromBottom;
    showTransition.delegate = self;
    [self.navigationController.view.layer addAnimation:showTransition forKey:@"showTransition"];
}

/**
 *  设置页面出现时的动画(右)
 */
- (void)setViewControllerAnimationRight
{
    CATransition *showTransition = [CATransition animation];
    showTransition.duration = 0.7f;
    showTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showTransition.type = @"moveIn";
    showTransition.subtype = kCATransitionFromRight;
    showTransition.delegate = self;
    [self.navigationController.view.layer addAnimation:showTransition forKey:@"showTransition"];
}

/**
 *  设置页面出现时的动画(左)
 */
- (void)setViewControllerAnimationLeft
{
    CATransition *showTransition = [CATransition animation];
    showTransition.duration = 0.3f;
    showTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showTransition.type = @"moveIn";
    showTransition.subtype = kCATransitionFromLeft;
    showTransition.delegate = self;
    [self.navigationController.view.layer addAnimation:showTransition forKey:@"showTransition"];
}

#pragma mark - 导航栏视图

/**
 *  设置导航栏视图
 *
 *  @param title      导航栏标题
 *  @param isShowBack 是否显示返回按钮
 */
- (void)setNavViewWithTitle:(NSString *)title
                 isShowBack:(BOOL)isShowBack
{
    hkNavigationView = [[FNavigationView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, Height_NavBar}];
    [hkNavigationView setNavBarViewTitle:title];
    if (isShowBack)
    {
        [hkNavigationView setNavBarViewLeftBtnWithNormalImage:@"nav_back_nor"
                                             highlightedImage:@"nav_back_nor"
                                                       target:self
                                                       action:@selector(btnClickBack)];
    }
    [self.view addSubview:hkNavigationView];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
}

/**
 *  设置导航栏视图
 *
 *  @param title      导航栏标题
 *  @param isShowBack 是否显示返回按钮
 */
- (void)setNavViewWithTitle:(NSString *)title
                 isShowBack:(BOOL)isShowBack inView:(UIView *)superView
{
    hkNavigationView = [[FNavigationView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, Height_NavBar}];
    [hkNavigationView setNavBarViewTitle:title];
    if (isShowBack)
    {
        [hkNavigationView setNavBarViewLeftBtnWithNormalImage:@"nav_back_nor"
                                             highlightedImage:@"nav_back_nor"
                                                       target:self
                                                       action:@selector(btnClickBack)];
    }
    [superView addSubview:hkNavigationView];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
}
- (void)btnClickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

///**
// *  设置导航栏视图及模态返回
// *
// *  @param title  标题
// *  @param isBack 是否需要模态返回
// */
//- (void)setNavViewTitle:(NSString *)title
//                 isBack:(BOOL)isBack
//{
//    hkNavigationView = [[HKNavigationView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT}];
//    [hkNavigationView setNavBarViewTitle:title];
//    if (isBack)
//    {
//        [hkNavigationView setNavBarViewLeftBtnWithNormalImage:@"nav_back_nor"
//                                             highlightedImage:@"nav_back_nor"
//                                                       target:self
//                                                       action:@selector(ClickBack)];
//    }
//
//    [self.view addSubview:hkNavigationView];
//}
//
//- (void)ClickBack
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
/**
 *  倒计时方法
 *
 *  @param totalTime        总时长(以秒为单位)
 *  @param intervalRetBlock 中间间隔时间回调(每秒调一次)
 *  @param completeRetBlock 计时完成时回调
 */
- (void)startTimingWithTotalTime:(int)totalTime
                intervalRetBlock:(void(^)(int iRemainTime))intervalRetBlock
                completeRetBlock:(void(^)(void))completeRetBlock
{
    __block int timeout = totalTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.f * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 1)
        {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                completeRetBlock();
            });
        }
        else
        {
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                intervalRetBlock(timeout);
            });
        }
    });
    dispatch_resume(timer);
}


@end
