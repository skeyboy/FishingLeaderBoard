//
//  InfoFishCatchItem.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/26.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InfoFishCatchItem : NSObject
PropAssign(NSInteger, id)
PropAssign(NSInteger, userId)
PropCopy(NSString, title)
PropCopy(NSString, userNickName)
PropCopy(NSString, userHeadImg)
PropAssign(NSInteger, spotId)
PropCopy(NSString, spotName)
PropCopy(NSString, coverImage)
PropCopy(NSString, images)
PropAssign(NSInteger, likeCount)
PropCopy(NSDate, createTime)
PropCopy(NSDate, updateTime)
PropCopy(NSString, content)

@end

