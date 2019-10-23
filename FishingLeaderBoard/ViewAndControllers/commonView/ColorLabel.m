//
//  CostomLabel.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ColorLabel.h"

@implementation ColorLabel

-(void)setText:(NSString *)text{
    [super setText:text];
    if ([text isEqualToString:@"赛事"]) {
        self.backgroundColor = [UIColor redColor];
    }else if ([text isEqualToString:@"报名中"])
    {
        self.backgroundColor = [UIColor greenColor];
    }else if ([text isEqualToString:@"活动"])
    {
        self.backgroundColor = [UIColor orangeColor];
    }else{
        
    }
}

@end
