//
//  PKYStepper+Default.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PKYStepper+Default.h"



@implementation PKYStepper (Default)
-(void)defaultConfig{
    self.value = 0.0f;
    self.stepInterval = 0.5f;
    self.maximum = MAXFLOAT;
    [self setBorderColor:WHITECOLOR];
    [self setButtonTextColor:BLACKCOLOR forState:UIControlStateNormal];
    self.countLabel.textColor = BLACKCOLOR;
    self.countLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    @weakify(self)
    self.valueChangedCallback = ^(PKYStepper *stepper, float count) {
        if(count == 0)
        {
            [weak_self.decrementButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [weak_self.decrementButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        self.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
    };
    [self setup];
}
-(void)defaultConfigStep:(float)stepInterval{
    [self defaultConfig];
    self.stepInterval = stepInterval;
}
@end
