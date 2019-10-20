//
//  HomeHeadTableView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "HomeHeadTableView.h"
#import "Masonry.h"
#import "FImagePageViewCellCollectionViewCell.h"

@implementation HomeHeadTableView

- (id)initWithFrame:(CGRect)frame withType:(FPageHeadViewType)type
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = LOGINBGCOLOR;
        if(type == FPageTypeHomeHeadView)
        {
            [self addHomeHeadView];
        }else{
            [self addFishingClassHeadView];
        }
        self.segmentedCtr=[[UISegmentedControl alloc]initWithItems:@[@"最热",@"最新"]];
        self.segmentedCtr.frame=(CGRect){0, topSegCtrlY, SCREEN_WIDTH, 45};
        self.segmentedCtr.selectedSegmentIndex=0;
        self.segmentedCtr.tintColor = CLEARCOLOR;
        [self.segmentedCtr setTitleTextAttributes:@{NSForegroundColorAttributeName:BLACKCOLOR}forState:UIControlStateNormal];
        [self.segmentedCtr addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.segmentedCtr];
        
        float xl = (CGRectGetWidth(frame)/2.0 -25)/2.0;
        lineView = [[UIView alloc]initWithFrame:CGRectMake(xl, CGRectGetMaxY(self.segmentedCtr.frame)-2, 25, 1)];
        lineView.backgroundColor = BLACKCOLOR;
        [self addSubview:lineView];
    }
    return self;
}
//====================选择页面===================
-(void)segmentSelect:(UISegmentedControl *)segmentedCtr
{
    
    self.segmentCtrlClick(segmentedCtr);
    
    float xl = CGRectGetWidth(self.frame)/2.0;
    
    if(segmentedCtr.selectedSegmentIndex == 0)
    {
        lineView.frame = CGRectMake((xl -25)/2.0, CGRectGetMaxY(self.frame)-2, 25, 1);
    }else{
        lineView.frame = CGRectMake(xl + (xl -25)/2.0, CGRectGetMaxY(self.frame)-2, 25, 1);
    }
}
//=====================钓技课堂===================
-(void)addFishingClassHeadView
{
    UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30) name:@"大众课堂" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR textAlignment:NSTextAlignmentLeft];
    [self addSubview:label];
    
    UIButton *btn1 = [self addBtnWithImage:@"page1" title:@"黑坑" tag:BUTTON_HEIKENG_FISHCLASS_TAG];
    UIButton *btn2 = [self addBtnWithImage:@"page1" title:@"野钓" tag:BUTTON_YEDIAO_FISHCLASS_TAG];
    UIButton *btn3 = [self addBtnWithImage:@"page1" title:@"装备" tag:BUTTON_ZHUANGBEI_FISHCLASS_TAG];
    NSArray *btnArr = @[btn1,btn2,btn3];
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:(SCREEN_WIDTH-100*3)/4.0 tailSpacing:(SCREEN_WIDTH-100*3)/4.0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label.mas_bottom).offset(10);
        make.height.equalTo(@60);
    }];
    UIButton *btn4 = [self addBtnWithImage:@"page1" title:@"路亚" tag:BUTTON_LUYA_FISHCLASS_TAG];
    UIButton *btn5 = [self addBtnWithImage:@"page1" title:@"海钓" tag:BUTTON_HAIDIAO_FISHCLASS_TAG];
    UIButton *btn6 = [self addBtnWithImage:@"page1" title:@"杂谈" tag:BUTTON_ZATAN_FISHCLASS_TAG];
     btnArr = @[btn4,btn5,btn6];
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:(SCREEN_WIDTH-100*3)/4.0 tailSpacing:(SCREEN_WIDTH-100*3)/4.0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(btn1.mas_bottom).offset(15);
        make.height.equalTo(@60);
    }];
    topSegCtrlY = CGRectGetMaxY(label.frame) + 10 + 60 + 10 + 60 + 10;
}
-(UIButton *)addBtnWithImage:(NSString *)imageStr title:(NSString *)title tag:(int)tag
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTintColor:WHITECOLOR];
    btn.titleLabel.frame = btn.frame;
    btn.layer.cornerRadius = 5;
    [btn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    UIView * v = [[UIView alloc]init];
    v.backgroundColor = BLACKCOLOR;
    v.alpha = 0.5;
    [btn addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn).mas_offset(0);
        make.top.mas_equalTo(btn).mas_offset(0);
        make.height.mas_equalTo(btn.mas_height);
        make.width.mas_equalTo(btn.mas_width);
    }];
    [btn bringSubviewToFront:btn.titleLabel];
    return btn;
}
//====================主页面======================
-(void)addHomeHeadView
{
    //第一轮播图
    [self OnePageView];
    [self addButton];
    UILabel *label = [FViewCreateFactory createLabelWithFrame:CGRectMake(10, 120+120-10, SCREEN_WIDTH-20, 30) name:@"热门赛事/活动推荐" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR textAlignment:NSTextAlignmentLeft];
    [self addSubview:label];
    [self TwoPageView];
    label = [FViewCreateFactory createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(_mainCollectionView.frame)+15, SCREEN_WIDTH-20, 30) name:@"热门钓点" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR textAlignment:NSTextAlignmentLeft];
    [self addSubview:label];
    [self ThirdPageView];
}
-(void)addButton
{
    UIButton *btn1 = [self btnTitle:@"赛事报名" image:@"game"tag:BUTTON_SAISHIBAOMING_HOME_TAG];
    UIButton *btn2 = [self btnTitle:@"积分商城" image:@"game"tag:BUTTON_JIFENSHANGCHENG_HOME_TAG];
    UIButton *btn3 = [self btnTitle:@"发现钓场" image:@"game"tag:BUTTON_FAXIANYUCHANG_HOME_TAG];
    UIButton *btn4 = [self btnTitle:@"钓技课堂" image:@"game"tag:BUTTON_FISHCLASS_HOME_TAG];
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    [btnArr addObjectsFromArray:@[btn1,btn2,btn3,btn4]];
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:0 tailSpacing:0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self->bView.mas_bottom).offset(10);
        make.height.equalTo(@100);
    }];


}
-(LPButton *)btnTitle:(NSString *)title image:(NSString *)imageStr tag:(int)tag
{
    LPButton *btn  = [[LPButton alloc] init];
    btn.style = LPButtonStyleTop;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
    return btn;
}
-(void)btnClick:(UIButton *)btn
{
    self.btnCtrlClick(btn);
}
//第一轮播图
- (void)OnePageView{

    WMZBannerParam *param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"FImagePageViewCellCollectionViewCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
        //自定义视图
        FImagePageViewCellCollectionViewCell *cell = (FImagePageViewCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FImagePageViewCellCollectionViewCell class]) forIndexPath:indexPath];
        if(indexPath.row ==0)
        {
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:@"http://www.51pptmoban.com/d/file/2014/01/20/e382d9ad5fe92e73a5defa7b47981e07.jpg"] placeholderImage:[UIImage imageNamed:@"page1"]];
        }else{cell.icon.image = [UIImage imageNamed:@"page1"];}

        return cell;
    })
    .wEventClickSet(^(id anyID, NSInteger index) {
        NSLog(@"点击 %@ %ld",anyID,index);
    })
    .wFrameSet(CGRectMake(0, 0, BannerWitdh, 120))
    .wImageFillSet(YES)
    .wLineSpacingSet(0)
    .wScaleSet(NO)
    .wItemSizeSet(CGSizeMake(BannerWitdh, 120))
    .wSelectIndexSet(0)
    .wRepeatSet(YES)
    .wAutoScrollSecondSet(3)
    .wAutoScrollSet(YES)
    .wPositionSet(BannerCellPositionCenter)
    .wBannerControlSelectColorSet([UIColor whiteColor])
    .wBannerControlColorSet(BLACKGRAY)
    .wBannerControlImageRadiusSet(5)
    .wHideBannerControlSet(NO)
    .wBannerControlPositionSet(BannerControlCenter)
    .wDataSet(@[@"1",@",2"])
    ;
     bView = [[WMZBannerView alloc]initConfigureWithModel:param withView:self];
    
}
//第二轮播图
- (void)TwoPageView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = (SCREEN_WIDTH - 40) / 2;
    
    //设置单元格大小
    layout.itemSize = CGSizeMake(itemWidth, 80);
    //最小行间距(默认为10)
    layout.minimumLineSpacing = 10;
    //最小item间距（默认为10）
    layout.minimumInteritemSpacing = 10;
    //设置UICollectionView的滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置UICollectionView的间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
     _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,120 +150 , SCREEN_WIDTH, 80) collectionViewLayout:layout];
    
    //遵循CollectionView的代理方法
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    //注册cell
//    [_twoCollectionView registerClass:[FImagePageViewCellCollectionViewCell class] forCellWithReuseIdentifier:@"FImagePageViewCellCollectionViewCell"];
    [_mainCollectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    _mainCollectionView.tag = COLLECTION_MAIN_TAG;
    [self addSubview:_mainCollectionView];
    
}
-(void)ThirdPageView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = (SCREEN_WIDTH - 40) / 4;
    
    //设置单元格大小
    layout.itemSize = CGSizeMake(itemWidth, 50);
    //最小行间距(默认为10)
    layout.minimumLineSpacing = 5;
    //最小item间距（默认为10）
    layout.minimumInteritemSpacing = 5;
    //设置UICollectionView的滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置UICollectionView的间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _twoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,120 +150 +120 , SCREEN_WIDTH, 80) collectionViewLayout:layout];
    
    //遵循CollectionView的代理方法
    _twoCollectionView.delegate = self;
    _twoCollectionView.dataSource = self;
    _twoCollectionView.showsHorizontalScrollIndicator = NO;
    
    _twoCollectionView.backgroundColor = [UIColor clearColor];
    //注册cell
    _twoCollectionView.tag = COLLECTION_TWO_MAIN_TAG;
    [_twoCollectionView registerNib:[UINib nibWithNibName:@"MainTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainTwoCollectionViewCell"];
    [self addSubview:_twoCollectionView];
    topSegCtrlY = CGRectGetMaxY(_twoCollectionView.frame);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = collectionView.tag;
    if(tag == COLLECTION_MAIN_TAG)
    {
        MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
        
        //实现cell的展示效果
        cell.bgImageView.image = [UIImage imageNamed:@"page1"];
        cell.firstLabel.text = @"赛事";
        cell.dateLabel.text = @"2019年10月18 08:00";
        cell.lastLabel.text = @"活鱼  武昌鱼  鲶鱼  土鳖  高大";
        return cell;
    }else{
        MainTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainTwoCollectionViewCell" forIndexPath:indexPath];
        cell.centerLabel.text = @"活鱼  武昌鱼  鲶鱼  土鳖  高大";
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.51pptmoban.com/d/file/2014/01/20/e382d9ad5fe92e73a5defa7b47981e07.jpg"] placeholderImage:nil];
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //实现cell的点击方法
    NSLog(@"%ld",(long)indexPath.item);
}

@end
