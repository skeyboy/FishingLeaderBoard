//
//  SearchViewDelegate.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/7.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchViewDelegate <NSObject>

@optional

-(void)searchButtonClick:(NSString *)searchStr;

@end

NS_ASSUME_NONNULL_END
