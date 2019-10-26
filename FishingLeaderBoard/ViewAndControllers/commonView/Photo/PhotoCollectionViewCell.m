//
//  PhotoCollectionViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/25.
//  Copyright © 2019 yue. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    //    self.contentView.backgroundColor = [UIColor cyanColor];
    _iconImageView = ({
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.backgroundColor = [UIColor clearColor];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview;
    });
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_lessThanOrEqualTo(self.contentView.mas_width);
        make.height.mas_lessThanOrEqualTo(self.contentView.mas_height);
    }];
}

@end
