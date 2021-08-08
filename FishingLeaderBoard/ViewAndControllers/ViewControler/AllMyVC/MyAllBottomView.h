//
//  MyAllBottomView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAllBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *signOutBtn;

- (IBAction)signOutAction:(id)sender;


- (IBAction)phoneAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
