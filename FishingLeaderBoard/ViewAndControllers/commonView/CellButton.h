//
//  CellButton.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/6.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellButton : UIButton
@property(strong,nonatomic)NSIndexPath *indexPath;
@property(assign,nonatomic)int column;
@end

NS_ASSUME_NONNULL_END
