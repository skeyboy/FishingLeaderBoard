//
//  FGoodsDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FGoodsDetailViewController.h"
#import "IntegralMallCell.h"
#import "GDetailCollectionReusableView.h"
#import "GoodsChooseSizeView.h"
#import "GoodsDetailImageScanController.h"
#import "GoodsShareViewController.h"
static NSString * const reuseIdentifierHeader = @"GDetailCollectionReusableView";
static NSString * const reuseIdentifierCell = @"IntegralMallCell";
@interface FGoodsDetailViewController (){}
@property(strong,nonatomic)GoodsDetail *goodsDetail;
@end

@implementation FGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"商品详情" isShowBack:YES];
    [self.duiHuanBtn setBackgroundColor:NAVBGCOLOR];
    [self.mainCollectionView registerNib:[UINib nibWithNibName:reuseIdentifierHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    
    [self.mainCollectionView registerNib:[UINib nibWithNibName:reuseIdentifierCell bundle:nil] forCellWithReuseIdentifier:reuseIdentifierCell];
    [self configCollectionView];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource =  self;
    [self getGoodsDetail];
    
    if ([YuWeChatShareManager isWXAppInstalled]) {
        FNavigationView     *hkNavigationView = [self valueForKey:@"hkNavigationView"];
        [hkNavigationView setNavBarViewRightBtnWithNormalImage:@"share_nav"
                                              highlightedImage:@"share_nav"
                                                        target:self action:@selector(shareGoods:)];
    }
}

-(void)shareGoods:(id ) sender{

    //分享
   
        if(![[AppManager manager]userHasLogin])
        {
            [self showDefaultInfo:@"请先登录"];
            return;
        }
    GoodsShareViewController * goodsShareVC = [[GoodsShareViewController alloc] init];
    goodsShareVC.goodsImageUrl = self.goodsDetail.coverImg;
    goodsShareVC.miniShareUrl = self.goodsDetail.miniShare;
    goodsShareVC.title = self.goodsDetail.name;
    [self presentViewController:goodsShareVC
                       animated:YES
                     completion:^{
        
    }];
        
    
}
-(void)getGoodsDetail
{
    [[ApiFetch share]goodsGetFetch:GOODS_GEDETAIL query:@{@"goodsId":@(self.goodsId)} holder:self dataModel:GoodsDetail.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        self.goodsDetail = (GoodsDetail *)modelValue;
        [self.mainCollectionView reloadData];
    }];
}
-(void)frashData:(GDetailCollectionReusableView*)view
{
    
    [view.bgStoreView removeAllSubviews];

    BOOL isclect=self.goodsDetail.isLike;
    NSString *title = nil;
    NSString *imageS = nil;
    if(isclect)
    {
        title  = @"已收藏";
        imageS = @"starYes";
    }else{
        title  = @"收藏";
        imageS = @"starNo1";
    }
    LPButton *btn =[ToolView btnTitle:title image:imageS tag:0 superView:view.bgStoreView sel:@selector(storeClick:) targer:self setStyle:LPButtonStyleTop font:12];
    btn.frame =CGRectMake(0, 0, 60, 60);
    if(isclect)
    {
        btn.isSelected = YES;
    }else{
        btn.isSelected = NO;
    }
   
    
//    UIImageView *coverImageView = [[UIImageView alloc]init];
//    IMAGE_LOAD(coverImageView, self.goodsDetail.coverImg);
//    coverImageView.contentMode= UIViewContentModeScaleAspectFit;
    [view.bgBannerView removeAllSubviews];
    [self OnePageView:self.goodsDetail.coverList view:view.bgBannerView];
//    [view.bgBannerView addSubview:coverImageView];
//    [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.bgBannerView.mas_top);
//        make.bottom.equalTo(view.bgBannerView.mas_bottom);
//        make.left.equalTo(view.bgBannerView.mas_left);
//        make.right.equalTo(view.bgBannerView.mas_right);
//    }];
    view.nameLabel.text = self.goodsDetail.name;
    view.datailLabel.text = self.goodsDetail.goodsDesc;
    view.integralLabel.text = [NSString stringWithFormat:@"%ld积分",self.goodsDetail.price];
    view.kuCunLabel.text = [NSString stringWithFormat:@"平台库存：%ld",(self.goodsDetail.companyCount+self.goodsDetail.spotCount)];
    view.ziChiZiTILabel.text = [NSString stringWithFormat:@"附近钓场自提：%@",(self.goodsDetail.spotCount>0)?@"支持":@"不支持"];
    [view.bgDetailView removeAllSubviews];
    
    NSArray *imageArr = [self.goodsDetail.descImg componentsSeparatedByString:@","];
    [view.bgDetailView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@([self heightForImageURI:self.goodsDetail.descImg]));
       }];
    
