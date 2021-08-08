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
        self.backgroundColor=[UIColor whiteColor];
        float width = frame.size.width/2.0;
        float height = frame.size.height;
        _btnCancel = [self btnTitle:@"取消" tag:0];
        _btnCancel.frame = CGRectMake((width-100)/2.0, Height_StatusBar+5, 100, height-Height_StatusBar-10);
        
        _btnYes = [self btnTitle:@"确定" tag:0];
        _btnYes.frame =CGRectMake(width+(width-100)/2.0, Height_StatusBar+5, 100, height-Height_StatusBar-10);
        
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        
    }
    return self;
}
-(UIButton *)btnTitle:(NSString *)title tag:(int)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.tag = tag;
    [self addSubview:btn];
    return btn;
}

@end
