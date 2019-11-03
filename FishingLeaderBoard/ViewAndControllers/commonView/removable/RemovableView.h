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
-(instancetype)initWithFrame:(CGRect)frame endWithImageURL:(NSString *) imageUrl;
@property(weak, nonatomic) id<RemovableViewDelegate> delegate;
@property(assign) BOOL removable;
-(void)changeImage:(NSString *) url;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface RemovableViewContainer : UIView
@property(assign) CGFloat padding;

/// [UIImage imageNamed:]
@property(copy) NSString * addViewImageName;
-(instancetype)initWithFrame:(CGRect)frame columCount:(NSInteger) colCount;
-(void)addItem:(NSString *) imageURL ;
@property(copy,nonatomic) void(^OnAddClicked)(__weak RemovableViewContainer * selfView );
@property(nonatomic,getter=allImageUrls) NSArray *imageUrls;
@end
NS_ASSUME_NONNULL_END

