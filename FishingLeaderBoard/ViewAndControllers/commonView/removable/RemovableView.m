//
//  RemovableView.m
//  RemovableImageView
//
//  Created by sk on 2019/11/3.
//  Copyright © 2019 sk. All rights reserved.
//

#import "RemovableView.h"
#import "Masonry.h"
@interface RemovableView()
{
    UIView * containerView;
}
@property(copy) NSString * imageUrl;
@property(strong) UIImageView *holderImageView;
@property(strong) UIImageView * indicatorImageView;
@end
#define MARGAIN 10
@implementation RemovableView
-(instancetype)initWithFrame:(CGRect)frame endWithImageURL:(nonnull NSString *)imageUrl{
    if (self = [super initWithFrame:frame]) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(MARGAIN/2, MARGAIN/2, CGRectGetWidth(self.frame)-MARGAIN, CGRectGetHeight(self.frame)-MARGAIN)];
        [self addSubview:containerView];
        self.imageUrl = imageUrl;
        self.holderImageView = [[UIImageView alloc] initWithFrame:containerView.bounds];
//        self.holderImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.holderImageView.image = [[UIImage alloc] initWithContentsOfFile:self.imageUrl];

        self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-MARGAIN, 0, MARGAIN, MARGAIN)];
        self.indicatorImageView.image = [UIImage imageNamed:@"delete.png"];
        [containerView addSubview:self.holderImageView];
        [self addSubview:self.indicatorImageView];
        self.removable = YES;
    }
    return self;
}
-(void)changeImage:(NSString *)url{
    self.imageUrl = url;
    self.holderImageView.image = [[UIImage alloc] initWithContentsOfFile:url];
    
}
-(void)setRemovable:(BOOL)removable{
    _removable = removable;
    if (_removable == NO) {
        self.indicatorImageView.hidden = YES;
    }
    [self bindEvent];

}
-(void)bindEvent{
    if (self.removable==NO) {
        self.holderImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureToAdd:)];
        [self.holderImageView addGestureRecognizer:tap];
    }else{
        self.indicatorImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tapTodelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureToDelete:)];
        [self.indicatorImageView addGestureRecognizer:tapTodelete];
    }
    
}
-(void)gestureToAdd:(UITapGestureRecognizer *)gesture{
    if (self.delegate) {
        [self.delegate onAddAction];
    }
}
-(void)gestureToDelete:(UITapGestureRecognizer *) gesture{
    if (self.removable) {
        [self removeFromSuperview];
    }
    if (self.delegate) {
        [self.delegate onRemovableVieRemoved:self dataSource:self.imageUrl];
    }
}

@end


@interface RemovableViewContainer()<RemovableViewDelegate>
@property(assign) NSInteger colCount;
@property(strong) NSMutableArray * itemViews;
@property(strong) NSMutableArray * items;
@end
@implementation RemovableViewContainer

-(instancetype)initWithFrame:(CGRect)frame columCount:(NSInteger)colCount{
    if (self = [super initWithFrame:frame]) {
        self.colCount = colCount;
        self.itemViews = [[NSMutableArray alloc] init];
        self.items = [[NSMutableArray alloc] init];
        self.padding = 5;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"plus" ofType:@"png"];
        [self addItem:path];
    }
    return self;
}
-(void)setAddViewImageName:(NSString *)addViewImageName{
    _addViewImageName = [addViewImageName copy];
    RemovableView * remView =  self.itemViews[0];
    [remView changeImage:[[ NSBundle mainBundle] pathForResource:addViewImageName ofType:nil]];
}
-(void)addItem:(UIImage *)image{
    if (image == nil) {
        return;
    }
    if (self.items.count) {
        [self.items insertObject:image atIndex:0];

    } else {
        [self.items addObject:image];
    }
  
    [self updateViews];

}
-(void)updateViews{
    
    for (RemovableView * removableView in self.itemViews) {
              [removableView removeFromSuperview];
          
      }
      [self.itemViews removeAllObjects];
   __block  NSInteger index = 0;
        
        CGFloat  localHeight = CGRectGetWidth(self.frame)/self.colCount;
        for (index; index<self.items.count; index++) {
            int row = index/self.colCount;
            int col  = index%self.colCount;
            NSString * imageUrl = self.items[index];
            RemovableView * removableView = [[RemovableView alloc] initWithFrame:CGRectMake(localHeight*col, localHeight*row, localHeight, localHeight) endWithImageURL:imageUrl];
            removableView.removable = (index != self.items.count-1);
            removableView.tag  = index;
            removableView.delegate = self;
            [self addSubview:removableView];
          
            if (self.itemViews.count == 0) {
                [self.itemViews addObject:removableView];
                continue;
            }
            [self.itemViews insertObject:removableView atIndex:MAX(0, self.itemViews.count-1)];
        }
//   __block UIView * tmpView = nil;
//      index = 0;
//    for (UIView *aView in self.itemViews) {
//
//            [aView mas_makeConstraints:^(MASConstraintMaker *make) {
//                if (index/self.colCount==0) {//每行的第一个
//                    make.left.equalTo(self.mas_left);
//
//                    if (tmpView == nil) {//首次
//                        make.top.equalTo(self.mas_top);
//                    }else{
//                        make.top.equalTo(tmpView.mas_bottom);
//                    }
//                } else {
//                    make.left.equalTo(tmpView.mas_right);
//                    make.top.equalTo(tmpView.mas_top);
//                }
//                make.width.equalTo(@100);
//            }];
//        tmpView = aView;
//
//            index++;
//    }
    //    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.height.equalTo(@(self.items.count%self.colCount));
    //    }];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, localHeight*self.colCount,(self.items.count/self.colCount+1)*localHeight);
    if (self.items.count>3) {
     UIView * vv =   self.superview;
        [vv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@((self.items.count/self.colCount+(self.items.count%self.colCount?1:0))*localHeight));
        }];
    }
}
#pragma 删除图标
-(void)onRemovableVieRemoved:(RemovableView *)removableView
                  dataSource:(NSString *)imageUrl{
    if (removableView.removable) {
        
    [self.items removeObjectAtIndex:removableView.tag     ];
    }
     [self updateViews];
}
-(void)onAddAction{
    if (self.OnAddClicked) {
        if (self.OnAddClicked) {
                   __weak typeof(self) weakSelf = self;
                   self.OnAddClicked(weakSelf);
               }
    }
}
-(NSArray *)allImageUrls{
    return [self.items subarrayWithRange:NSMakeRange(0, self.items.count-2)];
}
@end
