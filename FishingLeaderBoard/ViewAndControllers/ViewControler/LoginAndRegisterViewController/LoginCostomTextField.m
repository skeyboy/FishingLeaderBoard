//
//  LoginCostomTextField.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "LoginCostomTextField.h"

@implementation LoginCostomTextField
/**
 *  创建带图标的Textfield
 *
 */
-(instancetype)initLoginCostomTextFieldWithFrame:(CGRect)frame fieldTag:(int)tag fieldPlaceholder:(NSString *)placeholder fieldTarget:(id)target action:(SEL)sel imageName:(NSString *)nameStr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //登录输入框的高度
        loginHeight = CGRectGetHeight(frame);
        loginWidth = CGRectGetWidth(frame);
        //左侧小图标
        UIImageView *ivAccountIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:nameStr]];
        ivAccountIcon.frame = (CGRect){20.f, (loginHeight - 19)/2, 19, 19};
        ivAccountIcon.backgroundColor = CLEARCOLOR;
        [self addSubview:ivAccountIcon];
        
        // 用户名输入框view
        self.textField = [FViewCreateFactory createTextFiledWithFrame:(CGRect){CGRectGetMaxX(ivAccountIcon.frame) + 10.f,  (loginHeight - 38.f)/2, (loginWidth - CGRectGetMaxX(ivAccountIcon.frame) - 10.f), 38.f}
                                                    placeHolder:nil
                                                       delegate:target
                                                            tag:tag];
        self.textField.font = [UIFont systemFontOfSize:12.0f];
        self.textField.textColor = UIColorFromRGB(0x333333);
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.f],
                                                                                       NSForegroundColorAttributeName:UIColorFromRGB(0xcdcdcd)}
                                           ];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.borderStyle = UITextBorderStyleNone;
        [self.textField addTarget:target action:sel forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
        //下划线
        lineName = [FViewCreateFactory createViewWithFrame:(CGRect){10.f, loginHeight-4, SCREEN_WIDTH-20, 0.5} bgColor:[UIColor colorFromHexRGB:@"e5e5e5"]];
        [self addSubview:lineName];
    }

    return self;
}

-(void)setLineViewSelected
{
    NSLog(@"end");
    lineName.backgroundColor = [UIColor greenColor];
    lineName.frame = CGRectMake(10.f, CGRectGetMidY(lineName.frame), CGRectGetWidth(lineName.frame), 2);
}
-(void)setLineViewUnSelected
{
    lineName.backgroundColor = [UIColor colorFromHexRGB:@"e5e5e5"];
    lineName.frame = CGRectMake(10.f, CGRectGetMidY(lineName.frame), CGRectGetWidth(lineName.frame), 0.5);
}

@end
