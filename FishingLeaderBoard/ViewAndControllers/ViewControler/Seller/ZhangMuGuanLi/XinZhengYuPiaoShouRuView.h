//
//  XinZhengYuPiaoShouRuView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface XinZhengYuPiaoShouRuView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label22;

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UILabel *jineLabel;

@property (strong,nonatomic)NSString*str1;
@property (strong,nonatomic)NSString*str2;
@property (strong,nonatomic)NSString*str3;

- (IBAction)cancelClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *yesClick;
- (IBAction)yesClick:(id)sender;
//flag:1支出2收入
-(instancetype)init:(int)flag eventId:(NSInteger)eventId;

@property(assign,nonatomic)int flag;
@property(assign,nonatomic)NSInteger eventId;
@end

NS_ASSUME_NONNULL_END
