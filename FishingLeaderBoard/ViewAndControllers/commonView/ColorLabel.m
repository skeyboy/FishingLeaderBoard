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
    }
}

@end
