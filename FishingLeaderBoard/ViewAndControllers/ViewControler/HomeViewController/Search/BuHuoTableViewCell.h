//
//  BuHuoTableViewCell.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuHuoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (weak, nonatomic) IBOutlet UIButton *button2;
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



@end

NS_ASSUME_NONNULL_END
