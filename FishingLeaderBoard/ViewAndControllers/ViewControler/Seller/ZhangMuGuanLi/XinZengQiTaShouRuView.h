//
//  XinZengQiTaShouRuView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XinZengQiTaShouRuView : UIView<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *jineTextField;
- (IBAction)cancelclick:(id)sender;

- (IBAction)yesClick:(id)sender;
//3:新增其他收入4：新增其他支出
-(instancetype)init:(int)flag eventId:(NSInteger)eventId;
@property (strong,nonatomic)NSString*str3;
@property (strong,nonatomic)NSString*remark;

@property(assign,nonatomic)int flag;
@property(assign,nonatomic)NSInteger eventId;
@end

NS_ASSUME_NONNULL_END
