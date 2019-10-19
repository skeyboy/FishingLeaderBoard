//
//  FNavigationView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FViewCreateFactory.h"
#import "UIColor+Additional.h"
#import "LPButton.h"
NS_ASSUME_NONNULL_BEGIN

#define NAVIGATIONVIEW_LEFTBUTTON_TAG 20000  //!<导航视图左侧按钮TAG
#define NAVIGATIONVIEW_RIGHTBUTTON_TAG 20001  //!<导航视图右侧按钮TAG

typedef void(^SearchClick) (UISearchBar *);


@interface FNavigationView : UIView

@property (nonatomic, strong) UILabel *lblTitle;    //!<标题
@property (nonatomic, retain) UIView  *navLineView;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) SearchClick searchClick;

/**
 *  设置导航视图标题
 *
 *  @param title 标题
 */
- (void)setNavBarViewTitle:(NSString *)title;

/**
 *  初始化导航视图返回按钮
 *
 *  @param target    事件响应者
 *  @param action    响应函数
 */
- (void)setNavBarViewBackBtnWithtarget:(id)target
                                action:(SEL)action;

/**
 *  初始化导航视图左侧按钮(不带标题的)
 *
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewLeftBtnWithNormalImage:(NSString *)normalImage
                           highlightedImage:(NSString *)highlightedImage
                                     target:(id)target
                                     action:(SEL)action;

/**
 *  设置左侧返回按钮tag值
 *
 */
-(void)setNavBarViewLeftBtnTag:(NSInteger)tag;
/**
 *  设置右侧返回按钮tag值
 *
 */
-(void)setNavBarViewRightBtnTag:(NSInteger)tag;

/**
 *  初始化导航视图左侧按钮(带标题的)
 *
 *  @param title            标题
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewLeftBtnWithTitle:(NSString *)title
                          normalImage:(NSString *)normalImage
                     highlightedImage:(NSString *)highlightedImage
                               target:(id)target
                               action:(SEL)action;

/**
 *  初始化导航视图右侧按钮(不带标题的)
 *
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewRightBtnWithNormalImage:(NSString *)normalImage
                            highlightedImage:(NSString *)highlightedImage
                                      target:(id)target
                                      action:(SEL)action;
-(void)setNavLineHidden;


/**
 *  更新导航栏右侧按钮图标
 *
 *  @param imageName 图标名称
 */
- (void)updateRightBtnImage:(NSString *)imageName;

/**
 *  初始化右侧按钮(带标题的)
 *
 *  @param title            标题
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewRightBtnWithTitle:(NSString *)title
                           normalImage:(NSString *)normalImage
                      highlightedImage:(NSString *)highlightedImage
                                target:(id)target
                                action:(SEL)action;

/**
 *  初始化右侧按钮(带标题的)
 *
 *  @param title            标题
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewRightBtnWithTitle:(NSString *)title
                           normalImage:(NSString *)normalImage
                      highlightedImage:(NSString *)highlightedImage
                             titleFont:(float )fontSize
                                target:(id)target
                                action:(SEL)action;


/**
 *  获取右侧按钮
 */
-(UIButton *)getNavBarRightBtn;

/**
 *  获取左侧按钮
 */
-(UIButton *)getNavBarLeftBtn;

/**
 *  设置左侧返回键为白色按钮
 */
-(void)setNavLeftWhiteBack;

- (UILabel *)getNavBarTitleLabel;

- (void)setNavBarViewCenterSearchTag:(int)tag;

- (void)setNavBarViewRightBtnWithName:(NSString *)nameStr
                               target:(id)target
                               action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
