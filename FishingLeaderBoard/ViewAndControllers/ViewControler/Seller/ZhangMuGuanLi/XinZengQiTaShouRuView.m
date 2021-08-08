//
//  XinZengQiTaShouRuView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "XinZengQiTaShouRuView.h"
#import "SendDataClass.h"
@implementation XinZengQiTaShouRuView
-(instancetype)init:(int)flag eventId:(NSInteger)eventId
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"XinZengQiTaShouRuView" owner:self options:nil]firstObject];
    if(self)
    {
        if(flag==2)
        {
            self.titleLabel.text = @"新增其他支出";
            self.tTitleLabel.text = @"支出说明";
        }
        self.flag=flag;
        self.eventId = eventId;
        self.textView.delegate = self;
        self.jineTextField.delegate = self;
    }
    return self;
}

- (IBAction)cancelclick:(id)sender {
    [self removeFromSuperview];

}

- (IBAction)yesClick:(id)sender {
    [self.textView endEditing:YES];
         [self.jineTextField endEditing:YES];
    if ([self.textView.text isEqualToString:@"限30字"]) {
        [self.viewController showDefaultInfo:@"说明不能为空"];
        return;
    }
    if ([self.jineTextField.text isEqualToString:@""])
     {
         [self.viewController showDefaultInfo:@"金额不能为空"];
         return;
     }
    self.str3 = [NSString stringWithFormat:@"%.02f",[self.jineTextField.text doubleValue]];
         [SendDataClass sendDataType:self.flag remark:self.textView.text eventId:self.eventId money:self.str3 vc:self.viewController back:^{
               [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_sendData" object:nil];
             [self.viewController showDefaultInfo:@"添加成功"];
             [self removeFromSuperview];
         }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {

    // text field 上实际字符长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    return (strLength <= 7);

}
//输入时自动删除占位文字
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"限30字"]) {
        textView.text = @"";
    }
}

//当编辑时动态判断是否超过规定字数，这里限制20字
- (void)textViewDidChange:(UITextField *)textView{
    
    if (textView.text.length >= 30) {
        textView.text = [textView.text substringToIndex:30];
    }
}

//编辑结束后如内存为空自动添加占位文字
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"限30字";
    }
}
@end
