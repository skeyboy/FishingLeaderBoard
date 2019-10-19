//
//  FViewCreateFactory.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FViewCreateFactory.h"
#import "UIColor+Additional.h"



@implementation FViewCreateFactory
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
                                      tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    //button.acceptEventInterval = 1.0;
    button.frame = frame;
    if (name)
    {
        [button setTitle:name forState:UIControlStateNormal];
    }
    
    return button;
}
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
                                      tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    //button.acceptEventInterval = 1.0;
    if (name)
    {
        [button setTitle:name forState:UIControlStateNormal];
    }
    
    return button;
}
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
                    textAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = name;
    label.textColor = textColor;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = alignment;
    
    return label;
}
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
                    textAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.text = name;
    label.textColor = textColor;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = alignment;
    
    return label;
}

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
                        textColor:(UIColor *)textColor
{
    return [FViewCreateFactory createLabelWithFrame:frame name:name font:font textColor:textColor textAlignment:NSTextAlignmentCenter];
}


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
                        textColor:(UIColor *)textColor
{
    return [FViewCreateFactory createLabelWithName:name font:font textColor:textColor textAlignment:NSTextAlignmentCenter];
}

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
                                      tag:(NSInteger)tag
{
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:frame];
    if (delegate)
    {
        textFiled.delegate = delegate;
    }
    if (placeHolder)
    {
        textFiled.placeholder = placeHolder;
    }
    textFiled.backgroundColor = [UIColor clearColor];
    textFiled.borderStyle = UITextBorderStyleNone;
    textFiled.tag = tag;
    
    return textFiled;
}
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
                                      tag:(NSInteger)tag
{
    
    UITextField *textFiled = [[UITextField alloc] init];
    if (delegate)
    {
        textFiled.delegate = delegate;
    }
    if (placeHolder)
    {
        textFiled.placeholder = placeHolder;
    }
    textFiled.backgroundColor = [UIColor clearColor];
    textFiled.borderStyle = UITextBorderStyleNone;
    textFiled.tag = tag;
    
    return textFiled;
}

/**
 *  创建ImageView
 *
 *  @param frame     frame
 *  @param imageName 图片名称
 *
 *  @return ImageView
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = frame;
    imageView.userInteractionEnabled = YES;
    
    return imageView;
}
/**
 *  创建ImageView
 *
 *  @param imageName 图片名称
 *
 *  @return ImageView
 */
+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.userInteractionEnabled = YES;
    
    return imageView;
}

/**
 *  创建view
 *
 *  @param frame   frame
 *  @param bgColor 背景颜色
 *
 *  @return UIView
 */
+ (UIView *)createViewWithFrame:(CGRect)frame
                        bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    
    return view;
}
/**
 *  创建view
 *
 *  @param bgColor 背景颜色
 *
 *  @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = bgColor;
    
    return view;
}

/**
 *  创建UIWebView
 *
 *  @param frame   frame
 *  @param loadUrl 加载链接
 *
 *  @return UIWebView
 */
+ (UIWebView *)createWebViewWithFrame:(CGRect)frame
                              loadUrl:(NSString *)loadUrl
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.backgroundColor = CLEARCOLOR;
    
    NSURL *url = [NSURL URLWithString:loadUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    return webView;
}

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
                                  selector:(SEL)selector
{
    UIView *viewTitle = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, SCREEN_WIDTH, 44}];
    //(CGRect){10, 12, 36, 20}
    UIButton *btnCancel = [FViewCreateFactory createCustomButtonWithFrame:(CGRect){CGPointZero, 56, 44} name:@"取消" delegate:delegate selector:selector tag:BUTTON_CANCEL_TAG];
    [btnCancel setTitleColor:[UIColor colorFromHexRGB:@"686868"] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:18];
    [viewTitle addSubview:btnCancel];
    
    UILabel *lblTitle = [FViewCreateFactory createLabelWithFrame:(CGRect){56, 12, SCREEN_WIDTH - 56 * 2, 20} name:strTitle font:[UIFont systemFontOfSize:18] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    lblTitle.tag = 100;
    [viewTitle addSubview:lblTitle];
    
    UIButton *btnSure = [FViewCreateFactory createCustomButtonWithFrame:(CGRect){SCREEN_WIDTH - 56, 0, 56, 44} name:@"确定" delegate:delegate selector:selector tag:BUTTON_SURE_TAG];
    [btnSure setTitleColor:UIColorFromRGB(0x00bca3) forState:UIControlStateNormal];
    btnSure.titleLabel.font = [UIFont systemFontOfSize:18];
    [viewTitle addSubview:btnSure];
    
    //分割线
    UILabel *lblLine = [[UILabel alloc] initWithFrame:(CGRect){0, 43.5, SCREEN_WIDTH, 0.5}];
    lblLine.backgroundColor = [UIColor colorFromHexRGB:SPLIT_LINE_COLOR];
    [viewTitle addSubview:lblLine];
    
    return viewTitle;
}

@end
