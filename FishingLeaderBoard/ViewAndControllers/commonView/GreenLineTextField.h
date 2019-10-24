//
//  GreenLineTextField.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^EditingViewBlock) (UIView *);

@interface GreenLineTextField : UIView<UITextFieldDelegate,UITextViewDelegate>




@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterTextField;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLine;


@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (copy,nonatomic)EditingViewBlock editingViewBlock;

@end

NS_ASSUME_NONNULL_END
