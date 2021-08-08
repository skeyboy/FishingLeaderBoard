//
//  EventHotCell.h
//  FishingLeaderBoard
//
//  Created by 李雨龙 on 2020/4/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsListsItem;
NS_ASSUME_NONNULL_BEGIN

@interface EventHotCell : UITableViewCell
-(void)bindValue:(GoodsListsItem *) value;
@end

NS_ASSUME_NONNULL_END
