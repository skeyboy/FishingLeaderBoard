//
//  SellerStockCell.m
//  FishingLeaderBoard
//
//  Created by sk on 2020/1/20.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SellerStockCell.h"
#import "SellerStock.h"


@implementation SellerStockCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindValue:(SellerStock *)sellerStock{
    self.goodsNameView.text = sellerStock.goodsName;
    self.skuView.text = sellerStock.selectSku;
    self.numberView.text = @(sellerStock.number).description;
    IMAGE_LOAD(self.coverImgView, sellerStock.coverImg)
}

@end
