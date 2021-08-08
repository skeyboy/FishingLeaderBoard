//
//  PersonCountView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKYStepper.h"
#import "ToPayView.h"
#import "GoodsOrderComfirmViewController.h"
@class EventGameDetail;


typedef void(^ToPayBtnClick) (NSString*,NSString*,NSInteger);

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, ToPagType) {
    ToPayPageType                   =0,                         //!<跳转到支付页面
    ToConfirmGoodsOrderPageType            =1                         //!<跳转到商品订单确认页面
   
};
/// 可加减数量显示
@interface PersonCountView : UIView

@property(assign,nonatomic) ToPagType toPageType;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet PKYStepper *countStepper;
- (IBAction)cancel:(id)sender;

- (IBAction)toPay:(id)sender;

@property(strong,nonatomic)EventGameDetail *eventGameDetail;

@property(assign,nonatomic)float money;

@property(assign,nonatomic)int enrollCount;

@property(assign,nonatomic)NSInteger eventId;

@property(copy,nonatomic)ToPayBtnClick toPayBtnClick;
@end

NS_ASSUME_NONNULL_END
