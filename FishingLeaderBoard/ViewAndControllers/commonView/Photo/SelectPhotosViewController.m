//
//  SelectPhotosViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SelectPhotosViewController.h"
#define KHeaterCollectionViewCellWidth(section) (SCREEN_WIDTH - (section-1+2)*kFitWidth(10))/(section)
#define kFitHeight(height) (height)/(667.0 - 64) * (SCREEN_HEIGHT - 64)
#define kFitWidth(width) (width)/375.0 * SCREEN_WIDTH
@interface SelectPhotosViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    PhotoHeadView *head;
}
@property (nonatomic, strong) UICollectionView *showPhotoCollectionView;
@property (nonatomic, strong) NSMutableArray *photoArray;

@end

@implementation SelectPhotosViewController

+ (void)checkPhotoLibraryAuthorization:(void (^)(BOOL))completion {
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authStatus) {
            
        case PHAuthorizationStatusNotDetermined: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                completion ? completion(status == PHAuthorizationStatusAuthorized) : nil;
            }];
        }
            break;
            
        case PHAuthorizationStatusRestricted: {
            completion ? completion(NO) : nil;
        }
            break;
            
        case PHAuthorizationStatusDenied: {
            completion ? completion(NO) : nil;
        }
            break;
            
        case PHAuthorizationStatusAuthorized: {
            completion ? completion(YES) : nil;
        }
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    head = [[PhotoHeadView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60+Height_StatusBar)];
    [self.view addSubview:head];
    [head.btnCancel addTarget:self action:@selector(btnCancel) forControlEvents:UIControlEventTouchUpInside];
    [head.btnYes addTarget:self action:@selector(btnYes) forControlEvents:UIControlEventTouchUpInside];
    self.photoArray = @[].mutableCopy;
    if (!_showPhotoCollectionView) {
        [self.view addSubview:self.showPhotoCollectionView];
    }
    
}
-(void)btnCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnYes
{
    if(_cropImageView)
    {
        UIImage *cropImage = [_cropImageView cropImage];
        self.selectPhoto(cropImage);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    de.tbc.tabBar.hidden =YES;
    [self getOriginalImages];
}
-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    de.tbc.tabBar.hidden =NO;
}
- (void)getOriginalImages
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获得所有的自定义相簿
        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        // 遍历所有的自定义相簿
        for (PHAssetCollection *assetCollection in assetCollections) {
            [self enumerateAssetsInAssetCollection:assetCollection original:YES];
        }
        
        // 获得相机胶卷
        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
        // 遍历相机胶卷,获取大图
        [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
    });
}
/**
 *  遍历相簿中的全部图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        __weak typeof(self) weakSelf = self;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
            original ? [weakSelf.photoArray addObject:result] : [weakSelf.photoArray addObject:result];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.showPhotoCollectionView reloadData];
        });
    }
}
-(UICollectionView *)showPhotoCollectionView
{
    if (!_showPhotoCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(KHeaterCollectionViewCellWidth(4.0), KHeaterCollectionViewCellWidth(4.0));
        _showPhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(head.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(head.frame)-10) collectionViewLayout:flowLayout];
        _showPhotoCollectionView.backgroundColor = [UIColor whiteColor];
        _showPhotoCollectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _showPhotoCollectionView.delegate = self;
        _showPhotoCollectionView.dataSource = self;
        _showPhotoCollectionView.allowsSelection = YES;
        [_showPhotoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    }
    return _showPhotoCollectionView;
}

#pragma mark --- UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    cell.iconImageView.image = _photoArray[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_photoArray[indexPath.item]) {
        //self.selectPhoto(_photoArray[indexPath.item]);
        _cropImageView = [[EditView alloc]initWithImage:_photoArray[indexPath.item]];
        [self.view addSubview:_cropImageView];
        [self.view sendSubviewToBack:_cropImageView];
        [self.view bringSubviewToFront:_cropImageView];
        [self.view bringSubviewToFront:head];
    }
}

@end
