//
//  BaoMingShiJianView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/9.
//  Copyright © 2020 yue. All rights reserved.
//

#import "BaoMingShiJianView.h"

@implementation BaoMingShiJianView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"BaoMingShiJianView" owner:self options:nil] lastObject];
    if (self) {
        
    }
    return self;
}
@end
