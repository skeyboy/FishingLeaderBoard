//
//  GoodsChooseSizeView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKYStepper.h"
@class SelectView;
NS_ASSUME_NONNULL_BEGIN

@interface GoodsChooseSizeView : UIView


@property (strong,nonatomic)SelectView *selectView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet PKYStepper *countStep;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *bgChooseView;

- (IBAction)colseBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cofirmBtn;

- (IBAction)confirmClick:(id)sender;

-(void)bind:(GoodsDetail*)goodsDetail;
@property(strong,nonatomic)GoodsDetail *goodsDetail;
@property(strong,nonatomic)NSMutableArray *chooseViews;
@property(assign,nonatomic)NSInteger skuPrice;
@property(strong,nonatomic)skuInfoItem *skuInfoItem;
@property(assign,nonatomic)NSInteger count;
@property(strong,nonatomic)NSMutableArray *selectSku;

@end

NS_ASSUME_NONNULL_END
