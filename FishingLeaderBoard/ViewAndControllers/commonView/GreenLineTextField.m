//
//  GreenLineTextField.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GreenLineTextField.h"

@implementation GreenLineTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.enterTextField.delegate = self;
    self.rightButton.hidden = YES;
    self.textView.hidden = YES;
    self.textView.delegate = self;
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"个性签名~";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    
    // same font
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.enterTextField resignFirstResponder];
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    self.bottomLine.backgroundColor = [UIColor greenColor];
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)-1.5, CGRectGetWidth(self.bottomLine.frame), 2);
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.bottomLine.backgroundColor = BLACKGRAY;
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)+1.5, CGRectGetWidth(self.bottomLine.frame), 0.5);
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
    self.bottomLine.backgroundColor = BLACKGRAY;
    self.bottomLine.frame = CGRectMake(10.f, CGRectGetMidY(self.bottomLine.frame)+1, CGRectGetWidth(self.bottomLine.frame), 1);
    return YES;
}
@end
