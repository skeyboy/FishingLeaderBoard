//
//  ChoosePosionView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/12/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ChoosePosionView.h"
#import "GoodsOrderComfirmViewController.h"
@implementation ChoosePosionView

-(instancetype)init
{
    self = [super init];
    self =[[[NSBundle mainBundle]loadNibNamed:@"ChoosePosionView" owner:self options:nil]firstObject];
    if(self)
    {
        self.ziTiBtn.backgroundColor = NAVBGCOLOR;
        self.kuaiDiBtn.layer.borderColor=NAVBGCOLOR.CGColor;
        self.kuaiDiBtn.layer.borderWidth = 1;
        self.kuaiDiBtn.layer.cornerRadius = 20;
        self.ziTiBtn.layer.borderColor = NAVBGCOLOR.CGColor;
        self.ziTiBtn.layer.cornerRadius = 20;
        self.ziTiBtn.layer.borderWidth = 1;
        self.isPeiSong = NO;
        self.sRow = 0;
        self.addPosionBtn.hidden = YES;
        self.bgXiuGaiView.hidden = YES;
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, self.bgChooseView.frame.size.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.bgChooseView addSubview:self.tableView];
       
    }
    return self;
}
-(void)bindData
{
    [self getSpotLists];
    [self getGoodsAdress];
}
-(void)getGoodsAdress{
    NSLog(@"hhhh = %@",self.goodsAdressitem);
    [[ApiFetch share]goodsGetFetch:GOODS_GETADRESS query:@{} holder:self.viewController dataModel:GoodsAdressItem.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSArray *arr = modelValue;
        if(arr.count>=1)
        {
            self.goodsAdressitem = [arr objectAtIndex:0];
        }
    }];
}
-(void)getSpotLists
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    @weakify(self);
    [appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        if (onError == nil) {
            [weak_self getSpotData:rgcData.adCode lng:@(location.coordinate.longitude).description lat:@(location.coordinate.latitude).description];
        }else{
             [weak_self getSpotData:@"110100" lng:@"116.405285" lat:@"39.904989"];
            
        }
        return YES;
    }];
}
-(void)getSpotData:(NSString *)adCode lng:(NSString *)lngS lat:(NSString*)latS
{
//    //自提 快递到家
//           self.kuaiDiBtn.hidden = !self.goodsDetail.companyCount;//公司有可邮寄
//           self.ziTiBtn.hidden = !self.goodsDetail.spotCount;//钓场有可自提
           
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:@(self.skuInfoItem.skuId) forKey:@"skuId"];
    [dict setValue:lngS forKey:@"lng"];
    [dict setValue:latS forKey:@"lat"];
    [dict setValue:adCode forKey:@"areaId"];
    NSLog(@"skuid =坎坎坷坷 %@",dict);
    [[ApiFetch share]goodsGetFetch:GOODS_GETLISTSPOT query:dict holder:self.viewController dataModel:GoodsSpotListsItem.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull responseObject) {
        NSLog(@"%@llll=",modelValue);
        self.spotLists = modelValue;
        [self.tableView reloadData];
        
              
    }];
    
}
//返回
- (IBAction)back:(id)sender {
    [self removeFromSuperview];
}
//确定
- (IBAction)yes:(id)sender {
//    {
//      "skuId": 0,
//      "number": 0,
//      "currency": 0,
//      "receiveType": 0,
//      "addId": 0,
//      "spotId": 0,
//      "remark": "string"
//    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dict setValue:@(self.skuInfoItem.skuId) forKey:@"skuId"];
    [dict setValue:@(self.count) forKey:@"number"];
    //1:t自提 2：邮寄
    [dict setValue:@((self.isPeiSong == YES)?2:1) forKey:@"receiveType"];
    [dict setValue:@(self.skuPrice*self.count) forKey:@"currency"];
    if(self.isPeiSong == YES)
    {
        if(self.goodsAdressitem)
        {
           [dict setValue:@(self.goodsAdressitem.id) forKey:@"addId"] ;
        }else{
            [self.viewController showDefaultInfo:@"请先填写配送地址"];
            return;
        }
    }else{
        if(self.spotLists.count==0)
        {
            [self.viewController showDefaultInfo:@"附近自提钓场暂无该数据"];
            return;
        }else{
        GoodsSpotListsItem *it = [self.spotLists objectAtIndex:self.sRow];
        [dict setValue:@(it.spotId) forKey:@"spotId"];
        }
    }
    [[ApiFetch share]goodsPostFetch:GOODS_PREORDER body:dict holder:self.viewController dataModel:GoodsPreOderBack.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        GoodsPreOderBack *orderBack = modelValue;
        GoodsOrderComfirmViewController*vc = [[GoodsOrderComfirmViewController alloc]initWithNibName:@"GoodsOrderComfirmViewController" bundle:nil];
            vc.isRealEnty = YES;
        if(self.isPeiSong == NO)
        {
            GoodsSpotListsItem* goodsSpotItem = [self.spotLists objectAtIndex:self.sRow];
            vc.spotName = goodsSpotItem.spotName;
            vc.spotAddress = goodsSpotItem.spotAddress;
        }
        
      
        vc.skuPrice = self.skuPrice;
        vc.price= self.goodsDetail.price;
        vc.count = self.count;
        vc.isPeiSong = self.isPeiSong;
        vc.address = self.goodsAdressitem.address;
        vc.orderStr = orderBack.value;
        vc.coverImg = self.goodsDetail.coverImg;
        vc.selectSku=self.selectSku;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        [self.preView removeFromSuperview];
    }];


}
//自提按钮
- (IBAction)ziTiClick:(id)sender {
    self.isPeiSong = NO;
    [self.ziTiBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    self.ziTiBtn.backgroundColor = NAVBGCOLOR;
    [self.kuaiDiBtn setTitleColor:NAVBGCOLOR forState:UIControlStateNormal];
    self.kuaiDiBtn.backgroundColor = WHITECOLOR;
    
    self.addPosionBtn.hidden = YES;
    self.bgXiuGaiView.hidden = YES;
    self.tableView.hidden = NO;

}
//快递按钮
- (IBAction)kuaiDiClick:(id)sender {
    self.isPeiSong = YES;
    [self.ziTiBtn setTitleColor:NAVBGCOLOR forState:UIControlStateNormal];
    self.ziTiBtn.backgroundColor = WHITECOLOR;
    [self.kuaiDiBtn setTitleColor: WHITECOLOR forState:UIControlStateNormal];
    self.kuaiDiBtn.backgroundColor = NAVBGCOLOR;
    //判断是否有默认地址
    if(self.goodsAdressitem == nil)
    {
        self.addPosionBtn.hidden = NO;
        self.bgXiuGaiView.hidden = YES;

    }else{
        self.addPosionBtn.hidden = YES;
        self.bgXiuGaiView.hidden = NO;
        self.posionLabel.text = self.goodsAdressitem.address;
    }
    self.tableView.hidden = YES;
    
}
//修改地址按钮
- (IBAction)goToModify:(id)sender {
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
       h5Vc.url = ADDRESS_MANAGE;
       h5Vc.addressChoseResult = ^(NSInteger id, NSString * _Nonnull address) {
           GoodsAdressItem *ait = [[GoodsAdressItem alloc]init];
           ait.id = id;
           ait.address = address;
           self.goodsAdressitem = ait;
           self.addPosionBtn.hidden = YES;
           self.bgXiuGaiView.hidden = NO;
           self.posionLabel.text = self.goodsAdressitem.address;
       };
    [self.viewController.navigationController pushViewController:h5Vc
                                                        animated:YES];
}
//添加地址
- (IBAction)addPosisonClick:(id)sender {
    H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = ADDRESS_MANAGE;
    h5Vc.addressChoseResult = ^(NSInteger id, NSString * _Nonnull address) {
        GoodsAdressItem *ait = [[GoodsAdressItem alloc]init];
        ait.id = id;
        ait.address = address;
        self.goodsAdressitem = ait;
        self.addPosionBtn.hidden = YES;
        self.bgXiuGaiView.hidden = NO;
        self.posionLabel.text = self.goodsAdressitem.address;
    };
    [self.viewController.navigationController pushViewController:h5Vc
                                                        animated:YES];

}
//取消
- (IBAction)cancelClick:(id)sender {
    [self.preView removeFromSuperview];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.spotLists.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    GoodsSpotListsItem *spotItem = [self.spotLists objectAtIndex:indexPath.row];
    cell.selectionStyle =UITableViewScrollPositionNone;
    cell.textLabel.text = spotItem.spotName;
    cell.detailTextLabel.text = (spotItem.number>0 )?@"有货，请尽快领取":@"补货中，预计1周后有货";
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    if(indexPath.row == self.sRow)
    {
        cell.imageView.image = [UIImage imageNamed:@"selected"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"unselect"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.sRow = indexPath.row;
    [self.tableView reloadData];
}
@end
