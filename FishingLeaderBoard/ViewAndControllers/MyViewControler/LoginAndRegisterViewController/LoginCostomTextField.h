//
//  LoginCostomTextField.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginCostomTextField : UIView
{
    UIView *lineName;
    //登录输入框的高度
    float loginHeight;
    
    float loginWidth;
}
@property(strong,nonatomic)UITextField *textField;
/**
 *  创建带图标的Textfield
 *
 */
-(instancetype)initLoginCostomTextFieldWithFrame:(CGRect)frame fieldTag:(int)tag fieldPlaceholder:(NSString *)placeholder fieldTarget:(id)target action:(SEL)sel imageName:(NSString *)nameStr;

-(void)setLineViewSelected;
-(void)setLineViewUnSelected;

@end

NS_ASSUME_NONNULL_END
