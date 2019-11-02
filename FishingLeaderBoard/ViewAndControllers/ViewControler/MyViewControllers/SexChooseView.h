//
//  SexChooseView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonYesClick) (BOOL);

@interface SexChooseView : UIView
@property (assign,nonatomic)BOOL isNan;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *NanBtn;


@property (weak, nonatomic) IBOutlet UIButton *nvBtn;

@property(copy,nonatomic)ButtonYesClick btnYesClick;
- (IBAction)nanClick:(id)sender;

- (IBAction)nvClick:(id)sender;


- (IBAction)yesClick:(id)sender;


- (IBAction)cancelClick:(id)sender;


@end

NS_ASSUME_NONNULL_END
