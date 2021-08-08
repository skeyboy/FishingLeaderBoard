//
//  PersonCountView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PersonCountView.h"

@implementation PersonCountView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.countStepper.value = 1;
    self.countStepper.stepInterval = 1;
    self.countStepper.maximum = MAXFLOAT;
    [self.countStepper setBorderColor:WHITECOLOR];
    [self.countStepper setButtonTextColor:BLACKCOLOR forState:UIControlStateNormal];
    self.countStepper.countLabel.textColor = BLACKCOLOR;
    self.countStepper.countLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.countStepper.valueChangedCallback = ^(PKYStepper *stepper, float count) {
        if(count == 0)
        {
            [self.countStepper.decrementButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [self.countStepper.decrementButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        self->_countStepper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
        if(self.toPageType == ToPayPageType)
        {
            self.money = ([self.eventGameDetail.money floatValue]+[self.eventGameDetail.prepayMoney floatValue]) *count;
            self.detailLabel.text = [NSString stringWithFormat:@"您共需要支付%.2f元",([self.eventGameDetail.money floatValue]+[self.eventGameDetail.prepayMoney floatValue]) *count];
            self.enrollCount = count;
        }
        
    };
    [self.countStepper setup];
}

- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)toPay:(id)sender {
    if(self.toPageType == ToPayPageType)
    {
        self.toPayBtnClick(@(self.eventId).description, @(self.money).description, self.enrollCount);
       
    }
}

@end
