//
//  NSString+Empty.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "NSString+Empty.h"



@implementation NSString (Empty)
-(BOOL)isEmpty{
    return self == nil || self.length == 0;
}
@end
