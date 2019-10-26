//
//  PhotoHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PhotoHeadView.h"

@implementation PhotoHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        float width = frame.size.width/2.0;
        float height = frame.size.height;
        _btnCancel = [self btnTitle:@"取消" image:@"close" tag:0];
        _btnCancel.frame = CGRectMake((width-100)/2.0, Height_StatusBar+5, 100, height-Height_StatusBar-10);
        
        _btnYes = [self btnTitle:@"确定" image:@"check" tag:0];
        _btnYes.frame =CGRectMake(width+(width-100)/2.0, Height_StatusBar+5, 100, height-Height_StatusBar-10);
        
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        
        UIView *line = [FViewCreateFactory createViewWithFrame: CGRectMake(width-0.5,Height_StatusBar + 5, 1, height-10-Height_StatusBar) bgColor:[UIColor lightGrayColor]];
        line.alpha = 0.5;
        [self addSubview:line];
    }
    return self;
}
-(LPButton *)btnTitle:(NSString *)title image:(NSString *)imageStr tag:(int)tag
{
    LPButton *btn  = [[LPButton alloc] init];
    btn.style = LPButtonStyleLeft;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    btn.tag = tag;
    [self addSubview:btn];
    return btn;
}

@end
