//
//  DiaoChangHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/27.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SegmentCtrolClick) (UISegmentedControl *);
NS_ASSUME_NONNULL_BEGIN

@interface DiaoChangDetailHeadView : UIView
{
    UIView *lineView;
    float topSegCtrlY;
}
@property(strong,nonatomic)UISegmentedControl  *segmentedCtr;

@property (nonatomic, copy) SegmentCtrolClick    segmentCtrlClick;
//@property (nonatomic, copy) ButtonCtrolClick     btnCtrlClick;

@end

NS_ASSUME_NONNULL_END
