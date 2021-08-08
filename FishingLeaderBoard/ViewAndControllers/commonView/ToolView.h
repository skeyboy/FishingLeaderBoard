//
//  LunBoView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPButton.h"
#import "JJImagePicker.h"
#import "WMZBannerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolView : UIView

//轮播图
+(void)getLunBoViewHeight:(float)height width:(float)width y:(float)y x:(float)x superView:(UIView *)superView data:(NSArray *)dataArr clickBlock:(BannerClickBlock)click;
//带图标的button 
+(LPButton *)btnTitle:(NSString *)title image:(NSString *)imageStr tag:(int)tag superView:(UIView *)superView sel:(SEL)sel targer:(id)targer setStyle:(LPButtonStyle)style font:(int)font;
//签到
+(UIView*)jiFenShowView:(int)lianX all:(NSArray*)allArr superView:(UIView*)superView;

+(UIView *)addShadowRadius:(UIView *)view;
//选照片初始化
+(JJImagePicker *)selectImageFromAlbum;

@end
@interface WMBannerCellModel : NSObject
@property(strong,nonatomic)NSString *imageName;
@property(strong,nonatomic)NSString *leftStr;
@end
 
NS_ASSUME_NONNULL_END
