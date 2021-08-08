//
//  SellerStockCell.h
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/20.
//  Copyright © 2020 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SellerStock;
NS_ASSUME_NONNULL_BEGIN

@interface SellerStockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameView;
@property (weak, nonatomic) IBOutlet UILabel *skuView;
@property (weak, nonatomic) IBOutlet UILabel *numberView;

-(void)bindValue:(SellerStock *) sellerStock;
@end

NS_ASSUME_NONNULL_END
