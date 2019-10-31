//
//  HomeHeadTableView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZBannerParam.h"
#import "WMZBannerView.h"
#import "LPButton.h"
#import "MainCollectionViewCell.h"
#import "MainTwoCollectionViewCell.h"
#import "FSSegmentTitleView.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, FPageHeadViewType) {
    FPageTypeHomeHeadView                 =1,                         //!<主页面头页面
    FPageTypeFishingClassHeadView         =2                          //!<钓技课堂
};

typedef void(^SegmentCtrolClick) (UISegmentedControl *);
typedef void(^ButtonCtrolClick) (UIButton *);

@interface HomeHeadTableView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *lineView;
    WMZBannerView *bView;
    UICollectionView *_mainCollectionView;
    UICollectionView *_twoCollectionView;
    float topSegCtrlY;
}
@property(strong,nonatomic)UISegmentedControl  *segmentedCtr;
@property(nonatomic, assign)FPageHeadViewType headViewType;

@property (nonatomic, copy) SegmentCtrolClick    segmentCtrlClick;
@property (nonatomic, copy) ButtonCtrolClick     btnCtrlClick;


- (id)initWithFrame:(CGRect)frame withType:(FPageHeadViewType)type vc:(id)de;

@end

NS_ASSUME_NONNULL_END
