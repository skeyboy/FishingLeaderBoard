//
//  DCDBriefTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/28.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonClick) (UIButton *);
@interface DCDBriefTableViewCell : UITableViewCell

@property (strong,nonatomic)NSArray *arr;

@property (weak, nonatomic) IBOutlet UIImageView *bgCharView;

@property (weak, nonatomic) IBOutlet UIImageView *bgFishTypeView;
@property (weak, nonatomic) IBOutlet UILabel *fishTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleNoteLabel;

@property (copy,nonatomic)  ButtonClick btnClick;

@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

- (IBAction)sendFishGet:(id)sender;

-(void)addCharView;

-(void)addTypeFish;

@end

NS_ASSUME_NONNULL_END
