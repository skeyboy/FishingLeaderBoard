//
//  SaiShiJingLiViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/25.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SaiShiJingLiViewController.h"
#import "GreenLineTextField.h"
#import "CityViewController.h"
#import "YQAlertTableViewController.h"
@interface SaiShiJingLiViewController ()
{
    GreenLineTextField*dingWeiGreenTF;
    GreenLineTextField*lianxirenTF;
    GreenLineTextField*lianxiDianHuaTF;
    LPButton *lpxieYi;
    //    [dict setValue:<#(nullable id)#> forKey:@"provinceId"];
    //    [dict setValue:<#(nullable id)#> forKey:@"province"];
    //    [dict setValue:<#(nullable id)#> forKey:@"cityId"];
    //    [dict setValue:<#(nullable id)#> forKey:@"city"];
    //    [dict setValue:<#(nullable id)#> forKey:@"areaId"];
    //    dict setValue:<#(nullable id)#> forKey:@"area"];
   __block NSInteger provinceId;
   __block NSString *province;
   __block NSInteger cityId;
   __block NSString *city;
   __block NSInteger areaId;
   __block NSString *area;
}
@end

@implementation SaiShiJingLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self setNavViewWithTitle:@"赛事推广经理申请" isShowBack:YES];
   hkNavigationView.backgroundColor = NAVBGCOLOR;
    self.view.backgroundColor = WHITECOLOR;
    [self initPageView];
}

-(void)initPageView
{
    @weakify(self)
    dingWeiGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:dingWeiGreenTF];
    [dingWeiGreenTF.leftLabel setRedStarText:@"*所在地区"];
    dingWeiGreenTF.rightButton.hidden = NO;
    dingWeiGreenTF.enterTextField.tag = TEXTFIELD_BAOMINGJIEZHI_TAG;
    dingWeiGreenTF.enterTextField.placeholder = @"选择所在地区";
    dingWeiGreenTF.textFieldClick = ^(UITextField * textField) {
        [weak_self chooseCitys];
    };
    [dingWeiGreenTF.rightButton setImage:[UIImage imageNamed:@"arrow_primary"] forState:UIControlStateNormal];
    [dingWeiGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hkNavigationView.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    lianxirenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [self.view addSubview:lianxirenTF];
    [lianxirenTF.leftLabel setRedStarText:@"*联系人"];
    lianxirenTF.enterTextField.placeholder=@"请填写联系姓名";
    [lianxirenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dingWeiGreenTF.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    lianxiDianHuaTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
     [self.view addSubview:lianxiDianHuaTF];
     [lianxiDianHuaTF.leftLabel setRedStarText:@"*联系电话"];
     lianxiDianHuaTF.enterTextField.placeholder=@"请填写联系电话";
     [lianxiDianHuaTF mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(lianxirenTF.mas_bottom);
         make.centerX.equalTo(self.view.mas_centerX);
         make.height.equalTo(@50);
         make.width.equalTo(@(SCREEN_WIDTH));
     }];
    lpxieYi = [ToolView btnTitle:@"勾选代表同意代理协议" image:@"nomorl" tag:0 superView:self.view sel:@selector(xieYiClick:) targer:self setStyle:LPButtonStyleLeft font:12];
    [self.view addSubview:lpxieYi];
    [lpxieYi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lianxiDianHuaTF.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@(200));
        make.height.equalTo(@30);
    }];
    UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"提交" delegate:self selector:@selector(tijiao:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lpxieYi.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@(40));
    }];
    btn.layer.cornerRadius = 5;
}
-(void)tijiao:(UIButton *)btn
{
    if(lpxieYi.isSelected == NO)
    {
        [self showDefaultInfo:@"请先勾选相关协议"];
        return;
    }
    if(dingWeiGreenTF.enterTextField.text == nil)
    {
        [self showDefaultInfo:@"请先选择所在地区"];
        return;
    }
    if(lianxirenTF.enterTextField.text == nil)
    {
        [self showDefaultInfo:@"请先填写联系人"];
        return;
    }
    if(lianxiDianHuaTF.enterTextField.text == nil)
    {
        [self showDefaultInfo:@"请先填写联系电话"];
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
//    "": 0,
//    "": "string",
//    "": 0,
//    "": "string",
//    "": 0,
//    "": "string"
    UserInfo *usInfo = [AppManager manager].userInfo;
    [dict setValue:@(usInfo.id) forKey:@"userId"];
    [dict setValue:@(self->provinceId) forKey:@"provinceId"];
    [dict setValue:self->province forKey:@"province"];
    [dict setValue:@(self->cityId) forKey:@"cityId"];
    [dict setValue:self->city forKey:@"city"];
    [dict setValue:@(self->areaId) forKey:@"areaId"];
    [dict setValue:self->area forKey:@"area"];
    [dict setValue:lianxirenTF.enterTextField.text forKey:@"name"];
    [dict setValue:lianxiDianHuaTF.enterTextField.text forKey:@"phone"];
    
    [[ApiFetch share]spotPostFetch:SPOT_DAILIREN_ADD body:dict holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self addAlert];
    }];
    
}
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请成功,等待审核" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
-(void)xieYiClick:(LPButton *) btn
{
    if(btn.isSelected == NO)
      {
          [btn setImage:[UIImage imageNamed: @"select"] forState:UIControlStateNormal];
          btn.isSelected = YES;
      }else{
          [btn setImage:[UIImage imageNamed:@"nomorl"] forState:UIControlStateNormal];
          btn.isSelected = NO;
      }
}
-(void)chooseCitys
{
    YQAlertTableViewController *alertVc = [[YQAlertTableViewController alloc] init];
     alertVc.providesPresentationContextTransitionStyle = YES;
     alertVc.definesPresentationContext = YES;
     alertVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
     __block SaiShiJingLiViewController *weakSelf = self;
     alertVc.citySelectBlock = ^(NSString *provice, NSString *city, NSString *area, NSString *code){
         self->province = provice;
         NSLog(@"%@",code);
         self->provinceId = ([code intValue]/10000*10000);
         self->city = city;
         self->cityId = ([code intValue]/100*100);
         self->area = area;
         self->areaId =[code intValue];
         NSLog(@"%ld %ld",(long)self->provinceId,self->cityId);

//         if(city == nil)
//         {
//             self->cityId = 0;
//             self->city = nil;
//             self->area = nil;
//             self->areaId =0;
//         }else if(area == nil)
//         {
//             self->area = nil;
//             self->areaId =0;
//         }
         self->dingWeiGreenTF.enterTextField.text = [NSString stringWithFormat:@"%@ %@ %@",self->province,((self->city==nil)?@"":self->city),((self->area==nil)?@"":self->area)];
     };
     [self presentViewController:alertVc animated:YES completion:nil];
}
@end
