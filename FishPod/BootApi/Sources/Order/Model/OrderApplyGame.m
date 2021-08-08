//
//  OrderApplyGame.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/12/1.
//  Copyright © 2019 yue. All rights reserved.
//

#import "OrderApplyGame.h"

@implementation OrderApplyGameBase
@end
@implementation OrderApplyGameWx
-(PayType)type{
    return PayTypeWx;
}
@end
@implementation OrderApplyGameAli
-(PayType)type{
    return PayTypeAli;
}
@end
@implementation OrderApplyGameParent
-(PayType)type{
    return PayTypeWallet;
}
YYModelCommon

@end
@implementation OrderApplyGame
YYModelCommon

YYModelDate((@[@"startDate",@"endDate",@"createTime"]))

+(BOOL)asArray{
    return YES;
}
@end
