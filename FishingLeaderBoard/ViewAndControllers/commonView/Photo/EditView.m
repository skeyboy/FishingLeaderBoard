//
//  EditView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "EditView.h"
typedef NS_ENUM(NSInteger, PanType){
    PanNone,
    PanImage,
    PanCropView,
};
@interface EditView()
{
    PhotoHeadView *head;
    float bgHeight;
    float bgWidth;
}
@property (nonatomic) PanType panType;
@property (nonatomic) CGRect cropViewPreFrame;

@end

@implementation EditView
- (instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if(self){
        self.backgroundColor =[UIColor groupTableViewBackgroundColor];
        self.frame = CGRectMake(0, 60+Height_StatusBar, SCREEN_WIDTH, SCREEN_HEIGHT-(60+Height_StatusBar));
        [self setImageViewWithImage:image];
        [self initCropView];
        [self initCoverViews];
        [self setTouchRects];
        [self bindGestureRecognizer];
        _imageViewOriginFrame = _imageView.frame;
    }
    return self;
}

- (UIImage *)cropImage{
    CGRect imageFrame = _imageView.frame;
    CGRect cropFrame = _cropView.frame;
    CGRect targetFrame = CGRectMake(CGRectGetMinX(cropFrame) - CGRectGetMinX(imageFrame), CGRectGetMinY(cropFrame) - CGRectGetMinY(imageFrame), CGRectGetWidth(cropFrame), CGRectGetHeight(cropFrame));
    float scale = _imageView.image.size.width / imageFrame.size.width;
    targetFrame.origin.x *= scale;
    targetFrame.origin.y *= scale;
    targetFrame.size.width *= scale;
    targetFrame.size.height *= scale;
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(_imageView.image.CGImage, targetFrame)];
}

#pragma mark - Init
- (void)setImageViewWithImage:(UIImage *)image{
    CGFloat ratio = image.size.width / image.size.height;
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = width / ratio;
    if(height > SCREEN_HEIGHT - Height_StatusBar-60-10){
        height = SCREEN_HEIGHT - Height_StatusBar-60-10;
        width = height * ratio;
    }
    bgWidth = width;
    bgHeight = height;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _imageView.image = image;
    _imageView.center = CGPointMake(width/2.0, height/2.0);
    [self addSubview:_imageView];
}

- (void)initCropView{
    _cropView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _cropView.center = CGPointMake(bgWidth/2.0, bgHeight/2.0);
    _cropView.layer.borderWidth = 0.5;
    _cropView.layer.borderColor = [UIColor blueColor].CGColor;
    _decoraterViews = [NSMutableArray arrayWithCapacity:8];
    for(int i = 0; i < 8; i++){
        UIView *decoraterView = [self getDecoraterView];
        [_decoraterViews addObject:decoraterView];
        [_cropView addSubview:decoraterView];
    }
    [self layoutDecoraterViews];
    
    [self addSubview:_cropView];
}

- (void)initCoverViews{
    _coverViews = [NSMutableArray arrayWithCapacity:4];
    for(int i = 0; i < 4; i++){
        UIView *coverView = [self getCoverView];
        [_coverViews addObject:coverView];
        [self addSubview:coverView];
    }
    [self layoutCoverViews];
    [self bringSubviewToFront:_cropView];
}

- (UIView *)getDecoraterView{
    UIView *decoraterView = [UIView new];
    decoraterView.backgroundColor = [UIColor blueColor];
    return decoraterView;
}

- (UIView *)getCoverView{
    UIView *coverView = [UIView new];
    coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    return coverView;
}

#pragma mark - Layout
- (void)layoutDecoraterViews{
    _decoraterViews[0].frame = CGRectMake(-3, -3, 18, 3);
    _decoraterViews[1].frame = CGRectMake(-3, 0, 3, 15);
    _decoraterViews[2].frame = CGRectMake(_cropView.frame.size.width - 15, -3, 18, 3);
    _decoraterViews[3].frame = CGRectMake(_cropView.frame.size.width, 0, 3, 15);
    _decoraterViews[4].frame = CGRectMake(-3, _cropView.frame.size.height, 18, 3);
    _decoraterViews[5].frame = CGRectMake(-3, _cropView.frame.size.height - 15, 3, 15);
    _decoraterViews[6].frame = CGRectMake(_cropView.frame.size.width - 15, _cropView.frame.size.height, 18, 3);
    _decoraterViews[7].frame = CGRectMake(_cropView.frame.size.width, _cropView.frame.size.height - 15, 3, 15);
}

- (void)layoutCoverViews{
    CGRect frame = _cropView.frame;
    _coverViews[0].frame = CGRectMake(0, 0, CGRectGetMaxX(frame), CGRectGetMinY(frame));
    _coverViews[1].frame = CGRectMake(0, CGRectGetMinY(frame), CGRectGetMinX(frame), SCREEN_HEIGHT - CGRectGetMinY(frame));
    _coverViews[2].frame = CGRectMake(CGRectGetMaxX(frame), 0, SCREEN_WIDTH - CGRectGetMaxX(frame), CGRectGetMaxY(frame));
    _coverViews[3].frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame), SCREEN_WIDTH- CGRectGetMinX(frame), SCREEN_HEIGHT - CGRectGetMaxY(frame));
}

- (void)setTouchRects{
    _cropRect = _cropView.frame;
}

#pragma mark - GestureRecognizer
- (void)bindGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan){
        CGPoint touchPoint = [recognizer locationInView:self];
        _cropViewPreFrame = _cropView.frame;
    if(CGRectContainsPoint(_cropRect, touchPoint)) _panType = PanCropView;
        else _panType = PanImage;
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        CGRect nextFrame;
        CGPoint transPoint;
        if(_panType == PanImage){
        }else{
            transPoint = [recognizer translationInView:self];
            nextFrame = _cropView.frame;
            
            CGFloat maxTop = MAX(0, CGRectGetMinY(_imageView.frame));
            CGFloat maxLeft = MAX(0, CGRectGetMinX(_imageView.frame));
            CGFloat minRight = MIN(bgWidth, CGRectGetMaxX(_imageView.frame));
            CGFloat minButtom = MIN(bgHeight, CGRectGetMaxY(_imageView.frame));
            
            if(_panType == PanCropView){
                nextFrame.origin.x += transPoint.x;
                nextFrame.origin.y += transPoint.y;
                
                if(CGRectGetMinY(nextFrame) < maxTop) nextFrame.origin.y = maxTop;
                if(CGRectGetMinX(nextFrame) < maxLeft) nextFrame.origin.x = maxLeft;
                if(CGRectGetMaxX(nextFrame) > minRight){
                    nextFrame.origin.x = minRight - CGRectGetWidth(_cropViewPreFrame);
                }
                if(CGRectGetMaxY(nextFrame) > minButtom){
                    nextFrame.origin.y = minButtom - CGRectGetHeight(_cropViewPreFrame);
                }
                
            }
            _cropView.frame = nextFrame;
            [self layoutCoverViews];
            [self layoutDecoraterViews];
            [recognizer setTranslation:CGPointZero inView:self];
        }
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        [self setTouchRects];
        _panType = PanNone;
    }
}

@end
