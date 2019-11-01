//
//  SexChooseView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SexChooseView.h"

@implementation SexChooseView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.isNan = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelClick:)];
    [self addGestureRecognizer:tap];
    
}
- (IBAction)nanClick:(id)sender {
    if(self.isNan == NO)
    {
        [self.NanBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [self.nvBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        self.isNan=YES;
    }
}

- (IBAction)nvClick:(id)sender {
    if(self.isNan == YES)
       {
           [self.nvBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
           [self.NanBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
           self.isNan=NO;
       }
}

- (IBAction)yesClick:(id)sender {
    self.btnYesClick(_isNan);
    [self removeFromSuperview];
}

- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];
}
@end
