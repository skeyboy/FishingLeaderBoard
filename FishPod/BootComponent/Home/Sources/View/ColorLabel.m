//
//  CostomLabel.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ColorLabel.h"
#import "FConstont.h"
@implementation ColorLabel

-(void)setText:(NSString *)text{
    [super setText:text];
    self.textColor = WHITECOLOR;
    if ([text isEqualToString:@"赛事"]) {
        self.backgroundColor = [[UIColor alloc]initWithRed:13/255.0 green:104/255.0 blue:199/255.0 alpha:1];
    }else if ([text isEqualToString:@"报名中"])
    {
        self.backgroundColor = [[UIColor alloc]initWithRed:29/255.0 green:186/255.0 blue:65/255.0 alpha:1];
    }else if ([text isEqualToString:@"活动"])
    {
        self.backgroundColor = [[UIColor alloc]initWithRed:235/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    }else if ([text isEqualToString:@"认证"])
    {
        self.backgroundColor = [[UIColor alloc]initWithRed:252/255.0 green:135/255.0 blue:10/255.0 alpha:1];
    }else if ([text isEqualToString:@"黑坑"])
    {
        self.backgroundColor = [[UIColor alloc]initWithRed:88/255.0 green:102/255.0 blue:120/255.0 alpha:1];
    }else if ([text isEqualToString:@"已过期"])
    {
        self.backgroundColor = [[UIColor alloc]initWithRed:134/255.0 green:136/255.0 blue:143/255.0 alpha:1];
    }else if ([text isEqualToString:@"自然水域"])
    {
        self.backgroundColor = [[UIColor alloc]initWithRed:26/255.0 green:197/255.0 blue:136/255.0 alpha:1];
    }else if ([text isEqualToString:@"海钓"])
    {
        self.backgroundColor = [UIColor blueColor];
    }else if ([text isEqualToString:@"路亚"])
    {
        self.backgroundColor = [UIColor orangeColor];
    }
    else if([text isEqualToString:@"v已认证"]){
        self.backgroundColor = [UIColor lightGrayColor];
        self.textColor = BLACKCOLOR;
        
    }
    else if([text isEqualToString:@"日场"]){
           self.backgroundColor = [UIColor orangeColor];
    }
    else if([text isEqualToString:@"夜场"]){
              self.backgroundColor = [[UIColor alloc]initWithRed:88/255.0 green:102/255.0 blue:120/255.0 alpha:1];
    } else if([text isEqualToString:@"已通过"]){
           self.backgroundColor = [UIColor greenColor];
           self.textColor = BLACKCOLOR;
           
       } else if([text isEqualToString:@"未通过"]){
              self.backgroundColor = [UIColor lightGrayColor];
              self.textColor = BLACKCOLOR;
              
          }
    else{
         self.backgroundColor = [[UIColor alloc]initWithRed:88/255.0 green:102/255.0 blue:120/255.0 alpha:1];
    }
}

@end
