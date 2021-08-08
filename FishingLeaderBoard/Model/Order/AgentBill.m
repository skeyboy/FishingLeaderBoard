//
//  AgentBill.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import "AgentBill.h"
@implementation AgentBillManage
YYModelCommon

YYModelContainerPropertyGenericClass((
                                      @{
                                          @"list":AgentBill.class
                                      }))
@end
@implementation AgentBill
YYModelCommon
YYModelDate((@[@"startDate",@"endDate",@"createTime"]))
+(BOOL)asArray{
    return YES;
}
-(NSString *)typeInfo{
    switch (self.type) {
        case 1:
            return @"赛事佣金";
            break;
            case 2:
            return @"提成";
            
        default:
            return @"";
            break;
    }
}
@end
