//
//  XiuGaiYuTangFangYuShuLiangView.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XiuGaiYuTangFangYuShuLiangView : UIView<UITextFieldDelegate>

@property(strong,nonatomic)LPButton*addBtn;
@property(strong,nonatomic)LPButton*jianBtn;
@property (weak, nonatomic) IBOutlet UIView *bgBtnVIew;
@property (weak, nonatomic) IBOutlet UILabel *fishesLabel;
@property (weak, nonatomic) IBOutlet UITextField *shouyuTextField;
@property (weak, nonatomic) IBOutlet UITextField *huigouTextFeild;

@property (weak, nonatomic) IBOutlet UILabel *jineLabel;
- (IBAction)cancelClick:(id)sender;

- (IBAction)yesClick:(id)sender;

-(instancetype)initEventId:(NSInteger)eventId show:(OrderFishAndPrice*)fp;


@property (strong,nonatomic)NSString*str1;
@property (strong,nonatomic)NSString*str2;
@property (strong,nonatomic)NSString*str3;
@property(assign,nonatomic)int flag;
@property(assign,nonatomic)NSInteger eventId;
@end

NS_ASSUME_NONNULL_END
