//
//  UserAccount.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/9.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAccount : NSObject
PropAssign(CGFloat, frozenAmount)
PropAssign(CGFloat, totalAmount)
PropAssign(CGFloat, amount)
PropAssign(NSInteger, accountStatus)
@end

NS_ASSUME_NONNULL_END
