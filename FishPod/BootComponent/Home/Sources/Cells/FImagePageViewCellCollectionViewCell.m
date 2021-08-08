//
//  FImagePageViewCellCollectionViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FImagePageViewCellCollectionViewCell.h"

@implementation FImagePageViewCellCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.icon = [UIImageView new];
        self.icon.contentMode = UIViewContentModeScaleToFill;
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        self.icon.frame = self.contentView.bounds;
//        self.leftText = [UILabel new];
//        self.leftText.backgroundColor = [UIColor lightGrayColor];
//        self.leftText.alpha = 0.8;
//        self.leftText.textColor = [UIColor whiteColor];
//        self.leftText.numberOfLines = 1;
//        self.leftText.textAlignment = NSTextAlignmentCenter;
//        [self.icon addSubview:self.leftText];
        
//        self.leftText.frame = CGRectMake(0, self.contentView.frame.size.height-35, self.contentView.frame.size.width, 35);
        self.contentView.layer.masksToBounds = YES;
//        self.contentView.layer.cornerRadius = 8;
        
    }
    return self;
}

@end
