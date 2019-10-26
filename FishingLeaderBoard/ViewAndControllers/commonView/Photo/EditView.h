//
//  EditView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoHeadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditView : UIView
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CGRect imageViewOriginFrame;

@property (nonatomic) UIView *cropView;
@property (nonatomic) NSMutableArray<UIView *> *coverViews;
@property (nonatomic) NSMutableArray<UIView *> *decoraterViews;

@property (nonatomic) CGRect cropRect;

- (instancetype)initWithImage:(UIImage *)image;
- (UIImage *)cropImage;
- (void)setTouchRects;
- (void)layoutDecoraterViews;
- (void)layoutCoverViews;

@end

NS_ASSUME_NONNULL_END
