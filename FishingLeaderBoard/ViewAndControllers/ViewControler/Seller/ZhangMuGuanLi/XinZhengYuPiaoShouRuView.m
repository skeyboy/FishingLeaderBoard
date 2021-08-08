//
//  XinZhengYuPiaoShouRuView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "XinZhengYuPiaoShouRuView.h"

@implementation XinZhengYuPiaoShouRuView
-(instancetype)init:(int)flag eventId:(NSInteger)eventId
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"XinZhengYuPiaoShouRuView" owner:self options:nil]firstObject];
    if(self)
    {
        self.flag = flag;
        self.eventId = eventId;
        if(flag == 1)
        {
            self.titleLabel.text = @"新增收鱼支出";
            self.label1.text = @"收鱼";
            self.label11.text = @"斤";
            self.label2.text = @"回购";
            self.label22.text = @"元/斤";
        }
        self.textField1.delegate = self;
        self.textField2.delegate = self;
    }
    return self;
}
- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];

}
- (IBAction)yesClick:(id)sender {
    [self.textField1 endEditing:YES];
    [self.textField2 endEditing:YES];
    [SendDataClass sendDataType:self.flag count:self.str1 eventId:self.eventId price:self.str2 money:self.str3 vc:self.viewController back:^{
          [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_sendData" object:nil];
        [self.viewController showDefaultInfo:@"添加成功"];
        [self removeFromSuperview];
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
        self.str1=(self.textField1.text==nil)?@"0":self.textField1.text;
        self.str2=(self.textField2.text==nil)?@"0":self.textField2.text;
        self.str3 =[NSString stringWithFormat:@"%.2f",([self.str1  doubleValue]*[self.str2 doubleValue])];
       self.jineLabel.text = [NSString stringWithFormat:@"金额：%@元",self.str3];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {

    // text field 上实际字符长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    return (strLength <= 5);

}
@end
