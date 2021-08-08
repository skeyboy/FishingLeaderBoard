//
//  GreenLineTextField.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GreenLineTextField.h"

@implementation GreenLineTextField

-(instancetype)init
{
    self = [super init];
    self = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    if(self)
    {
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.enterTextField.delegate = self;
    self.rightButton.hidden = YES;
    self.textView.hidden = YES;
    self.textView.delegate = self;
    self.leftTextField.delegate = self;
    self.leftTextField.hidden = YES;
    self.switchView.hidden = YES;
    self.leftImageView.hidden = YES;
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = @"个性签名~";
    _placeHolderLabel.numberOfLines = 0;
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    [_placeHolderLabel sizeToFit];
    [self.textView addSubview:_placeHolderLabel];
    
    // same font
    _placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    
    [_textView setValue:_placeHolderLabel forKey:@"_placeholderLabel"];
    
    self.line.backgroundColor = WHITEGRAY;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.enterTextField resignFirstResponder];
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if((textField.tag == TEXTFIELD_SAISHISHIJIAN_TAG)||(textField.tag ==TEXTFIELD_BAOMINGJIEZHI_TAG))
    {
        self.textFieldClick(textField);
        return NO;
    }else{
    self.bottomLine.backgroundColor = [UIColor greenColor];
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)-1.5, CGRectGetWidth(self.bottomLine.frame), 2);
    return YES;
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.bottomLine.backgroundColor = WHITEGRAY;
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)-1, CGRectGetWidth(self.bottomLine.frame), 1);
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.bottomLine.backgroundColor = [UIColor greenColor];
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)-1, CGRectGetWidth(self.bottomLine.frame), 2);
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.bottomLine.backgroundColor = WHITEGRAY;
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)-1, CGRectGetWidth(self.bottomLine.frame), 1);
    return YES;
}
- (IBAction)rightButtonClick:(id)sender {
    self.textFieldClick(nil);
}
@end
