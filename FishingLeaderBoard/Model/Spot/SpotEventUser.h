//
//  SpotEventUser.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SpotEventUserExtend;
@class SpotEventUserItem;
@interface SpotEventUser : NSObject
PropCopy(SpotEventUserExtend, extend)
PropCopy(Page, page)
PropCopy(NSArray, list)
@end
@interface SpotEventUserExtend: NSObject
PropAssign(NSInteger, attestation)
PropAssign(NSInteger, collectNum)
PropCopy(NSString, icon)
PropCopy(NSString, name)
PropAssign(float, star)
@end
@interface SpotEventUserItem : EventSpotGameItem
PropAssign(NSInteger, enrollCount)//报名人数

PropAssign(NSInteger, spotCount)//钓位

@end
NS_ASSUME_NONNULL_END
