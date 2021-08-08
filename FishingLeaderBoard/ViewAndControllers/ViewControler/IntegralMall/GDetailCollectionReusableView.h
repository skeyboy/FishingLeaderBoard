//
//  GDetailCollectionReusableView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDetailCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *bgBannerView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datailLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UIView *bgStoreView;
@property (weak, nonatomic) IBOutlet UIView *bgDetailView;
@property (weak, nonatomic) IBOutlet UILabel *kuCunLabel;

@property (weak, nonatomic) IBOutlet UILabel *ziChiZiTILabel;

@end

NS_ASSUME_NONNULL_END
