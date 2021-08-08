//
//  IntegralMallCell.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "IntegralMallCell.h"
@interface IntegralMallCell()

@end
@implementation IntegralMallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
}
-(void)bind:(GoodsListsItem*)item
{
//    IMAGE_LOAD(self.imageView, item.coverImg);
    self.nameLabel.text = item.name;
    self.integralLabel.text =[NSString stringWithFormat:@"%ld积分",(long)item.price];
}
@end
