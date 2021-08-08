//
//  Commissioner.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventSpotGame.h"
@class CommissionerGame;

NS_ASSUME_NONNULL_BEGIN

@interface Commissioner : NSObject
@property(nonatomic ) NSArray<CommissionerGame*>* list;
@property(nonatomic)Page * page;
@end
@interface CommissionerGame : EventSpotGameItem

@property(assign, nonatomic) NSInteger playType;
@property(copy, nonatomic) NSDate *approvalTime;
@property(copy, nonatomic) NSDate * finishTime;
-(NSString *)statusInfo;
@end
NS_ASSUME_NONNULL_END
