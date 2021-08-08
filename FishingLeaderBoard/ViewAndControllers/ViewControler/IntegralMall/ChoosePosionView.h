//
//  ChoosePosionView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetail;
@class GoodsAdressItem;
@class skuInfoItem;
NS_ASSUME_NONNULL_BEGIN

@interface ChoosePosionView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UIView *preView;
@property(strong,nonatomic)GoodsDetail *goodsDetail;
@property(strong,nonatomic)skuInfoItem* skuInfoItem;
@property(assign,nonatomic)NSInteger skuPrice;
@property(assign,nonatomic)NSInteger count;
@property(strong,nonatomic)NSArray *spotLists;
@property(strong,nonatomic)GoodsAdressItem *goodsAdressitem;

@property(assign,nonatomic)BOOL isPeiSong;
@property(assign,nonatomic)NSInteger sRow;

@property(strong,nonatomic)UITableView *tableView;

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
- (IBAction)yes:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ziTiBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuaiDiBtn;
- (IBAction)ziTiClick:(id)sender;
- (IBAction)kuaiDiClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bgChooseView;

@property (weak, nonatomic) IBOutlet UIButton *addPosionBtn;
@property (weak, nonatomic) IBOutlet UIView *bgXiuGaiView;
@property (weak, nonatomic) IBOutlet UILabel *posionLabel;
@property(strong,nonatomic)NSString * selectSku;

- (IBAction)goToModify:(id)sender;

- (IBAction)addPosisonClick:(id)sender;

- (IBAction)cancelClick:(id)sender;

-(void)bindData;
@end

NS_ASSUME_NONNULL_END
