//
//  JiFenShangChengViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "IntegralMallViewController.h"
#import "IntegralMallHeaderView.h"
#import "IntegralMallCell.h"
#import "FGoodsDetailViewController.h"
#import "GoodsType.h"
@interface IntegralMallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mallCollectionView;
@property(strong,nonatomic)LPButton *menuLpbtn;
@property(strong,nonatomic)LPButton *recodeLpbtn;

@property(strong,nonatomic)NSArray *typeLists;
@property(nonatomic)GoodsType *chooseTypeItem;
@property(assign,nonatomic)NSInteger isUp;//1升序2降序
@property(assign,nonatomic)NSInteger isZiTi;//

@property(assign,nonatomic)NSInteger currentPage;
@property(strong,nonatomic)NSMutableArray *goodsLists;

@property(strong,nonatomic)SignPageInfo*signPageInfo;
@property(assign, nonatomic)__block NSInteger parentId;

@end
static NSString * const reuseIdentifierHeader = @"IntegralMallHeaderView";
static NSString * const reuseIdentifierCell = @"IntegralMallCell";
static NSString * const reuseIdentifierFooter = @"CollectionHeaderAndFooterView";
@implementation IntegralMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.mallCollectionView registerNib:[UINib nibWithNibName:reuseIdentifierHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    
    [self.mallCollectionView registerNib:[UINib nibWithNibName:reuseIdentifierCell bundle:nil] forCellWithReuseIdentifier:reuseIdentifierCell];
    
    [self.mallCollectionView registerNib:[UINib nibWithNibName:reuseIdentifierFooter bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
    
    [self configCollectionView];
    self.mallCollectionView.delegate = self;
    self.mallCollectionView.dataSource =  self;
    MJRefreshAutoStateFooter*footer =[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    self.mallCollectionView.mj_footer = footer;
    self.mallCollectionView.showsVerticalScrollIndicator = NO;
    self.goodsLists = [[NSMutableArray alloc]initWithCapacity:0];
    self.currentPage = 1;
    self.isUp = 1;
    [self getTypeData];
    self.mallCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setNavViewWithTitle:@"积分商城" isShowBack:YES];
    hkNavigationView.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
             self.mallCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
         } else {
             self.automaticallyAdjustsScrollViewInsets = NO;
         }

}
-(void)getTypeData{
    [[ApiFetch share] userGetFetch:USER_SIGNPAGE
                             query:@{}
                            holder:self
                         dataModel:SignPageInfo.class
                         onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
//        NSSLog(@"jifen modelValue = %@",modelValue);
        self.signPageInfo = (SignPageInfo*)modelValue;
    }];
    [[ApiFetch share]goodsGetFetch:GOODS_GETTYPE query:@{} holder:self dataModel:GoodsTypeLists.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        GoodsTypeLists*lists = (GoodsTypeLists*)modelValue;
        self.typeLists = lists.value;
        [self newGetGoods];
    }];
}
-(void)newGetGoods
{
    self.currentPage = 1;
    [self.goodsLists removeAllObjects];
    [self getGoodsData];
}
-(void)getGoodsData
{
    NSDictionary *req = [[NSMutableDictionary alloc]initWithCapacity:0];
    [req setValue:@(self.currentPage) forKey:@"pageNo"];
    [req setValue:self.isZiTi?@(1):@(2)forKey:@"exchange"];
    if(self.isUp!=0)
    {
        [req setValue:@(self.isUp) forKey:@"sort"];
    }
    if(self.chooseTypeItem!=nil)
    {
        [req setValue:@(self.chooseTypeItem.id) forKey:@"type"];
    }
    [[ApiFetch share]goodsGetFetch:GOODS_GETLIST query:req holder:self dataModel:GoodsLists.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        GoodsLists *lists = (GoodsLists*)modelValue;
        [self.goodsLists addObjectsFromArray:lists.list];
        self.currentPage = self.currentPage +1;
        [self.mallCollectionView.mj_footer endRefreshing];
        if(self.goodsLists.count==lists.page.totalCount)
        {
            [self.mallCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.mallCollectionView reloadData];
        [self performSelector:@selector(loadViewTableView) withObject:nil afterDelay:0.5];
    }];
}
-(void)loadViewTableView
{
    [self.mallCollectionView reloadData];
}
-(void)loadMoreData
{
    [self getGoodsData];
}
- (void)onOptionalFailureHandler:(NSString *)message uri:(NSString *)uri{
    [self.mallCollectionView.mj_footer endRefreshing];
}
- (BOOL)autoHudForLink:(NSString *)link{
    return YES;
}
-(void)configCollectionView{

//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 0;
//    layout.minimumInteritemSpacing =0;
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    float cellWidth = screenWidth / 2.0-10;
//    CGSize size = CGSizeMake(cellWidth, cellWidth);
//    layout.itemSize = size;
//    self.mallCollectionView.collectionViewLayout = layout;

    WSLWaterFlowLayout*_flow = [[WSLWaterFlowLayout alloc] init];
    _flow.delegate = self;
    _flow.flowLayoutStyle = 0;
     self.mallCollectionView.collectionViewLayout = _flow;
    _flow.collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    
}

