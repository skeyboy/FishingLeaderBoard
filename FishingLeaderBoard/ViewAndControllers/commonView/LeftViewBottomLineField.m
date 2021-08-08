//
//  LeftViewBottomLineField.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import "LeftViewBottomLineField.h"
@interface LeftViewBottomLineField()<UITextFieldDelegate>
{
    BOOL isEditing;
    
}
@end
@implementation LeftViewBottomLineField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = [leftTitle copy];
    [self updateFocusIfNeeded];
    if (!self.leftView) {
        
           if (self.leftTitle) {
                   UILabel * leftTitleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self sizeWithString:self.leftTitle font:self.font].width+5*leftTitle.length,30 )];
               leftTitleView.text = self.leftTitle;
               leftTitleView.textAlignment = NSTextAlignmentCenter;
               self.leftView = leftTitleView;
               self.leftViewMode = UITextFieldViewModeAlways;
           }
    }
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
    }
    [self updateFocusIfNeeded];

    return self;
}

-(void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = [bottomLineColor copy];
    if (self.lineWeight==0) {
        self.lineWeight=2;
    }
    [self updateFocusIfNeeded];
}
-(void)awakeFromNib{
    [super awakeFromNib ];
    if (self.delegate==nil) {
           self.delegate = self;
       }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    isEditing = YES;
    [self setNeedsDisplay];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    isEditing  = NO;
    [self setNeedsDisplay];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    isEditing = YES;
    [self setNeedsDisplay];
    return YES;
}
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font

{

CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 30)options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font}context:nil];

return rect.size;

}

-(void)drawRect:(CGRect)rect{
    UIColor * lineColor = [UIColor grayColor];
    if (isEditing) {
        lineColor = self.bottomLineColor;
    }
    
    
    //1、获取图形上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //2、描述路径（底层封装路径）
        CGContextMoveToPoint(ctx, 0, self.bounds.size.height);
    [lineColor setStroke];
    
    CGContextSetLineWidth(ctx,(CGFloat)self.lineWeight );
    

        CGContextAddLineToPoint(ctx , self.bounds.size.width , self.bounds.size.height);
        //3、渲染上下文到View的layer
        CGContextStrokePath(ctx);
    return;
    CGFloat centerX = (self.bounds.size.width - self.bounds.origin.x) / 2;
       CGFloat centerY = (self.bounds.size.height - self.bounds.origin.y) / 2;
       
       UIBezierPath *path = [[UIBezierPath alloc] init];
       // 添加一个圆形
       [path addArcWithCenter:CGPointMake(centerX, centerY) radius:10 startAngle:0 endAngle:360 clockwise:YES];
       
       // 设置线条宽度
       path.lineWidth = self.lineWeight;
     
       // 设置线条颜色
       [self.bottomLineColor setStroke];
     
       // 绘制线条
       [path stroke];
       
            // 如果是实心圆，设置填充颜色
           [self.bottomLineColor setFill];
           // 填充圆形
           [path fill];
 }

@end
