//
//  BuHuoTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellButton.h"
NS_ASSUME_NONNULL_BEGIN
@class InfoFishCatchItem;

@interface BuHuoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CellButton *button1;

@property (weak, nonatomic) IBOutlet CellButton *button2;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel1;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel2;
@property (weak, nonatomic) IBOutlet UIButton *userButton1;
@property (weak, nonatomic) IBOutlet UIButton *userButton2;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel1;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel2;

@property (weak, nonatomic) IBOutlet UILabel *countLabel1;

@property (weak, nonatomic) IBOutlet UILabel *countLabel2;
- (IBAction)btn1Click:(id)sender;
- (IBAction)btn2Click:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *zanImageView2;


-(void)bindValue:(InfoFishCatchItem*)item1 Value2:(InfoFishCatchItem*)item2;

@property(strong,nonatomic)InfoFishCatchItem *item1;
@property(strong,nonatomic)InfoFishCatchItem *item2;

@end

NS_ASSUME_NONNULL_END
