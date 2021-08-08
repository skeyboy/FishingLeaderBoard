//
//  GoodsListsItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsListsItem : NSObject

PropAssign(NSInteger, id)
PropCopy(NSString, coverImg)
PropCopy(NSString, name)
PropAssign(NSInteger, price)

PropAssign(NSInteger, height)


@end

NS_ASSUME_NONNULL_END
