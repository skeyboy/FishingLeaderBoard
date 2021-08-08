//
//  GoodsChooseSizeView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "GoodsChooseSizeView.h"
#import "SelectView.h"
#import "GoodsOrderComfirmViewController.h"
#import "ChoosePosionView.h"
@implementation GoodsChooseSizeView
-(instancetype)init
{
    self = [super init];
    self =[[[NSBundle mainBundle]loadNibNamed:@"GoodsChooseSizeView" owner:self options:nil]firstObject];
    if(self)
    {
        self.selectSku = [[NSMutableArray alloc]initWithCapacity:2];
        [self.cofirmBtn setBackgroundColor:NAVBGCOLOR];
        self.count = 1;
        
        self.countStep.value = 1;
        self.countStep.stepInterval = 1;
        self.countStep.maximum = MAXFLOAT;
        [self.countStep setBorderColor:WHITECOLOR];
        [self.countStep setButtonTextColor:BLACKCOLOR forState:UIControlStateNormal];
        self.countStep.countLabel.textColor = BLACKCOLOR;
        self.countStep.countLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.countStep.valueChangedCallback = ^(PKYStepper *stepper, float count) {
               if(count == 0)
               {
                   [self.countStep.decrementButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
               }else{
                   [self.countStep.decrementButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               }
            self->_countStep.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
            self.totalLabel.text = [NSString stringWithFormat:@"%ld积分",(int)count*self.skuPrice];
            self.count = (int)count;
           };
        [self.countStep setup];
       
    }
    return self;
}

- (IBAction)colseBtn:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)confirmClick:(id)sender {
    if(self.skuPrice == 0)
    {
        [self addAlert];
        return;
    }
    ChoosePosionView *view = [[ChoosePosionView alloc]init];
    view.preView = self;
    view.goodsDetail = self.goodsDetail;
    view.skuInfoItem = self.skuInfoItem;
    view.skuPrice = self.skuPrice;
    view.count = self.count;
    view.selectSku = [self.selectSku componentsJoinedByString:@","];
    [self addSubview:view];
    [view bindData];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.mas_top);
         make.bottom.equalTo(self.mas_bottom);
         make.left.equalTo(self.mas_left);
         make.right.equalTo(self.mas_right);
     }];
//    GoodsOrderComfirmViewController*vc = [[GoodsOrderComfirmViewController alloc]initWithNibName:@"GoodsOrderComfirmViewController" bundle:nil];
//    vc.isRealEnty = YES;
//    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(UIView *)viewName:(NSString*)name items:(NSArray *)arr frame:(CGRect)frame index:(NSInteger)index1
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    [self.bgChooseView addSubview:view];
    UILabel *nameLabel = [FViewCreateFactory createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 21) name:name font:[UIFont systemFontOfSize:17] textColor:BLACKCOLOR];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:nameLabel];
    SelectView *select = [[SelectView alloc]initWithArr:arr row:@"5" cornerRadius:12 height:24];
    select.isMuli = NO;
    select.selectIndex = @"0";
    [view addSubview:select];
    [self.chooseViews addObject:@"0"];
    [self.selectSku replaceObjectAtIndex:index1 withObject:[arr objectAtIndex:0]];
    select.selectViewCtrolClick = ^(NSInteger index) {
        [self.chooseViews replaceObjectAtIndex:index1 withObject:[NSString stringWithFormat:@"%ld",index]];
        [self getPrice];
        [self.selectSku replaceObjectAtIndex:index1 withObject:[arr objectAtIndex:index]];

    };
    select.frame = CGRectMake(0, 21+5, SCREEN_WIDTH-30, 24*arr.count);
    return view;
}
-(void)getPrice
{
    NSString *selectIndex = [self.chooseViews objectAtIndex:0];
    specsInfoItem *item = [self.goodsDetail.specsInfo objectAtIndex:0];
    valueListItem * it = [item.valueList objectAtIndex:[selectIndex intValue]];
    NSString *strid = [NSString stringWithFormat:@"%ld",it.id];
    for(int i = 1;i<self.goodsDetail.specsInfo.count;i++)
    {
        NSString *selectIndex1 = [self.chooseViews objectAtIndex:i];
        specsInfoItem *item1 = [self.goodsDetail.specsInfo objectAtIndex:i];
        valueListItem * it1 = [item1.valueList objectAtIndex:[selectIndex1 intValue]];
        strid = [NSString stringWithFormat:@"%@-%ld",strid,it1.id];
    }
           self.skuPrice = 0;
           self.skuInfoItem = nil;
           self.totalLabel.text = [NSString stringWithFormat:@"%ld积分",self.count*self.skuPrice];
    for (int j = 0; j<self.goodsDetail.skuInfo.count; j++) {
        skuInfoItem *skuIt = [self.goodsDetail.skuInfo objectAtIndex:j];
        if([skuIt.value isEqualToString:strid])
        {
            self.skuPrice = skuIt.currency;
            self.skuInfoItem = skuIt;
            self.totalLabel.text = [NSString stringWithFormat:@"%ld积分",self.count*self.skuPrice];
        }
    }
    
    if(self.skuPrice==0)
    {
        [self addAlert];
    }
}
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"没有该商品，请重新选择" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sure];
    [self.viewController presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}
-(void)bind:(GoodsDetail*)goodsDetail
{
    self.goodsDetail = goodsDetail;
    [self.bgChooseView removeAllSubviews];
    UIScrollView*scview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bgChooseView.size.width, self.bgChooseView.size.height)];
    [self.bgChooseView addSubview:scview];
    self.chooseViews = [[NSMutableArray alloc]initWithCapacity:0];
    IMAGE_LOAD(self.imageView, goodsDetail.coverImg);
    self.nameLabel.text = [NSString stringWithFormat:@"%ld积分",goodsDetail.price];
//    NSArray *arr = goodsDetail.specsInfo;
    NSMutableArray*arr = [[NSMutableArray alloc]initWithCapacity:0];
    [arr appendObjects:goodsDetail.specsInfo];
    int  m  = 0;
    for(int i=0;i<arr.count;i++)
    {
        [self.selectSku addObject:@""];
        specsInfoItem *item = [arr objectAtIndex:i];
        NSMutableArray *nameA=[[NSMutableArray alloc]initWithCapacity:0];
        for (int j=0; j<item.valueList.count; j++) {
            valueListItem * it = item.valueList[j];
            [nameA addObject:it.name];
        }
        int k = item.valueList.count/5+(((item.valueList.count%5)==0)?0:1);
        m=10+m;
       UIView* view = [self viewName:item.name items:nameA frame:CGRectMake(0, m, SCREEN_WIDTH-30, 46*k)index:i];
        [scview addSubview:view];
        m=m+46*k;
    }
    scview.contentSize = CGSizeMake(self.bgChooseView.size.width, m+20);
    [self  getPrice];
}
@end
