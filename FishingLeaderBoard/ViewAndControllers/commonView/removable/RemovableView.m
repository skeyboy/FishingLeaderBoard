//
//  RemovableView.m
//  RemovableImageView
//
//  Created by sk on 2019/11/3.
//  Copyright © 2019 sk. All rights reserved.
//

#import "RemovableView.h"
#import "Masonry.h"
#import <RITLPhotos/RITLPhotos.h>
#import "UIView+YYAdd.h"
#import "UIImage+Upload.h"

@interface RemovableView()
{
    UIView * containerView;
}
@property(copy) NSString * imageUrl;
@property(copy) UIImage *sourceImage;
@property(strong) UIImageView *holderImageView;
@property(strong) UIImageView * indicatorImageView;
@end
#define MARGAIN 15
@implementation RemovableView
-(instancetype)initWithFrame:(CGRect)frame endWithImage:(nonnull UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(MARGAIN/2, MARGAIN/2, CGRectGetWidth(self.frame)-MARGAIN, CGRectGetHeight(self.frame)-MARGAIN)];
        [self addSubview:containerView];
        self.sourceImage = image;
        self.holderImageView = [[UIImageView alloc] initWithFrame:containerView.bounds];
//        self.holderImageView.contentMode = UIViewContentModeScaleAspectFill;
        if ([self.imageUrl hasPrefix:@"http"]) {
            [self.holderImageView setImageURL:[NSURL URLWithString:self.imageUrl]];
//            self.holderImageView.image = self.sourceImage;
        }else{
            
            self.holderImageView.image = self.sourceImage;
        }

        self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-MARGAIN, 0, MARGAIN, MARGAIN)];
        self.indicatorImageView.image = [UIImage imageNamed:@"delete.png"];
        [containerView addSubview:self.holderImageView];
        [self addSubview:self.indicatorImageView];
        self.removable = YES;
        self.layoutMargins =UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return self;
}
-(void)addImage:(UIImage *)image{
    self.holderImageView.image = image;
}
-(void)changeImage:(NSString *)url{
    self.imageUrl = url;
    if ([self.imageUrl hasPrefix:@"http"]) {
               [self.holderImageView setImageURL:[NSURL URLWithString:self.imageUrl]];
           }else{
               
               self.holderImageView.image = self.sourceImage;
           }
//    self.holderImageView.image = [[UIImage alloc] initWithContentsOfFile:url];
    
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


@interface RemovableViewContainer()<RemovableViewDelegate,RITLPhotosViewControllerDelegate>
{
    CGFloat  _imageWidthAndHieight;
}
@property(assign) NSInteger colCount;
@property(strong) NSMutableArray * itemViews;
@property(strong) NSMutableArray * items;
@end
@implementation RemovableViewContainer

-(instancetype)initWithFrame:(CGRect)frame columCount:(NSInteger)colCount{
    if (self = [super initWithFrame:frame]) {
        _imageWidthAndHieight = 75;
        self.colCount = colCount;
        self.itemViews = [[NSMutableArray alloc] init];
        self.items = [[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hx_compose_pic_add" ofType:@"png"];
        [self addItem:[UIImage imageWithData:[NSData dataWithContentsOfFile:path]]];
    }
    return self;
}
-(void)setAddViewImageName:(NSString *)addViewImageName{
    _addViewImageName = [addViewImageName copy];
    RemovableView * remView =  self.itemViews[0];
    [remView changeImage:[[ NSBundle mainBundle] pathForResource:addViewImageName ofType:nil]];
}
-(void)setImageWidthAndHieight:(CGFloat)imageWidthAndHieight{
    _imageWidthAndHieight = imageWidthAndHieight;
    [self updateViews];
}
-(CGFloat)imageWidthAndHieight{
    return _imageWidthAndHieight;
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
    [self.viewController showJiZaiInfo:@"正在上传图片"];
    [image uploadSelf:^{
        [self.viewController hideHud];
    } failure:^{
        [self.viewController hideHud];
    }];
}
-(void)bindDefaultsImageFromString:(NSString *)imgsStr{
    NSArray * images = [imgsStr componentsSeparatedByString:@","];
    for (NSString *imgUrl in images) {
        
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addItem:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]]];
        });
    });
    }
}
-(void)updateViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    for (UIView * removableView in self.itemViews) {
              [removableView removeFromSuperview];
          
      }
      [self.itemViews removeAllObjects];
   __block  NSInteger index = 0;
        
        CGFloat  localHeight = CGRectGetWidth(self.frame)/self.colCount;
    CGFloat offset =  0;

    for (index; index<self.items.count; index++) {
            int row = index/self.colCount;
            int col  = index%self.colCount;
            UIImage * image = self.items[index];
        CGFloat innerOffset =(row==0?0:(localHeight-self.imageWidthAndHieight)*row);
        offset += innerOffset;
        CGRect newFrame = CGRectMake(localHeight*col, localHeight*row, localHeight, localHeight);
            UIView * subContainerView = [[UIView alloc] initWithFrame:newFrame];
            
            RemovableView * removableView = [[RemovableView alloc] initWithFrame:CGRectMake(subContainerView.center.x-localHeight/2, subContainerView.center.y-localHeight/2,localHeight, localHeight) endWithImage:image];
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
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, localHeight*self.colCount,(self.items.count/self.colCount+1)*localHeight);
    UIView * vv =   self.superview;
    if (self.items.count>3) {
        [vv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@((self.items.count/self.colCount+(self.items.count%self.colCount?1:0))*localHeight));
            UIView * last = self.itemViews.lastObject;
            make.bottom.equalTo(last.mas_bottom).offset(5);
        }];
    }else{
        [vv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1*localHeight));
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
    if (CGSizeEqualToSize(self.destImageSize, CGSizeZero)) {
        self.destImageSize = CGSizeMake(75, 75);
    }
    if (self.OnAddClicked) {
        if (self.OnAddClicked) {
                   __weak typeof(self) weakSelf = self;
//                   self.OnAddClicked(weakSelf);
           JJImagePicker *picker = [ToolView selectImageFromAlbum];
                 [picker showImagePickerWithType:JJImagePickerTypePhoto
                                InViewController:self.viewController
                                     didFinished:^(JJImagePicker *picker, UIImage *image) {
                     [weakSelf addItem:image];
                 }];
            return;
            RITLPhotosViewController *photoController = RITLPhotosViewController.photosViewController;;
            photoController.configuration.maxCount = 9;//最大的选择数目
            photoController.configuration.containVideo = false;//选择类型，目前只选择图片不选择视频

            photoController.photo_delegate = self;
            photoController.thumbnailSize = self.destImageSize;//缩略图的尺寸
//            photoController.defaultIdentifers = self.saveAssetIds;//记录已经选择过的资源

            [self.viewController presentViewController:photoController
                                              animated:YES completion:^{
                
            }];
               }
    }
}
#pragma 图片选取
#pragma mark - RITLPhotosViewControllerDelegate
/**** 为了提高相关性能，如果用不到的代理方法，不需要多实现  ****/


