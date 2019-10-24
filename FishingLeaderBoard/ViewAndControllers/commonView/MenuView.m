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
}
@end

@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame name:(NSArray *)nameArr color:(NSArray *)colorArr
{
    _popFrame =frame;
    _hideFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)-50, CGRectGetWidth(frame), 50);
    self = [super initWithFrame:_hideFrame];
    if (self) {
        isPopState = NO;
        fabuTitle = [nameArr objectAtIndex:0];
        layerFaBu = [self createLayer:CGRectMake(0, 0, 50, 50) cornerRadius:25];
        [self.layer addSublayer:layerFaBu];
        btnFaBu =[FViewCreateFactory createCustomButtonWithFrame:CGRectMake(0, 0, 50, 50) name:[nameArr objectAtIndex:0]  delegate:self selector:@selector(btnClick:) tag:0];
        btnFaBu.backgroundColor =[colorArr objectAtIndex:0];
        btnFaBu.titleLabel.font = [UIFont systemFontOfSize:15];
        btnFaBu.layer.cornerRadius = 25;
        [self addSubview:btnFaBu];
        
        layerHuoDong = [self createLayer:CGRectMake(5, 0, 40, 40) cornerRadius:20];
        [self.layer addSublayer:layerHuoDong];
        huoDong =[FViewCreateFactory createCustomButtonWithFrame:CGRectMake(5, 0, 40, 40) name:[nameArr objectAtIndex:1] delegate:self selector:@selector(btnClick1:) tag:61];
        huoDong.titleLabel.font = [UIFont systemFontOfSize:12];
        [huoDong setTitleColor:BLACKGRAY forState:UIControlStateNormal];
        huoDong.layer.cornerRadius = 20;
        [huoDong setBackgroundColor:[colorArr objectAtIndex:1]];
        [self addSubview:huoDong];
        
        layerSaiShi = [self createLayer:CGRectMake(5, 10, 40, 40) cornerRadius:20];
        [self.layer addSublayer:layerSaiShi];
        saiShi =[FViewCreateFactory createCustomButtonWithFrame:CGRectMake(5, 10, 40, 40) name:[nameArr objectAtIndex:2] delegate:self selector:@selector(btnClick1:) tag:62];
        [saiShi setTitleColor:BLACKGRAY forState:UIControlStateNormal];
        [saiShi setBackgroundColor:[colorArr objectAtIndex:2]];
        saiShi.titleLabel.font = [UIFont systemFontOfSize:12];
        saiShi.layer.cornerRadius = 20;
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
            self->btnFaBu.frame =  CGRectMake(0, 0, 50, 50);
            self->huoDong.frame = CGRectMake(5, 0, 40, 40);
            self->saiShi.frame =CGRectMake(5, 0, 40, 40);
            
        } completion:^(BOOL finished) {
            self->layerFaBu = [self createLayer:CGRectMake(0, 0, 50, 50) cornerRadius:25];
            [self.layer addSublayer:self->layerFaBu];
            self->layerHuoDong = [self createLayer:CGRectMake(5, 0, 40, 40) cornerRadius:20];
            [self.layer addSublayer:self->layerHuoDong];
            self->layerSaiShi = [self createLayer:CGRectMake(5, 0, 40, 40) cornerRadius:20];
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
            self->btnFaBu.frame =  CGRectMake(0, 100, 50, 50);
            self->huoDong.frame = CGRectMake(5, 0, 40, 40);
            self->saiShi.frame =CGRectMake(5, 50, 40, 40);
        } completion:^(BOOL finished) {
            self->layerFaBu = [self createLayer:CGRectMake(0, 100, 50, 50) cornerRadius:25];
            [self.layer addSublayer:self->layerFaBu];
            self->layerHuoDong = [self createLayer:CGRectMake(5, 0, 40, 40) cornerRadius:20];
            [self.layer addSublayer:self->layerHuoDong];
            self->layerSaiShi = [self createLayer:CGRectMake(5, 50, 40, 40) cornerRadius:20];
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
