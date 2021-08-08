//
//  JhFormConst.h
//  JhForm
//
//  Created by Jh on 2019/1/4.
//  Copyright © 2019 Jh. All rights reserved.
//

/**
 JhFormConst 主要配置表单涉及的相关常量参数，可根据需求修改配置
 */
#import <UIKit/UIKit.h>



/** 表单条目标题颜色 */
#define Jh_titleColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]

/** 表单条目 右侧文本颜色 */
#define Jh_rightTextViewTextColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]

/** 表单条目输入框占位符字体颜色  */
#define Jh_PlaceholderColor [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0]

/** JhFormCellModelTypeTextViewInput 类别 TextView 背景颜色  */
#define Jh_textView_BackgroundColor [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0]


// 表单右侧自定义view的左间距 (默认120)  如果设置 self.Jh_leftTitleWidth ,会变小

// 表单右侧自定义view的右间距
#define  Jh_CustumRightView_rightEdgeMargin   5.0f


/** 获取屏幕宽度  */
#define Jh_SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width


/**
 表单标题字体大小，缺省为15
 */
extern CGFloat const Jh_TitleFont;

/**
 表单详情字体大小，缺省为15
 */
extern CGFloat const Jh_InfoFont;

/**
 表单条目左侧边缘距离，缺省为15.0f
 */
extern CGFloat const Jh_Margin_left;

/**
 表单条目右侧边缘距离，缺省为10.0f
 */
extern CGFloat const Jh_EdgeMargin;

/** 红星在前样式,tilte往左侧偏移量 */
extern CGFloat const Jh_redStarLeftOffset;

/**
 表单底部线距离左侧边缘距离，缺省为16.0f (尽量不要动,只在几个cell中使用了)
 */
extern CGFloat const Jh_LineEdgeMargin;

/**
 表单标题宽度，缺省为100.0f
 */
extern CGFloat const Jh_TitleWidth;

/**
 表单标题高度，缺省为24.0f
 */
extern CGFloat const Jh_TitleHeight;

/**
 表单Cell高度，
 JhFormCellModelTypeTextViewInput 类型缺省高度为150 ，选择图片和自定义底部 264,  其余 缺省为44.0f， 为确保显示正常，设置值>= 44
 
 */
extern CGFloat const Jh_DefaultCellHeight; //44
extern CGFloat const Jh_DefaultTextViewCellHeight;  //150
extern CGFloat const Jh_DefaultCustumBottomViewCellHeight; //264
extern CGFloat const Jh_DefaultSelectImageCellHeight; //264


/**
 表单输入字数限制，缺省为50
 0 表示无限制
 */
extern NSUInteger const Jh_GlobalMaxInputLength;

/**
 表单选择图片附件数，缺省为8
 */
extern NSUInteger const Jh_GlobalMaxImages;

///**
// 表单图片条目图片加载失败占位图
// */
//extern NSString *const Jh_PlaceholderImage;
//
///**
// 表单附件删除图标
// */
//extern NSString *const Jh_DeleteIcon;

/**
表单添加图标
*/
extern NSString *const Jh_AddIcon;


/**
 表单TextView字数提示文字大小
 */
extern CGFloat const Jh_LengHintFont;