#pragma mark - WSLWaterFlowLayoutDelegate
//返回每个item大小
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if(waterFlowLayout.flowLayoutStyle == (WSLWaterFlowLayoutStyle)0){
        GoodsListsItem*item = self.goodsLists[indexPath.item];
        if(item.height == 0)
        {
            return CGSizeMake((SCREEN_WIDTH-20)/2.0, 180);
        }else{
            return CGSizeMake((SCREEN_WIDTH-20)/2.0, item.height+50);
        }
    }else{
        return CGSizeMake(0, 0);
    }
}

/** 头视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 209);
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 0);
}

/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return self.goodsLists.count/2;
}
/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        IntegralMallHeaderView *view = (IntegralMallHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        [view.menuBtn removeAllSubviews];
        [view.sortBtn removeAllSubviews];
        [view.bgZiTiChooseView removeAllSubviews];
        self.menuLpbtn = [ToolView btnTitle:(self.chooseTypeItem==nil)?@"全部":self.chooseTypeItem.name image:@"down" tag:0 superView:view.sortBtn sel:@selector(downClick:) targer:self setStyle:LPButtonStyleRight font:17];
        self.recodeLpbtn = [ToolView btnTitle:@"积分" image:(self.isUp==1)?@"sortUp":@"sortDown" tag:0 superView:view.menuBtn sel:@selector(downClick1:) targer:self setStyle:LPButtonStyleRight font:17];
        LPButton *lp1 = [ToolView btnTitle:@"附近钓场自提" image:(self.isZiTi==1)?@"xuanMall":@"noxuanMall" tag:0 superView:view.bgZiTiChooseView sel:@selector(ziTiXuanZeClick:) targer:self setStyle:LPButtonStyleLeft font:14];
        headerView = view;
        [self.recodeLpbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.menuBtn.mas_top);
            make.bottom.equalTo(view.menuBtn.mas_bottom);
            make.left.equalTo(view.menuBtn.mas_left);
            make.right.equalTo(view.menuBtn.mas_right);
        }];
        [self.menuLpbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.sortBtn.mas_top);
            make.bottom.equalTo(view.sortBtn.mas_bottom);
            make.left.equalTo(view.sortBtn.mas_left);
            make.right.equalTo(view.sortBtn.mas_right);
        }];
        [lp1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.bgZiTiChooseView.mas_top);
            make.bottom.equalTo(view.bgZiTiChooseView.mas_bottom);
            make.left.equalTo(view.bgZiTiChooseView.mas_left);
            make.right.equalTo(view.bgZiTiChooseView.mas_right);
        }];
        view.jifenLabel.text =[NSString stringWithFormat:@"%ld",(long)self.signPageInfo.currency];
        return headerView;

    }else{
        CollectionHeaderAndFooterView*view = (CollectionHeaderAndFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        return view;
    }
}
-(void)ziTiXuanZeClick:(LPButton*)btn
{
    if(self.isZiTi==0)
      {
          self.isZiTi = 1;
          [self.mallCollectionView reloadData];
          [self newGetGoods];
      }else{
          self.isZiTi = 0;
          [self.mallCollectionView reloadData];
          [self newGetGoods];
      }
}
-(void)downClick1:(LPButton*)btn
{
    if(self.isUp==2)
    {
        self.isUp = 1;
        [self.mallCollectionView reloadData];
        [self newGetGoods];
    }else{
        self.isUp = 2;
        [self.mallCollectionView reloadData];
        [self newGetGoods];
    }
}
-(void)nextMenu:(LPButton*)btn items:(NSArray *) items{
    
    UIImage *image=[UIImage imageNamed:@""];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];

        YCMenuAction *action = [YCMenuAction actionWithTitle:@"全部" image:image handler:^(YCMenuAction *action) {
                  self.chooseTypeItem = nil;
                  self.parentId = 0;
                  [self.mallCollectionView reloadData];
                  [self newGetGoods];
              }];
        [arr addObject:action];
   if (!self.chooseTypeItem.hasNext && self.chooseTypeItem) {
          YCMenuAction *action = [YCMenuAction actionWithTitle:self.chooseTypeItem.name image:image handler:^(YCMenuAction *action) {
                          
                self.parentId = self.chooseTypeItem.id;
                          [self.mallCollectionView reloadData];
                          [self newGetGoods];
                      }];
                [arr addObject:action];
      }
    for(int i =0;i<items.count;i++)
    {
        GoodsType *item = [items objectAtIndex:i];
        YCMenuAction *action = [YCMenuAction actionWithTitle:item.name image:image handler:^(YCMenuAction *action) {
            NSLog(@"点击了%@",action.title);
            self.parentId = item.id;
            
            self.chooseTypeItem = item;
            if (self.chooseTypeItem.hasNext) {
                [self downClick:btn];
            }
            [self.mallCollectionView reloadData];
            [self newGetGoods];
        }];
        [arr addObject:action];
    }
    YCMenuView *view = [YCMenuView menuWithActions:arr width:SCREEN_WIDTH-15 atPoint:CGPointMake(0, 209)];
    [view show];
}
-(void)downClick:(LPButton*)btn
{
    NSDictionary * params = @{};
    if (self.chooseTypeItem) {
        params = @{@"parentId":@(self.parentId)};
    }
    
    [[ApiFetch share] goodsGetFetch:GOODS_GETTYPE
                                 query:params
                                holder:nil
                             dataModel:GoodTypeValue.class
                             onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
           GoodTypeValue * value = (GoodTypeValue*)modelValue;
        [self nextMenu:btn
                 items:value.value];
       }];
    
}
// 设置Header的尺寸
-(CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    return CGSizeMake(screenWidth, 280-110);
    return CGSizeMake(screenWidth, 209);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    IntegralMallCell * cell =   [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierCell forIndexPath:indexPath];
    GoodsListsItem* item = self.goodsLists[indexPath.item];
    [cell bind:self.goodsLists[indexPath.item]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.coverImg] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error == nil)
        {
            if(item.height == 0)
            {
                float w = (SCREEN_WIDTH-20)/2.0;
                float h = w/image.size.width *image.size.height;
                item.height = h;
                [self.goodsLists replaceObjectAtIndex:indexPath.item withObject:item];
            }
        }
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsLists.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FGoodsDetailViewController * goodDetailVc = [[FGoodsDetailViewController alloc] init];
    GoodsListsItem *item =self.goodsLists[indexPath.item];
    goodDetailVc.goodsId = item.id;
    [self.navigationController pushViewController:goodDetailVc
                                         animated:YES];
}

@end
