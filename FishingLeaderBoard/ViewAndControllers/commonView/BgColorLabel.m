//
//  BgColorLabel.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BgColorLabel.h"

@implementation BgColorLabel

-(void)setBgText:(NSString*)bgText
{
    self.text =bgText;
    if([bgText isEqualToString:@"赛事"])
    {
        self.backgroundColor = [UIColor redColor];
    }
    NSLog(@"%s",__func__);
}

@end
