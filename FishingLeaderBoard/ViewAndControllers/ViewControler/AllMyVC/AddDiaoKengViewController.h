//
//  AddDiaoKengViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/5.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddDiaoKengViewController : FViewController
- (IBAction)addDiaoKeng:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *meiDIaoKengTiShiLabel;
@property (weak, nonatomic) IBOutlet UITableView *showTableView;
@property(nonatomic,strong)NSString *spotId;

@property (weak, nonatomic) IBOutlet UIButton *addDiaoKenBtn;


@end

NS_ASSUME_NONNULL_END
