//
//  TwoLabel.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TwoClickBlock)(NSInteger index);


@interface TwoLabel : UILabel
@property(nonatomic,strong)UILabel *topLabel;
@property(nonatomic,strong)UILabel *bottomLabel;
/// 选择器
/// @param dataArr @[@{@"top":@"",@"bottom":@""},@{@"top":@"",@"bottom":@""}]
+(UIView *)addSomeTwoLabelTopColor:(UIColor*)topTextColor BottomColor:(UIColor *)bottomTextColor topFont:(UIFont*)tf bottomFont:(UIFont*)bf textDataArrDict:(NSArray *)dataArr  frame:(CGRect)frame  twoLabelHeight:(CGFloat)height click:(TwoClickBlock)twoClickBlock;

@end

NS_ASSUME_NONNULL_END
