//
//  AddDiaoKengTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/6.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddDiaoKengTableViewCell : UITableViewCell
typedef void(^DeleteBtnClick) ();
@property(copy,nonatomic)DeleteBtnClick deleteBtnClick;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *bgCharView;
@property (strong,nonatomic)NSMutableArray *titleLabelArr1;
@property (strong,nonatomic)NSMutableArray *contextLabelArr1;
@property (strong,nonatomic)UILabel *mianjiLabel;
@property (strong,nonatomic)UILabel *diaoweishuLabel;
@property (strong,nonatomic)UILabel *diaoweijianjuLabel;
@property (strong,nonatomic)UILabel *pingjunshuishenLabel;
@property (strong,nonatomic)UILabel *xianganchangduLabel;

- (IBAction)deleteBtnClick:(id)sender;
-(void)bindData:(SpotPondInfo *)spotInfo;
@property (weak, nonatomic) IBOutlet UIView *bgView;



@end

NS_ASSUME_NONNULL_END
