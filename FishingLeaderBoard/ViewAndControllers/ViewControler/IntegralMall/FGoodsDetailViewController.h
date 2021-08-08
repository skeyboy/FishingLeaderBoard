//
//  FGoodsDetailViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+JhForm.h"


NS_ASSUME_NONNULL_BEGIN

@interface FGoodsDetailViewController : FViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property(assign,nonatomic)NSInteger goodsId;

- (IBAction)toDuiHuan:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *duiHuanBtn;

@end

NS_ASSUME_NONNULL_END
