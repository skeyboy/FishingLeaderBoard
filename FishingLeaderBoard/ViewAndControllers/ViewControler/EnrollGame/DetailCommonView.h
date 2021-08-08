//
//  DetailCommonView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE

/// 详情内容显示
@interface DetailCommonView : UIView
@property(copy, nonatomic) IBInspectable NSString * detailContent;

@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailView;

@end

NS_ASSUME_NONNULL_END
