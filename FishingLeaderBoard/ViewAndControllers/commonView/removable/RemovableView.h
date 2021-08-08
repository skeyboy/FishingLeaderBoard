//
//  RemovableView.h
//  RemovableImageView
//
//  Created by sk on 2019/11/3.
//  Copyright © 2019 sk. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class RemovableView;
@protocol RemovableViewDelegate <NSObject>

-(void)onRemovableVieRemoved:(RemovableView *) removableView dataSource:(NSString *) imageUrl;
-(void)onAddAction;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface RemovableView : UIView
-(instancetype)initWithFrame:(CGRect)frame endWithImage:(NSString *) image;
@property(weak, nonatomic) id<RemovableViewDelegate> delegate;
@property(assign) BOOL removable;
-(void)changeImage:(NSString *) url;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface RemovableViewContainer : UIView

@property(assign, nonatomic) CGSize destImageSize;
/// 正方形
@property(assign, nonatomic) CGFloat imageWidthAndHieight;
@property(assign, nonatomic) CGFloat padding;

/// [UIImage imageNamed:]
@property(copy) NSString * addViewImageName;
-(instancetype)initWithFrame:(CGRect)frame columCount:(NSInteger) colCount;
-(void)addItem:(NSString *) imageURL ;


/// 绑定默认的多张封面图片
/// @param imgsStr 根据,截取生成多个图片url
-(void)bindDefaultsImageFromString:(NSString *) imgsStr;
@property(copy,nonatomic) void(^OnAddClicked)(__weak RemovableViewContainer * selfView );
@property(nonatomic,getter=allImageUrls) NSArray *imageUrls;
@end
NS_ASSUME_NONNULL_END