//    GoodsDetailImageScanController * vc = [[GoodsDetailImageScanController alloc] init];
//    vc.imageUrl =self.goodsDetail.descImg;
//    [self addChildViewController:vc];
//    [view.bgDetailView addSubview:vc.view];
//    return;
//    for(int i =0;i<imageArr.count;i++)
//    {
        UIImageView *imagev = [[UIImageView alloc]init];
        IMAGE_LOAD(imagev, self.goodsDetail.descImg);
        [view.bgDetailView addSubview:imagev];
    imagev.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, [self heightForImageURI:self.goodsDetail.descImg] );

    [imagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view.bgDetailView);
    }];
        imagev.clipsToBounds = YES;
        imagev.contentMode = UIViewContentModeScaleAspectFill;
//    }
    imagev.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(scanPic:)];
    [imagev addGestureRecognizer:tap];
//    [self makeToask:@"点击查看图文详情"];
    
}
-(void)scanPic:(id) sender{
    GoodsDetailImageScanController * vc = [[GoodsDetailImageScanController alloc] init];
    vc.imageUrl =self.goodsDetail.descImg;
    [self.navigationController pushViewController:vc animated:YES];
}

//轮播图
- (void)OnePageView:(NSArray*)infoS view:(UIView *)view{
//    NSArray *arrP=[infoS componentsSeparatedByString:@","];
    NSArray *arrP=infoS;

    NSLog(@"arr = %@",arrP);
    NSMutableArray *wM = [[NSMutableArray alloc]init];
        for(int i = 0;i<arrP.count;i++)
        {
            WMBannerCellModel *model = [[WMBannerCellModel alloc]init];
            model.imageName = [arrP objectAtIndex:i];
            [wM addObject:model];
        }
        [ToolView getLunBoViewHeight:SCREEN_WIDTH
                                  width:SCREEN_WIDTH
                                      y:0
                                      x:0
                           superView:view data:wM clickBlock:^(id anyID, NSInteger index) {
        }];
    
}
-(void)storeClick:(LPButton *)btn
{
    if(![[AppManager manager]userHasLogin])
    {
        [self showDefaultInfo:@"请先登录"];
        return;
    }
    @weakify(self)
    if(btn.isSelected == YES)
    {
        [[ApiFetch share] goodsGetFetch:GOODS_COLLECT query:@{@"goodsId":@(self.goodsId)} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response)
         {
            [weak_self hideHud];
            [weak_self makeToask:@"取消收藏"];
            [btn setImage:[UIImage imageNamed:@"starNo1"] forState:UIControlStateNormal];
            btn.isSelected = NO;
        }];
        return;
    }
    [[ApiFetch share] goodsGetFetch:GOODS_COLLECT query:@{@"goodsId":@(self.goodsId)} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [weak_self hideHud];
        [weak_self makeToask:@"收藏成功"];
        [btn setImage:[UIImage imageNamed:@"starYes"] forState:UIControlStateNormal];
        btn.isSelected = YES;
    }];
}
-(void)configCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 2.0-10;
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    layout.itemSize = size;
    self.mainCollectionView.collectionViewLayout = layout;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        GDetailCollectionReusableView *view = (GDetailCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        headView = view;
        [self frashData:view];
    }
    return headView;
}
-(CGFloat)heightForImageURI:(NSString *) imageURI{
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.goodsDetail.descImg];
    if (originalImage) {
        return originalImage.size.height+SCREEN_WIDTH*4;
//        return originalImage.size.height *( (SCREEN_WIDTH -30)/originalImage.size.width)+SCREEN_WIDTH*4;
    } else {
        [self.mainCollectionView performSelector:@selector(reloadData) afterDelay:1];
        return 0;
    }
}
// 设置Header的尺寸
-(CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  
    
    CGFloat descImageHeight = [self heightForImageURI:self.goodsDetail.descImg];
    

    return CGSizeMake(screenWidth, 371 +descImageHeight);
    
  NSArray *arr = [self.goodsDetail.descImg componentsSeparatedByString:@","];
//    return CGSizeMake(screenWidth, 371-150+SCREEN_WIDTH+arr.count*(SCREEN_WIDTH-30));
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    IntegralMallCell * cell =   [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierCell forIndexPath:indexPath];
    //    cell.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2-10, CGRectGetHeight(cell.frame));
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FGoodsDetailViewController * goodDetailVc = [[FGoodsDetailViewController alloc] init];
    [self.navigationController pushViewController:goodDetailVc
                                         animated:YES];
}

- (IBAction)toDuiHuan:(id)sender {
    GoodsChooseSizeView *view = [[GoodsChooseSizeView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    [view bind:self.goodsDetail];
}
@end
