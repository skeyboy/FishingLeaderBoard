//
//  Page.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface Page : NSObject

PropAssign(NSInteger, pageNo)
PropAssign(NSInteger, pageSize)

PropAssign(NSInteger, totalPage)
PropAssign(NSInteger, totalCount)

PropAssign(NSInteger, offset)

@end

NS_ASSUME_NONNULL_END
