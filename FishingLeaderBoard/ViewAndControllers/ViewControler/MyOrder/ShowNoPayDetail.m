//
//  ShowNoPayDetail.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ShowNoPayDetail.h"

@implementation ShowNoPayDetail

-(instancetype)init
{
    self = [super init];
    self = [[[NSBundle mainBundle]loadNibNamed:@"ShowNoPayDetail" owner:self options:nil]firstObject];
    if(self)
    {
        
    }
    return self;
}

- (IBAction)WXPay:(id)sender {
}

- (IBAction)zhifubaoPay:(id)sender {
}

- (IBAction)walletPay:(id)sender {
}

- (IBAction)deleteOrder:(id)sender {
}
@end
