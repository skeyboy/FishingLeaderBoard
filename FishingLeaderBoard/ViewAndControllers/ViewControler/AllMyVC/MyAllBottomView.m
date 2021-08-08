//
//  MyAllBottomView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MyAllBottomView.h"

@implementation MyAllBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"MyAllBottomView" owner:self options:nil] lastObject];
    if (self) {
        
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.signOutBtn.layer.cornerRadius = 5;
    self.signOutBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.signOutBtn.layer.borderWidth = 1;
}
- (IBAction)signOutAction:(id)sender {
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:fSessionUserInfoDic];
     [[NSUserDefaults standardUserDefaults] synchronize];
    [AppManager manager].userInfo = nil;
    [FTabBarClass intoTabBarControll];
}

- (IBAction)phoneAction:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://13810347506"]]];
}
@end
