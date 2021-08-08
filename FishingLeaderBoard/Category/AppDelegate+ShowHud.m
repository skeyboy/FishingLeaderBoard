//
//  AppDelegate+ShowHud.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "AppDelegate+ShowHud.h"


@implementation AppDelegate (ShowHud)
-(void)loading{
    [MBProgressHUD showHUDAddedTo:self.window animated:YES];
}
-(void)loadingWithMessage:(NSString *)msg mode:(MBProgressHUDMode)mode{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = mode;
    hud.label.text = msg;
    hud.contentColor = WHITECOLOR;
    hud.bezelView.backgroundColor = BLACKCOLOR;
}
-(void)hideHud{
    [MBProgressHUD hideHUDForView:self.window animated:YES];
}
-(void)showWithInfo:(NSString *)info
    delayToHideAfter:(NSTimeInterval)timeInterval{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(SCREEN_WIDTH -40, 45);
    hud.bezelView.layer.masksToBounds = NO;
    UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40,45) name:[NSString stringWithFormat:@"    %@",info] font:[UIFont systemFontOfSize:14] textColor:WHITECOLOR];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = BLACKCOLOR;
    label.layer.cornerRadius =5;
    label.layer.masksToBounds = YES;
    [hud.bezelView addSubview: label];
    [self performSelector:@selector(hideHud) afterDelay:timeInterval];
}
-(void)showDefaultInfo:(NSString *)str
{
    [self showWithInfo:str delayToHideAfter:3];
}
-(void)showDefaultLoading{
    [self showJiZaiInfo:@"网络请求中……"];
}
-(void)showJiZaiInfo:(NSString *)info
{
    CGSize size = [ToolClass sizeWithText:info font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(SCREEN_WIDTH-40, SCREEN_HEIGHT)];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
      hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
      hud.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
      hud.bezelView.backgroundColor = WHITECOLOR;
      hud.mode = MBProgressHUDModeCustomView;
      hud.minSize = CGSizeMake(40+size.width+10+10, 80);
      hud.bezelView.layer.masksToBounds = NO;
      UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake(50, 30, size.width,20) name:[NSString stringWithFormat:@"%@",info] font:[UIFont systemFontOfSize:14] textColor:BLACKCOLOR];
      label.textAlignment = NSTextAlignmentLeft;
      label.backgroundColor = CLEARCOLOR;
      label.layer.cornerRadius =5;
      label.layer.masksToBounds = YES;
      [hud.bezelView addSubview: label];
    
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor blackColor].CGColor; //圆环底色
        layer.frame = CGRectMake(10, 25, 30, 30);
        //创建一个圆环
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15) radius:13 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
        //圆环遮罩
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineWidth = 2;
        shapeLayer.strokeStart = 0;
        shapeLayer.strokeEnd = 1;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineDashPhase = 0.8;
        shapeLayer.path = bezierPath.CGPath;
        [layer setMask:shapeLayer]; //设置圆环遮罩
        [hud.bezelView.layer addSublayer:layer];
    
        NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor blackColor].CGColor,[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:0.7].CGColor, nil];
          CAGradientLayer *gradientLayer = [CAGradientLayer layer];
          gradientLayer.shadowPath = bezierPath.CGPath;
          gradientLayer.frame = CGRectMake(0, 0, 30, 15);
          gradientLayer.startPoint = CGPointMake(1, 0);
          gradientLayer.endPoint = CGPointMake(0, 0);
          [gradientLayer setColors:[NSArray arrayWithArray:colors]];
          
          NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)[[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:0.7] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
          CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
          gradientLayer1.shadowPath = bezierPath.CGPath;
          gradientLayer1.frame = CGRectMake(0, 15, 30, 15);
          gradientLayer1.startPoint = CGPointMake(0, 1);
          gradientLayer1.endPoint = CGPointMake(1, 1);
          [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
          [layer addSublayer:gradientLayer]; //设置颜色渐变
          [layer addSublayer:gradientLayer1];
    
        CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
        rotationAnimation2.toValue = [NSNumber numberWithFloat:2.0*M_PI];
        rotationAnimation2.repeatCount = MAXFLOAT;
        rotationAnimation2.duration = 1;
        rotationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [layer addAnimation:rotationAnimation2 forKey:@"rotationAnnimation"];

}

@end
