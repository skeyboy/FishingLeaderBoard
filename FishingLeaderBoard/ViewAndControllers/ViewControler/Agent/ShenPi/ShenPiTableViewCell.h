//
//  ShenPiTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/26.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FuXuanBtnClick) (LPButton*);

@interface ShenPiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ColorLabel *yitongguoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shenpishijianLabel;

@property (weak, nonatomic) IBOutlet UILabel *jifensaishiLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leixingLabel;
@property (weak, nonatomic) IBOutlet UILabel *saishishijianLabel;

@property (weak, nonatomic) IBOutlet LPButton *fuXuanBtn;
@property (strong, nonatomic) FuXuanBtnClick fuXuanBtnClick;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)fuxuanBtnClick:(id)sender;



@end

NS_ASSUME_NONNULL_END
