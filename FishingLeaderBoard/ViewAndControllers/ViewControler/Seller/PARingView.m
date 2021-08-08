//
//  PARingView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PARingView.h"

@interface PARingView()
@property(strong,nonatomic)NSArray *scales;
@property(strong,nonatomic)NSArray *colors;
@property(strong,nonatomic)UIColor *color;
@property(assign,nonatomic)CGFloat radius;
@property (nonatomic)BOOL isFill;

@end

@implementation PARingView

-(instancetype)initWithFrame:(CGRect)frame scales:(NSArray *)scales colors:(NSArray*)colors radius:(CGFloat)radius colorCenter:(UIColor*)color isFill:(BOOL)isFill
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.scales = scales;
        self.colors = colors;
        self.radius = radius;
        self.color = color;
        self.isFill = isFill;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    float y = 0;
     CGContextRef context = UIGraphicsGetCurrentContext();
    //画扇醒
    for (int i = 0; i<_scales.count; i++) {
        float x = [_scales[i]  floatValue]/100.0;
        if (i> 0) {
            float num = [_scales[i-1] floatValue]/100.0;
            y+=num;
        }
        UIColor *aColor = self.colors[i];
         //CGContextSetLineWidth(context, 10.0);
        CGContextSetStrokeColorWithColor(context,aColor.CGColor);
        CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
        CGContextMoveToPoint(context,rect.size.width/2,rect.size.height/2);
        if (i==0) {
              CGContextAddArc(context, rect.size.width/2, rect.size.height/2, self.radius,( y* 2 * M_PI),x* ( 2 * M_PI), 0);
        }else if(i < _scales.count){
        CGContextAddArc(context, rect.size.width/2, rect.size.height/2, self.radius,y* ( 2 * M_PI),y* (2 * M_PI)+x*(2 * M_PI), 0);
        }
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    if(self.isFill == YES)
    {
    UIColor *aColor = self.color;
    CGContextSetStrokeColorWithColor(context,aColor.CGColor);
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextMoveToPoint(context, rect.size.width/2, rect.size.height/2);
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, self.radius/2,0,(2 * M_PI), 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    }else{
        [self derawname:context rect:rect];
    }
}
- (void)derawname:(CGContextRef)context rect:(CGRect)rect{
    UIFont  *font = [UIFont boldSystemFontOfSize:18.0];
    UIColor *color = [UIColor whiteColor];
    float y = 0;

    for (int i = 0; i<_scales.count; i++) {
        float x = [_scales[i]  floatValue];
        if (i!= 0) {
            float t = [_scales[i-1]  floatValue];
            y+=t;
        }
        NSString *name = [NSString stringWithFormat:@"%@ %%",_scales[i]];
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        /// Set line break mode
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment =  NSTextAlignmentCenter;
        /// Set text alignment
        [name drawInRect:CGRectMake(rect.size.width/2+3*self.radius/4*cos(2*M_PI/100*(y+x/2))-30, rect.size.height/2+3*self.radius/4*sin(2*M_PI/100*(y+x/2))-10 , 60, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle}];

    }
}
@end
