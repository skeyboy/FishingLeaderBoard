//
//  GreenLineTextField.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextFieldCtrolClick) (UITextField *);

@interface GreenLineTextField : UIView<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;




@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterTextField;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLine;


@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic)UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UITextField *leftTextField;


@property (weak, nonatomic) IBOutlet UIImageView *line;

@property (weak, nonatomic) IBOutlet UISwitch *switchView;


@property(copy,nonatomic)TextFieldCtrolClick textFieldClick;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UILabel *switchRLabel;


- (IBAction)rightButtonClick:(id)sender;



@end

NS_ASSUME_NONNULL_END
