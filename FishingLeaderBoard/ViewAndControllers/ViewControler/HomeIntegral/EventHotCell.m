//
//  EventHotCell.m
//  FishingLeaderBoard
//
//  Created by 李雨龙 on 2020/4/7.
//  Copyright © 2020 yue. All rights reserved.
//

#import "EventHotCell.h"
#import "GoodsListsItem.h"
@interface EventHotCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end
@implementation EventHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindValue:(GoodsListsItem *)value{
    NSString * coverImg = [value.coverImg componentsSeparatedByString:@","].firstObject;
    IMAGE_LOAD(self.coverImageView, coverImg);
    self.priceView.text = [@(value.price) description];
    self.nameView.text = value.name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
