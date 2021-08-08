//
//  XiuGaiYuTangFangYuShuLiangView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "XiuGaiYuTangFangYuShuLiangView.h"
#import "SendDataClass.h"
@implementation XiuGaiYuTangFangYuShuLiangView

-(instancetype)initEventId:(NSInteger)eventId show:(nonnull OrderFishAndPrice *)fp
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"XiuGaiYuTangFangYuShuLiangView" owner:self options:nil]firstObject];
    if(self)
    {
        self.addBtn = [ToolView btnTitle:@"增加鱼量" image:@"xuanMall" tag:0 superView:self.bgBtnVIew sel:@selector(addClick:) targer:self setStyle:LPButtonStyleLeft font:15];
        self.jianBtn = [ToolView btnTitle:@"减少鱼量" image:@"noxuanMall" tag:0 superView:self.bgBtnVIew sel:@selector(jianShaoClick:) targer:self setStyle:LPButtonStyleLeft font:15];
        self.flag=4;
        self.eventId = eventId;
        self.fishesLabel.text = [NSString stringWithFormat:@"鱼种：%@",fp.fishName];
       
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgBtnVIew.mas_left);
            make.centerY.equalTo(self.bgBtnVIew.mas_centerY);
            make.height.equalTo(@30);
            make.width.equalTo(@(120));
        }];
        [self.jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.right.equalTo(self.bgBtnVIew.mas_right);
                  make.centerY.equalTo(self.bgBtnVIew.mas_centerY);
                  make.height.equalTo(@30);
                  make.width.equalTo(@(120));

              }];
        
        self.shouyuTextField.delegate = self;
        self.huigouTextFeild.delegate = self;
    }
    return self;
}
-(void)addClick:(UIButton*)btn
{
    self.flag=4;
    [self.addBtn setImage:[UIImage imageNamed:@"xuanMall"] forState:UIControlStateNormal];
    [self.jianBtn setImage:[UIImage imageNamed:@"noxuanMall"] forState:UIControlStateNormal];

}
-(void)jianShaoClick:(UIButton*)btn
{
      self.flag=3;
     [self.addBtn setImage:[UIImage imageNamed:@"noxuanMall"] forState:UIControlStateNormal];
      [self.jianBtn setImage:[UIImage imageNamed:@"xuanMall"] forState:UIControlStateNormal];
}
- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)yesClick:(id)sender {
    [self.shouyuTextField endEditing:YES];
      [self.huigouTextFeild endEditing:YES];
    NSLog(@"self.flag = %d",self.flag);
      [SendDataClass sendDataType:self.flag count:self.str1 eventId:self.eventId price:self.str2 money:self.str3 vc:self.viewController back:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_sendData" object:nil];
          [self.viewController showDefaultInfo:@"添加成功"];
          [self removeFromSuperview];
      }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
        self.str1=(self.shouyuTextField.text==nil)?@"0":self.shouyuTextField.text;
        self.str2=(self.huigouTextFeild.text==nil)?@"0":self.huigouTextFeild.text;
        self.str3 =[NSString stringWithFormat:@"%.2f",([self.str1  doubleValue]*[self.str2 doubleValue])];
       self.jineLabel.text = [NSString stringWithFormat:@"金额：%@元",self.str3];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {

    // text field 上实际字符长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    return (strLength <= 5);

}
@end
