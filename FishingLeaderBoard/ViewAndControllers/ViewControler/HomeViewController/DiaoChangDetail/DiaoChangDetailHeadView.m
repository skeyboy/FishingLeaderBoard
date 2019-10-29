//
//  DiaoChangHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangDetailHeadView.h"
#import "FSSegmentTitleView.h"
#import "WMZBannerView.h"
#import "FImagePageViewCellCollectionViewCell.h"
#import "GRStarsView.h"
#import "TwoLabel.h"
@interface DiaoChangDetailHeadView()

@end
@implementation DiaoChangDetailHeadView

-(void)addAllViewDelegate:(id)de {
    //加轮播图
    [self OnePageView];
    [self addstars];
    self.right0Label.text = @"赛事";
    self.right1Label.text = @"活动";
    
    [self addLabelsSuperView:self.bgActLabel topText:@"1" bottomText:@"活动次数"];
    [self addLabelsSuperView:self.bgBaoMingLabel topText:@"12333333" bottomText:@"报名次数"];
    [self addLabelsSuperView:self.bgGuanzhuLabel topText:@"34567" bottomText:@"关注次数"];
    
    FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) delegate:de indicatorType:1];
    titleView.titlesArr = @[@"活动/赛事",@"简介",@"渔获"];
    [self.bgChooseCardView addSubview:titleView];
    titleView.titleSelectColor= BLACKCOLOR;
    titleView.indicatorColor = BLACKCOLOR;
    titleView.backgroundColor = WHITECOLOR;
}
-(void)addLabelsSuperView:(UIView*)superView topText:(NSString *)text bottomText:(NSString *)bText{
    TwoLabel *act = [[TwoLabel alloc]init];
    act.topLabel.text = text;
    act.bottomLabel.text =bText;
    act.bottomLabel.textColor = [UIColor lightGrayColor];
    [superView addSubview:act];
    [act mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
}

-(void)addstars{
   GRStarsView*starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(18, 18) margin:0 numberOfStars:5];
    starsView.frame = CGRectMake(0, 0, 100,18);
    [self.bgStarImageView addSubview:starsView];
    starsView.allowSelect = YES;  // 默认可点击
    starsView.allowDecimal = YES;  //默认可显示小数
    starsView.allowDragSelect = NO;//默认不可拖动评分，可拖动下需可点击才有效
    starsView.score = 4.5;
}
//轮播图
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
    .wFrameSet(CGRectMake(0, 0, BannerWitdh-10, 150))
    .wImageFillSet(YES)
    .wLineSpacingSet(0)
    .wScaleSet(NO)
    .wItemSizeSet(CGSizeMake(BannerWitdh-10, 150))
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
    [[WMZBannerView alloc]initConfigureWithModel:param withView:self.bgLunBoTuImageView];
    
}
@end

