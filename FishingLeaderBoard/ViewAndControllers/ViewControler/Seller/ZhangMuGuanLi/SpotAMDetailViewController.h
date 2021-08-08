//
//  SpotAMDetailViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "FViewController.h"
NS_ASSUME_NONNULL_BEGIN
@interface SpotAMDetailViewController : FViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIImageView *spotImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *baoMingRenShuLabel;

@property (weak, nonatomic) IBOutlet UILabel *benchangshouyiLabel;

@property (weak, nonatomic) IBOutlet UILabel *fangyuLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouyuLabel;
@property (weak, nonatomic) IBOutlet UILabel *cunyuLabel;

@property (weak, nonatomic) IBOutlet UILabel *fangyuzhichuLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouyuzhichuLabel;
@property (weak, nonatomic) IBOutlet UILabel *qitazhichuLabel;

@property (weak, nonatomic) IBOutlet UILabel *yupiaoshouruLabel;
@property (weak, nonatomic) IBOutlet UILabel *cunYuShouRuLabel;
@property (weak, nonatomic) IBOutlet UILabel *qitashouruLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaoyuzhichuLabel;
- (IBAction)addNewItem:(id)sender;


@property(strong,nonatomic)OrderEventListItem*eventListItem;
@end

NS_ASSUME_NONNULL_END
