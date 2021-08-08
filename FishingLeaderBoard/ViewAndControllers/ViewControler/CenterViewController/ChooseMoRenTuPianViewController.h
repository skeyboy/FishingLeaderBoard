//
//  ChooseMoRenTuPianViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/9.
//  Copyright © 2020 yue. All rights reserved.
//

#import "FViewController.h"
#import "ChooseMoRenTuPianTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectBtnClick) (UIImage*,NSString*);
@interface ChooseMoRenTuPianViewController : FViewController
@property (copy,nonatomic)SelectBtnClick selectBtnClick;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray *moRenTuPianArr;
- (IBAction)sureClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *quedingBtn;

@end

NS_ASSUME_NONNULL_END
