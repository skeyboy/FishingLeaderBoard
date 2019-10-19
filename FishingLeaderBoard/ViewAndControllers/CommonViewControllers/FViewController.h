//
//  FViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNavigationView.h"
#import "UIColor+Additional.h"
#import "FViewCreateFactory.h"

NS_ASSUME_NONNULL_BEGIN

#define BUTTON_BACK_TAG 200  //!<自定义返回按钮TAG

typedef void(^BaseViewClickBlock) (NSInteger tag);  //基类按钮单击回调block

@interface FViewController : UIViewController
{
    UIImageView         *shadowBackGroundImage;  //!<黑色背景
    FNavigationView     *hkNavigationView;  //!<导航栏视图
}

//@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

- (id)initWithTitle:(NSString *)title;

#pragma mark - 导航动画效果
- (void)btnClickBack;
///**
// *  设置模态视图左边动画
// *
// *  @param viewCtrl viewCtrl
// */
//- (void)createViewCtrl:(UIViewController *)viewCtrl;
//
////模态视图渐变消失；
//- (void)dismissModalViewAnimated;

/**
 *  设置导航页面进入动画
 */
- (void)setViewControllerPushAnimation;

/**
 *  设置导航页面弹出动画
 */
- (void)setViewControllerPopAnimation;

/**
 *  设置导航页面动画(右)
 */
- (void)setViewControllerAnimationRight;

/**
 *  设置导航页面动画(左)
 */
- (void)setViewControllerAnimationLeft;

#pragma mark - 导航栏视图

/**
 *  设置导航栏视图
 *
 *  @param title      导航栏标题
 *  @param isShowBack 是否显示返回按钮
 */
- (void)setNavViewWithTitle:(NSString *)title
                 isShowBack:(BOOL)isShowBack;

///**
// *  设置导航栏视图及模态返回
// *
// *  @param title  标题
// *  @param isBack 是否需要模态返回
// */
//- (void)setNavViewTitle:(NSString *)title
//                 isBack:(BOOL)isBack;


/**
 *  倒计时方法
 *
 *  @param totalTime        总时长(以秒为单位)
 *  @param intervalRetBlock 中间间隔时间回调(每秒调一次)
 *  @param completeRetBlock 计时完成时回调
 */
- (void)startTimingWithTotalTime:(int)totalTime
                intervalRetBlock:(void(^)(int iRemainTime))intervalRetBlock
                completeRetBlock:(void(^)(void))completeRetBlock;
@end

NS_ASSUME_NONNULL_END
