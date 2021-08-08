//
//  JGProgressView.m
//  JGProgressDemo
//
//  Created by 郭军 on 2017/9/1.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import "JGProgressView.h"

#define KProgressPadding 12.0f
#define KProgressLineWidth 8.0f



@implementation JGProgressView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        
       
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat heigth = self.bounds.size.height;
    
    int Count = maxWidth / (KProgressPadding + KProgressLineWidth);
    int LCount = maxWidth * progress / (KProgressPadding + KProgressLineWidth);
    for (int i = 0 ; i < Count; i++) {
        CGFloat X = i * (KProgressLineWidth + KProgressPadding);
        UIView *Line = [[UIView alloc] initWithFrame:CGRectMake(X, 0, KProgressLineWidth, heigth)];
        Line.backgroundColor = (i < LCount) ? [UIColor blueColor] : WHITECOLOR;
        Line.alpha =(i < LCount) ? 1:0.1;
        [self addSubview:Line];
        if(i==LCount-1)
        {
            i++;
            float lastCount = maxWidth * progress / (KProgressPadding + KProgressLineWidth);
        
                float lastf = lastCount-LCount;
                CGFloat X = i * (KProgressLineWidth + KProgressPadding);;
                UIView *Line = [[UIView alloc] initWithFrame:CGRectMake(X, 0, KProgressLineWidth*lastf, heigth)];
                Line.backgroundColor =[UIColor blueColor];
                [self addSubview:Line];
                X=X+KProgressLineWidth*lastf;
                Line = [[UIView alloc] initWithFrame:CGRectMake(X, 0, KProgressLineWidth*(1-lastf), heigth)];
                Line.backgroundColor =[UIColor whiteColor];
                Line.alpha = 0.1;
                [self addSubview:Line];
            
            
        }
    }
    
    if(LCount == 0)
    {
        float lastCount = maxWidth * progress / (KProgressPadding + KProgressLineWidth);
               
                       float lastf = lastCount-LCount;
                       CGFloat X = 0;
                       UIView *Line = [[UIView alloc] initWithFrame:CGRectMake(X, 0, KProgressLineWidth*lastf, heigth)];
                       Line.backgroundColor =[UIColor blueColor];
                       [self addSubview:Line];
                       X=X+KProgressLineWidth*lastf;
                       Line = [[UIView alloc] initWithFrame:CGRectMake(X, 0, KProgressLineWidth*(1-lastf), heigth)];
                       Line.backgroundColor =[UIColor whiteColor];
                       Line.alpha = 0.1;
                       [self addSubview:Line];
    }
}



@end
