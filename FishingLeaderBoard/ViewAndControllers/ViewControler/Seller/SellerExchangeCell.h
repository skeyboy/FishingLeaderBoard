//
//  SellerExchangeCell.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/16.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CurrencyOrderItem;
NS_ASSUME_NONNULL_BEGIN
typedef void(^SellerExchangeCellResult)(NSIndexPath * indexPath);
@interface SellerExchangeCell : UITableViewCell
@property(copy, nonatomic) NSIndexPath * indexPath;
@property(assign) BOOL finished;
@property(copy, nonatomic) SellerExchangeCellResult sellerExchangeResult;
-(void)bindValue:(CurrencyOrderItem *) orderItem;
@end

NS_ASSUME_NONNULL_END