/// 图片选择器消失的回调方法
- (void)photosViewControllerWillDismiss:(UIViewController *)viewController {
    NSLog(@"%@ is dismiss",viewController);
}


/**
 选中图片以及视频等资源的本地identifer
 可用于设置默认选好的资源
 
 @param viewController RITLPhotosViewController
 @param identifiers 选中资源的本地标志位
 */
- (void)photosViewController:(UIViewController *)viewController
            assetIdentifiers:(NSArray <NSString *> *)identifiers
{
    
}
/**
 选中图片以及视频等资源的默认缩略图
 根据thumbnailSize设置所得，如果thumbnailSize为.Zero,则不进行回调
 与是否原图无关
 
 @param viewController RITLPhotosViewController
 @param thumbnailImages 选中资源的缩略图
 @param infos 选中资源的缩略图的相关信息
 */
- (void)photosViewController:(UIViewController *)viewController thumbnailImages:(NSArray<UIImage *> *)thumbnailImages infos:(NSArray<NSDictionary *> *)infos
{
    NSLog(@"%@",infos);
//   TODO实现图片上传
    
    RemovableView *item =  self.itemViews.firstObject;
//    [item changeImage:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573117994171&di=74e4092146bfb068dcc92c857fa43afa&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201312%2F04%2F20131204184148_hhXUT.jpeg"];
//    for (UIImage * thumbnailImage in thumbnailImages) {
//
//         [self addItem:thumbnailImage];
//    }
//    [self addItem:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573117994171&di=74e4092146bfb068dcc92c857fa43afa&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201312%2F04%2F20131204184148_hhXUT.jpeg"];
}
- (void)photosViewController:(UIViewController *)viewController
images:(NSArray <UIImage *> *)images
 infos:(NSArray <NSDictionary *> *)infos;
{
    for (UIImage * image in images) {
          
           [self addItem:image];
      }
}
-(NSArray *)allImageUrls{
    //没有选择图片
    if (self.items.count == 1) {
        return  @[];
    }
   return  [[self.items valueForKey:@"networkURL"] subarrayWithRange:NSMakeRange(0, self.items.count-1)];
    
}
@end
