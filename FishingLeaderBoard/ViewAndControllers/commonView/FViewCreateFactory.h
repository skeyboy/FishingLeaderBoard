//
//  FViewCreateFactory.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FViewCreateFactory : NSObject
/**
 *  创建Button
 *
 *  @param frame    frame
 *  @param name     名称
 *  @param delegate 代理
 *  @param selector 选择器
 *  @param tag      TAG
 *
 *  @return Button
 */
+ (UIButton *)createCustomButtonWithFrame:(CGRect)frame
                                     name:(NSString *)name
                                 delegate:(id)delegate
                                 selector:(SEL)selector
                                      tag:(NSInteger)tag;
/**
 *  创建Button
 *
 *  @param name     名称
 *  @param delegate 代理
 *  @param selector 选择器
 *  @param tag      TAG
 *
 *  @return Button
 */
+ (UIButton *)createCustomButtonWithName:(NSString *)name
                                 delegate:(id)delegate
                                 selector:(SEL)selector
                                      tag:(NSInteger)tag;

/**
 *  创建Label
 *
 *  @param frame     frame
 *  @param name      名称
 *  @param font      字体
 *  @param textColor 字体颜色
 *  @param alignment alignment
 *
 *  @return Label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             name:(NSString *)name
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)alignment;
/**
 *  创建Label
 *
 *  @param name      名称
 *  @param font      字体
 *  @param textColor 字体颜色
 *  @param alignment alignment
 *
 *  @return Label
 */
+ (UILabel *)createLabelWithName:(NSString *)name
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)alignment;

/**
 *  创建Label (居中对齐)
 *
 *  @param frame     frame
 *  @param name      名称
 *  @param font      字体
 *  @param textColor 字体颜色
 *
 *  @return Label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             name:(NSString *)name
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor;
/**
 *  创建Label (居中对齐)
 *
 *  @param name      名称
 *  @param font      字体
 *  @param textColor 字体颜色
 *
 *  @return Label
 */
+ (UILabel *)createLabelWithName:(NSString *)name
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor;

/**
 *  创建TextField
 *
 *  @param frame       frame
 *  @param placeHolder 默认文字
 *  @param delegate    代理
 *  @param tag         Tag
 *
 *  @return TextField
 */
+ (UITextField *)createTextFiledWithFrame:(CGRect)frame
                              placeHolder:(NSString *)placeHolder
                                 delegate:(id)delegate
                                      tag:(NSInteger)tag;
/**
 *  创建TextField
 *
 *  @param placeHolder 默认文字
 *  @param delegate    代理
 *  @param tag         Tag
 *
 *  @return TextField
 */
+ (UITextField *)createTextFiledWithPlaceHolder:(NSString *)placeHolder
                                 delegate:(id)delegate
                                      tag:(NSInteger)tag;

/**
 *  创建ImageView
 *
 *  @param frame     frame
 *  @param imageName 图片名称
 *
 *  @return ImageView
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName;
/**
 *  创建ImageView
 *
 *  @param imageName 图片名称
 *
 *  @return ImageView
 */
+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName;

/**
 *  创建view
 *
 *  @param frame   frame
 *  @param bgColor 背景颜色
 *
 *  @return UIView
 */
+ (UIView *)createViewWithFrame:(CGRect)frame
                        bgColor:(UIColor *)bgColor;
/**
 *  创建view
 *
 *  @param bgColor 背景颜色
 *
 *  @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor;

/**
 *  创建UIWebView
 *
 *  @param frame   frame
 *  @param loadUrl 加载链接
 *
 *  @return UIWebView
 */
+ (UIWebView *)createWebViewWithFrame:(CGRect)frame
                              loadUrl:(NSString *)loadUrl;


/**
 *  创建Picker的标题视图
 *
 *  @param strTitle 标题
 *  @param delegate 代理
 *  @param selector 选择器
 *
 *  @return 自定义Picker的标题视图
 */
+ (UIView *)createPickerTitleViewWithTitle:(NSString *)strTitle
                                  delegate:(id)delegate
                                  selector:(SEL)selector;


@end

NS_ASSUME_NONNULL_END
