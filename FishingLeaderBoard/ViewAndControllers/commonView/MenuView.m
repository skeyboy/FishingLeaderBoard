//
//  MenuView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/23.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MenuView.h"
@interface MenuView ()
{
    BOOL isPopState;
    CALayer *layerHuoDong;
    UIButton * huoDong;
    CALayer *layerSaiShi;
    UIButton * saiShi;
    CALayer *layerFaBu;
    UIButton * btnFaBu;
    
    CGRect _popFrame;
    CGRect _hideFrame;
    NSString *fabuTitle;
    
    float width;
}
@end

@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame name:(NSArray *)nameArr color:(NSArray *)colorArr
{
    width = frame.size.width;
    _popFrame =frame;
    _hideFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)-width, CGRectGetWidth(frame), width);
    self = [super initWithFrame:_hideFrame];
    if (self) {
        isPopState = NO;
        fabuTitle = [nameArr objectAtIndex:0];
        layerFaBu = [self createLayer:CGRectMake(0, 0, width, width) cornerRadius:width/2.0];
        [self.layer addSublayer:layerFaBu];
        btnFaBu =[FViewCreateFactory createCustomButtonWithFrame:CGRectMake(0, 0, width, width) name:[nameArr objectAtIndex:0]  delegate:self selector:@selector(btnClick:) tag:0];
        btnFaBu.backgroundColor =[colorArr objectAtIndex:0];
        btnFaBu.titleLabel.font = [UIFont systemFontOfSize:15];
        btnFaBu.titleLabel.numberOfLines = 0;
        btnFaBu.layer.cornerRadius = width/2;
        [self addSubview:btnFaBu];
        
        layerHuoDong = [self createLayer:CGRectMake(5, 0, width-10, width-10) cornerRadius:(width-10)/2];
        [self.layer addSublayer:layerHuoDong];
        huoDong =[FViewCreateFactory createCustomButtonWithFrame:CGRectMake(5, 0, width-10, width-10) name:[nameArr objectAtIndex:1] delegate:self selector:@selector(btnClick1:) tag:61];
        huoDong.titleLabel.font = [UIFont systemFontOfSize:13];
        [huoDong setTitleColor:BLACKGRAY forState:UIControlStateNormal];
        huoDong.layer.cornerRadius = (width-10)/2;
        [huoDong setBackgroundColor:[colorArr objectAtIndex:1]];
        [self addSubview:huoDong];
        
        layerSaiShi = [self createLayer:CGRectMake(5, 10, width-10, width-10) cornerRadius:(width-10)/2];
        [self.layer addSublayer:layerSaiShi];
        saiShi =[FViewCreateFactory createCustomButtonWithFrame:CGRectMake(5, 10, (width-10)/2, (width-10)/2) name:[nameArr objectAtIndex:2] delegate:self selector:@selector(btnClick1:) tag:62];
        [saiShi setTitleColor:BLACKGRAY forState:UIControlStateNormal];
        [saiShi setBackgroundColor:[colorArr objectAtIndex:2]];
        saiShi.titleLabel.font = [UIFont systemFontOfSize:13];
        saiShi.layer.cornerRadius = (width-10)/2;
        [self addSubview:saiShi];
        [self bringSubviewToFront:btnFaBu];

        
    }
    return self;
}
-(CALayer *)createLayer:(CGRect)frame cornerRadius:(float)redius
{
    CALayer *layer = [CALayer layer];
    
    layer.frame = frame;
    
    layer.backgroundColor = BLACKGRAY.CGColor;
    
    layer.shadowOffset = CGSizeMake(0, 5);
    
    layer.shadowOpacity = 0.5;
    
    layer.cornerRadius = redius;
    return layer;
}
-(void)btnClick:(UIButton *)btn
{
    if (isPopState) {
        isPopState = NO;
        [btn setTitle:fabuTitle forState:UIControlStateNormal];
        [btnFaBu setImage:nil forState:UIControlStateNormal];
        [layerFaBu removeFromSuperlayer];
        [layerHuoDong removeFromSuperlayer];
        [layerSaiShi removeFromSuperlayer];
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = self->_hideFrame;
            self->btnFaBu.frame =  CGRectMake(0, 0, self->width, self->width);
            self->huoDong.frame = CGRectMake(5, 0, (self->width-10), (self->width-10));
            self->saiShi.frame =CGRectMake(5, 0, (self->width-10), self->width-10);
            
        } completion:^(BOOL finished) {
            self->layerFaBu = [self createLayer:CGRectMake(0, 0, self->width, self->width) cornerRadius:(self->width)/2.0];
            [self.layer addSublayer:self->layerFaBu];
            self->layerHuoDong = [self createLayer:CGRectMake(5, 0, (self->width-10), self->width-10) cornerRadius:(self->width-10)/2];
            [self.layer addSublayer:self->layerHuoDong];
            self->layerSaiShi = [self createLayer:CGRectMake(5, 0, self->width-10, self->width-10) cornerRadius:(self->width-10)/2.0];
            [self.layer addSublayer:self->layerSaiShi];
            [self bringSubviewToFront:self->btnFaBu];

        }];
    }else{
        isPopState = YES;
        [btnFaBu setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [btnFaBu setTitle:@"" forState:UIControlStateNormal];
        [layerFaBu removeFromSuperlayer];
        [layerHuoDong removeFromSuperlayer];
        [layerSaiShi removeFromSuperlayer];
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = self->_popFrame;
            self->btnFaBu.frame =  CGRectMake(0, self->width*2, self->width, self->width);
            self->huoDong.frame = CGRectMake(5, 0, self->width-10, self->width-10);
            self->saiShi.frame =CGRectMake(5, self->width, self->width-10, self->width-10);
        } completion:^(BOOL finished) {
            self->layerFaBu = [self createLayer:CGRectMake(0, self->width*2, self->width, self->width) cornerRadius:self->width/2.0];
            [self.layer addSublayer:self->layerFaBu];
            self->layerHuoDong = [self createLayer:CGRectMake(5, 0, self->width-10, self->width-10) cornerRadius:(self->width-10)/2];
            [self.layer addSublayer:self->layerHuoDong];
            self->layerSaiShi = [self createLayer:CGRectMake(5, self->width, self->width-10, self->width-10) cornerRadius:(self->width-10)/2];
            [self.layer addSublayer:self->layerSaiShi];
            [self bringSubviewToFront:self->huoDong];
            [self bringSubviewToFront:self->saiShi];
            [self bringSubviewToFront:self->btnFaBu];

        }];
        
    }
}
-(void)btnClick1:(UIButton *)btn
{
    int index = (int)btn.tag - 60;
    self.menuClick(index);
}
@end
