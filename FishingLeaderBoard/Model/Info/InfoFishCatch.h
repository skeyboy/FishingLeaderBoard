//
//  InfoFishCatch.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoFishCatchItem.h"

NS_ASSUME_NONNULL_BEGIN
@interface InfoFishCatch : NSObject

PropCopy(Page, page)
//@property(copy) NSArray<InfoFishCatchItem*> * list;

PropCopy(NSArray, list)

@end


NS_ASSUME_NONNULL_END
