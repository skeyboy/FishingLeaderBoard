//
//  MyHDFaQiTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyHDFaQiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet ColorLabel *oneLabel;
@property (weak, nonatomic) IBOutlet ColorLabel *towLabel;
@property (weak, nonatomic) IBOutlet ColorLabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;



@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *baoMingRenLabel;
@property (weak, nonatomic) IBOutlet UILabel *huoDongStateLabel;

@property (weak, nonatomic) IBOutlet CellButton *xiuGaiXinXiBtn;

@property (weak, nonatomic) IBOutlet CellButton *baoMingQingKuangBtn;

@property (weak, nonatomic) IBOutlet CellButton *yaoHaoSheZhiBtn;

@property (weak, nonatomic) IBOutlet CellButton *deleteBtn;




@end

NS_ASSUME_NONNULL_END
