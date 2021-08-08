//
//  GoodsOrderComfirmViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FViewController.h"
#import "ChoosePosionView.h"
@class GoodsSpotListsItem;
NS_ASSUME_NONNULL_BEGIN
/// 去兑换---确定订单 （虚拟物品兑换）
@interface GoodsOrderComfirmViewController : FViewController
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;

@property(assign, nonatomic) BOOL isRealEnty;
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIButton *getWayBtn;
- (IBAction)chooseWayClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *liuYanTextField;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UIButton *lijihuangouBtn;

//@property(strong,nonatomic)GoodsDetail *goodsDetail;
//@property(strong,nonatomic)skuInfoItem* skuInfoItem;
//@property(strong,nonatomic)GoodsAdressItem *goodsAdressitem;
//@property(strong,nonatomic)GoodsSpotListsItem *goodsSpotItem;

@property(assign,nonatomic)NSInteger skuPrice;
@property(assign,nonatomic)NSInteger count;
@property(strong,nonatomic)NSString *orderStr;
@property(assign,nonatomic)BOOL isPeiSong;

@property(strong,nonatomic)NSString *spotName;
@property(strong,nonatomic)NSString *spotAddress;
@property(strong,nonatomic)NSString *address;
@property(assign,nonatomic)NSInteger price;
@property(strong,nonatomic)NSString *coverImg;
@property(strong,nonatomic)NSString *remark;
@property(strong,nonatomic)NSString * selectSku;
@end

NS_ASSUME_NONNULL_END
