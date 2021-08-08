//
//  YingXiongBangViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/19.
//  Copyright © 2020 yue. All rights reserved.
//

#import "FViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YingXiongBangViewController : FViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImgV1;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel1;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMaImgV;

@property (weak, nonatomic) IBOutlet UILabel *jifenLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *imgBg;

@property (weak, nonatomic) IBOutlet UIImageView *headImgV2;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV3;

@property (weak, nonatomic) IBOutlet UIView *jieTuV;

@property(strong,nonatomic)NSArray *paimingLists;

@property (weak, nonatomic) IBOutlet UILabel *chengjiLabel1;


@property (weak, nonatomic) IBOutlet UILabel *chengjiLabel2;

@property (weak, nonatomic) IBOutlet UILabel *chengjiLabel3;
@property (weak, nonatomic) IBOutlet UILabel *spotNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *yingxiongbangBottomImageView;



@end

NS_ASSUME_NONNULL_END
