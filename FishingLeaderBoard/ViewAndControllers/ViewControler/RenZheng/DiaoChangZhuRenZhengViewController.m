//
//  DiaoChangZhuRenZhengViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangZhuRenZhengViewController.h"
#import "GreenLineTextField.h"
#import "SelectView.h"
#import "RemovableView.h"
#import "IQKeyboardManager.h"
#import "SpotLocationChoseViewController.h"
@interface DiaoChangZhuRenZhengViewController ()<ApiFetchOptionalHandler>
{
    UIScrollView *bgScrollView;
    UIView *bgView;
    
    GreenLineTextField* nameGreenTF;//钓场名称
    GreenLineTextField* dingWeiGreenTF;//钓场定位
    GreenLineTextField* addressGreenTF;//详细地址
    GreenLineTextField* phoneNumGreenTF;//咨询电话
    
    GreenLineTextField* shuiYuMianJiGreenTF;//水域面积
    GreenLineTextField* chiTangNumGreenTF;//池塘数量
    GreenLineTextField* diaoWeiNumGreenTF;//钓位总数量
    GreenLineTextField* diaoWeiSpaceGreenTF;//调位间距
    
    GreenLineTextField* xianGanLengthGreenTF;//限杆长度
    GreenLineTextField* pingJunShuiShenGreenTF;//平均水深
    GreenLineTextField*jianJieGreenTF;
    MySelButton * fengMianTuBtn;
    
    GreenLineTextField* lianXiRenNameGreenTF;//联系人姓名
    GreenLineTextField* lianXiRenPhoneGreenTF;//联系人电话
    GreenLineTextField* yaoqingmaGreenTF;
    GreenLineTextField* tuiguangjingliGreenTF;
    
    
    SelectView *spotTypeView;
    SelectView *fishesView;
    RemovableViewContainer *container;
    __block   CLLocationCoordinate2D mCoordinate;
    __block NSString *_cityId;
}
@end

@implementation DiaoChangZhuRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.spotId !=nil)
    {
        [self setNavViewWithTitle:@"钓场信息修改" isShowBack:YES];
    }else{
        [self setNavViewWithTitle:@"钓场认证" isShowBack:YES];
    }
    [self initPageView];
    if(self.spotId !=nil)
    {
        [[ApiFetch share]spotGetFetch:SPOT_DETAIL_BY_ID query:@{@"spotId":self.spotId} holder:self dataModel:SpotInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            SpotInfo *spotInfo = (SpotInfo*)modelValue;
            self->nameGreenTF.enterTextField.text = spotInfo.name;
            self->dingWeiGreenTF.enterTextField.text = spotInfo.address;
            self->addressGreenTF.enterTextField.text = spotInfo.address;
            self->phoneNumGreenTF.enterTextField.text = spotInfo.phone;
            self->shuiYuMianJiGreenTF.enterTextField.text = [NSString  stringWithFormat:@"%ld" ,spotInfo.waterSquare];
            self->chiTangNumGreenTF.enterTextField.text = [NSString  stringWithFormat:@"%ld" ,spotInfo.waterCount];
            self->diaoWeiNumGreenTF.enterTextField.text = [NSString  stringWithFormat:@"%ld" ,spotInfo.spotCount];
            self->diaoWeiSpaceGreenTF.enterTextField.text = [NSString  stringWithFormat:@"%.1lf" ,spotInfo.spotDistance];
            self->xianGanLengthGreenTF.enterTextField.text = [NSString  stringWithFormat:@"%.1lf" ,spotInfo.rodLong];
            self->pingJunShuiShenGreenTF.enterTextField.text =[NSString  stringWithFormat:@"%.1lf" ,spotInfo.waterDepth];
            self->jianJieGreenTF.textView.text = spotInfo.content;
            self->lianXiRenNameGreenTF.enterTextField.text = spotInfo.leaderName;
            self->lianXiRenPhoneGreenTF.enterTextField.text = spotInfo.leaderPhone;
            NSArray *typeArr = [spotInfo.spotType componentsSeparatedByString:@","];
            NSArray *arr = @[@"1",@"7",@"8",@"9",@"2"];
            NSMutableArray *sArr = [[NSMutableArray alloc]initWithCapacity:0];
            for(NSString *s in typeArr)
            {
                for (int i = 0; i<arr.count; i++) {
                    NSString *ts = [arr objectAtIndex:i];
                    if([ts isEqualToString:s])
                    {
                        [sArr addObject:[NSString stringWithFormat:@"%d",i]];
                    }
                }
            }
            [self->spotTypeView setMoRenSelectedMarkArray:sArr];
            NSArray *arr1 = @[@"鲤鱼",@"鲫鱼",@"青鱼",@"草鱼",@"鲢鳙",@"翘嘴",@"鳊鱼",@"黑鱼",@"罗非",@"鲶鱼",@"鲈鱼",@"红尾",@"黄尾",@"鲳鱼",@"鲟鱼",@"鳕鱼"];
            NSArray *fishArr = [spotInfo.fishes componentsSeparatedByString:@","];
            NSMutableArray*fishArrs = [[NSMutableArray alloc]initWithCapacity:0];
            for (NSString*s in fishArr) {
                for (int i=0; i<arr1.count; i++) {
                    NSString *ts = [arr1 objectAtIndex:i];
                    if([ts isEqualToString:s])
                    {
                        [fishArrs addObject:[NSString stringWithFormat:@"%d",i]];
                    }
                }
            }
            [self->fishesView setMoRenSelectedMarkArray:fishArrs];
            if(spotInfo.icon!=nil)
            {
                self->fengMianTuBtn.isChoosed = YES;
                self->fengMianTuBtn.str = spotInfo.icon;
                [self->fengMianTuBtn sd_setImageWithURL:[NSURL URLWithString:spotInfo.icon] forState:UIControlStateNormal];
                //添加删除按钮
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self->fengMianTuBtn.frame)-10, CGRectGetMinY(self->fengMianTuBtn.frame)-10, 20, 20)];
                imageView.image = [UIImage imageNamed:@"delete.png"];
                [self->bgView addSubview:imageView];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
                    UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
                    [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
                    [t.view removeFromSuperview];
                    self->fengMianTuBtn.isChoosed = NO;
                    self->fengMianTuBtn.str = @"";
                }];
                [imageView addGestureRecognizer:tap];
            }
            self->mCoordinate.latitude = [spotInfo.lat doubleValue];
            self->mCoordinate.longitude = [spotInfo.lng doubleValue];
            
            [self->container bindDefaultsImageFromString:spotInfo.posters];
            if(spotInfo.inviteCode !=nil)
            {
                self->yaoqingmaGreenTF.enterTextField.text =spotInfo.inviteCode;
                self->tuiguangjingliGreenTF.enterTextField.text =spotInfo.commissionerName;
                
            }else{
                self->yaoqingmaGreenTF.enterTextField.enabled = YES;
                self->tuiguangjingliGreenTF.hidden = YES;
                [self->tuiguangjingliGreenTF mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@0);
                }];
            }
            
            //            if(self.spotId !=nil)
            //            {
            //                self->yaoqingmaGreenTF.enterTextField.text =((spotInfo.inviteCode == nil)? @"无":spotInfo.inviteCode);
            //                self->tuiguangjingliGreenTF.enterTextField.text =((spotInfo.commissionerName == nil)? @"无":spotInfo.commissionerName);
            //
            //            }
        }];
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = NO;
}
-(void)initPageView
{
    bgScrollView = [[UIScrollView alloc]init];
    bgScrollView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - Height_NavBar);
    [self.view addSubview:bgScrollView];
    bgView = [FViewCreateFactory createViewWithBgColor:WHITECOLOR];
    [bgScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgScrollView);
        make.width.equalTo(bgScrollView);
        make.height.greaterThanOrEqualTo(bgScrollView.mas_height);
    }];
    
    UIView *bg =[[UIView alloc]init];
    bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.left.equalTo(bgView.mas_left);
        make.width.equalTo(bgView.mas_width);
        make.height.equalTo(@50);
    }];
    UILabel *label = [FViewCreateFactory createLabelWithName:@"基本信息" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [bg addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_top);
        make.left.equalTo(bg.mas_left).offset(20);
        make.height.equalTo(bg.mas_height);
    }];
    
    __weak __typeof(self) weakSelf = self;
    nameGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:nameGreenTF];
    [nameGreenTF.leftLabel setRedStarText:@"*钓场名称"];
    nameGreenTF.enterTextField.placeholder=@"请填写钓场名称";
    [nameGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    dingWeiGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:dingWeiGreenTF];
    [dingWeiGreenTF.leftLabel setRedStarText:@"*钓场位置"];
    dingWeiGreenTF.rightButton.hidden = NO;
    dingWeiGreenTF.enterTextField.tag = TEXTFIELD_BAOMINGJIEZHI_TAG;
    dingWeiGreenTF.enterTextField.placeholder = @"请选择钓场所在的位置";
    dingWeiGreenTF.textFieldClick = ^(UITextField * textField) {
        [self gotoChoseLocation:nil];
    };
    [dingWeiGreenTF.rightButton setImage:[UIImage imageNamed:@"arrow_primary"] forState:UIControlStateNormal];
    [self.appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        if (!onError) {
            self->dingWeiGreenTF.textView.text = [NSString stringWithFormat:@"%@ %@ %@ %@",rgcData.province,rgcData.city,rgcData.description,rgcData.street];
        }
        return YES;
    }];
    
    [dingWeiGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    addressGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:addressGreenTF];
    [addressGreenTF.leftLabel setRedStarText:@"*详细地址"];
    addressGreenTF.enterTextField.placeholder=@"请添加详细地址";
    [addressGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dingWeiGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    phoneNumGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:phoneNumGreenTF];
    [phoneNumGreenTF.leftLabel setRedStarText:@"*咨询电话"];
    phoneNumGreenTF.enterTextField.placeholder=@"请添加咨询电话";
    phoneNumGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumberPad;
    [phoneNumGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    label = [FViewCreateFactory createLabelWithName:@"钓场类型(可多选)" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [label setRedStarText:@"*钓场类型(可多选)"];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@50);
    }];
    
    SelectView *slView = [[SelectView alloc]initWithArr:@[@"  黑坑  ",@"  欢乐塘  ",@"  练竿塘  ",@"  竞技池  ",@"  路亚  "] row:@"5" cornerRadius:3 height:30];
    [bgView addSubview:slView];
    slView.isMuli = YES;//多选
    //    slView.selectIndex = @"0";
    [slView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@40);
    }];
    spotTypeView = slView;
    UIView *line = [FViewCreateFactory createViewWithBgColor:WHITEGRAY];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slView.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH-20));
        make.height.equalTo(@1);
    }];
    shuiYuMianJiGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:shuiYuMianJiGreenTF];
    shuiYuMianJiGreenTF.leftLabel.text = @"水域总面积(亩)";
    shuiYuMianJiGreenTF.enterTextField.placeholder=@"请添加";
    shuiYuMianJiGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [shuiYuMianJiGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    chiTangNumGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:chiTangNumGreenTF];
    chiTangNumGreenTF.leftLabel.text = @"池塘总数量(个)";
    chiTangNumGreenTF.enterTextField.placeholder=@"请添加";
    chiTangNumGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumberPad;
    [chiTangNumGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shuiYuMianJiGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    diaoWeiNumGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaoWeiNumGreenTF];
    diaoWeiNumGreenTF.leftLabel.text = @"钓位总数量(个)";
    diaoWeiNumGreenTF.enterTextField.placeholder=@"请添加";
    diaoWeiNumGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumberPad;
    [diaoWeiNumGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chiTangNumGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    diaoWeiSpaceGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaoWeiSpaceGreenTF];
    diaoWeiSpaceGreenTF.leftLabel.text = @"钓位间距(米)";
    diaoWeiSpaceGreenTF.enterTextField.placeholder=@"请添加";
    diaoWeiSpaceGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [diaoWeiSpaceGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaoWeiNumGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    label = [FViewCreateFactory createLabelWithName:@"鱼种(多选)" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [label setRedStarText:@"*鱼种(多选)"];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaoWeiSpaceGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@50);
    }];
    
    SelectView *mulView = [[SelectView alloc]initWithArr:@[@"  鲤鱼  ",@"  鲫鱼  ",@"  青鱼  ",@"  草鱼  ",@"  鲢鳙  ",@"  翘嘴  ",@"  鳊鱼  ",@"  黑鱼  ",@"  罗非  ",@"  鲶鱼  ",@"  鲈鱼  ",@"  红尾  ",@"  黄尾  ",@"  鲳鱼  ",@"  鲟鱼  ",@"  鳕鱼  "] row:@"5" cornerRadius:3 height:30];
    [bgView addSubview:mulView];
    mulView.isMuli = YES;//多选
    [mulView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@160);
    }];
    fishesView = mulView;
    
    line = [FViewCreateFactory createViewWithBgColor:WHITEGRAY];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mulView.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH-20));
        make.height.equalTo(@1);
    }];
    xianGanLengthGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:xianGanLengthGreenTF];
    xianGanLengthGreenTF.leftLabel.text = @"限杆长度(米)";
    xianGanLengthGreenTF.enterTextField.placeholder=@"请添加";
    xianGanLengthGreenTF.enterTextField.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
    [xianGanLengthGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    pingJunShuiShenGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:pingJunShuiShenGreenTF];
    pingJunShuiShenGreenTF.leftLabel.text = @"平均水深(米)";
    pingJunShuiShenGreenTF.enterTextField.placeholder=@"请添加";
    pingJunShuiShenGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [pingJunShuiShenGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xianGanLengthGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    label = [FViewCreateFactory createLabelWithName:@"钓场封面(单图)" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [label setRedStarText:@"*钓场封面(单图)"];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pingJunShuiShenGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@50);
    }];
    
    fengMianTuBtn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(fengmianClick:) tag:0];
    [fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
    [bgView addSubview:fengMianTuBtn];
    [fengMianTuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@82);
        make.width.equalTo(@(82));
    }];
    UIView * lineView =  [UIView new];
    lineView.backgroundColor = WHITEGRAY;
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianTuBtn.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(1));
    }];
    label = [FViewCreateFactory createLabelWithName:@"渔获图片(多图选填)" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@21);
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    
    container = [[RemovableViewContainer alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(label.frame)+10 , 300, 0) columCount:3];
    container.OnAddClicked = ^(RemovableViewContainer *__weak  _Nonnull selfView){
        NSString * path =   [[NSBundle mainBundle] pathForResource:@"hx_compose_pic_add" ofType:@"png"];
        [selfView addItem:path];
        selfView.backgroundColor = WHITECOLOR;
    };
    //实例
    //    [container bindDefaultsImageFromString:@"https://csdnimg.cn/pubfooter/images/csdn-cxrs.png,https://www.baidu.com/img/baidu_resultlogo@2.png"];
    UIView * av = [UIView new];
    [av addSubview:container];
    [bgView addSubview:av];
    
    lineView =  [UIView new];
    lineView.backgroundColor = WHITEGRAY;
    [bgView addSubview:lineView];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(av.mas_left).offset(20);
        make.width.equalTo(@300);
        make.top.equalTo(av.mas_top).offset(10);
        make.bottom.equalTo(av.mas_bottom).offset(10);
        make.height.greaterThanOrEqualTo(@100);
    }];
    [av mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        make.right.equalTo(bgView.mas_right);
        make.width.equalTo(bgView.mas_width);
        make.height.greaterThanOrEqualTo(@100);
        make.top.equalTo(label.mas_bottom);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(1));
        make.top.equalTo(av.mas_bottom).offset(10);
    }];
    
    jianJieGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:jianJieGreenTF];
    [jianJieGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.centerX.equalTo(bgView.mas_centerX);
        make.height.equalTo(@150);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    jianJieGreenTF.leftLabel.hidden = YES;
    jianJieGreenTF.enterTextField.hidden =YES;
    jianJieGreenTF.textView.hidden = NO;
    jianJieGreenTF.placeHolderLabel.text = @"请输入钓场简介，规则，注意事项等内容";
    
    bg =[[UIView alloc]init];
    bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jianJieGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left);
        make.width.equalTo(bgView.mas_width);
        make.height.equalTo(@50);
    }];
    label = [FViewCreateFactory createLabelWithName:@"联系信息" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [bg addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_top);
        make.left.equalTo(bg.mas_left).offset(20);
        make.height.equalTo(bg.mas_height);
    }];
    
    lianXiRenNameGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:lianXiRenNameGreenTF];
    lianXiRenNameGreenTF.leftLabel.text = @"负责人姓名";
    lianXiRenNameGreenTF.enterTextField.placeholder=@"请添加";
    [lianXiRenNameGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    lianXiRenPhoneGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:lianXiRenPhoneGreenTF];
    lianXiRenPhoneGreenTF.leftLabel.text = @"负责人电话";
    lianXiRenPhoneGreenTF.enterTextField.placeholder=@"请添加";
    lianXiRenPhoneGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumberPad;
    [lianXiRenPhoneGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lianXiRenNameGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    bg =[[UIView alloc]init];
    bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lianXiRenPhoneGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left);
        make.width.equalTo(bgView.mas_width);
        make.height.equalTo(@50);
    }];
    label = [FViewCreateFactory createLabelWithName:@"绑定赛事推广经理" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [bg addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_top);
        make.left.equalTo(bg.mas_left).offset(20);
        make.height.equalTo(bg.mas_height);
    }];
    
    yaoqingmaGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:yaoqingmaGreenTF];
    if(self.spotId !=nil)
    {
        yaoqingmaGreenTF.leftLabel.text = @"赛事推广经理邀请码";
        yaoqingmaGreenTF.enterTextField.enabled = NO;
        yaoqingmaGreenTF.enterTextField.text = @"";
        yaoqingmaGreenTF.enterTextField.placeholder=@"请输入赛事专员邀请码，非必填";
    }else{
        yaoqingmaGreenTF.leftLabel.text = @"赛事推广经理邀请码";
        yaoqingmaGreenTF.enterTextField.placeholder=@"请输入赛事专员邀请码，非必填";
    }
    [yaoqingmaGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    tuiguangjingliGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:tuiguangjingliGreenTF];
    tuiguangjingliGreenTF.leftLabel.text = @"我的赛事推广经理";
    tuiguangjingliGreenTF.enterTextField.keyboardType = UIKeyboardTypeNumberPad;
    [tuiguangjingliGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yaoqingmaGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    if(self.spotId ==nil)
    {
        tuiguangjingliGreenTF.hidden = YES;
        [tuiguangjingliGreenTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else{
        tuiguangjingliGreenTF.enterTextField.enabled = NO;
        tuiguangjingliGreenTF.enterTextField.text = @"";
    }
    label = [FViewCreateFactory createLabelWithName:@"提交信息后请耐心等待2~3个工作日，工作人员会尽快回访核实；加快审核进度，请拨打客服电话：13810347506" font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor]];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    [bg addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tuiguangjingliGreenTF.mas_bottom);
        make.left.equalTo(bg.mas_left).offset(20);
        make.height.equalTo(@(80));
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"提交" delegate:self selector:@selector(tijiao:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(40));
        make.bottom.equalTo(bgView.mas_bottom).offset(-20);
    }];
    btn.layer.cornerRadius = 5;
    
}
//选择钓场位置
-(void)gotoChoseLocation:(UIButton *) sender{
    SpotLocationChoseViewController * spotLocationChoseVc = [[SpotLocationChoseViewController alloc] init];
    spotLocationChoseVc.reverLocationResult = ^(NSString * _Nonnull address, CLLocationCoordinate2D coordinate , NSString *cityId) {
        self->dingWeiGreenTF.enterTextField.text = address;
        self->mCoordinate = coordinate;
        _cityId = cityId;
        
    };
    
    [self.navigationController pushViewController:spotLocationChoseVc
                                         animated:YES];
}
-(void)fengmianClick:(MySelButton *)btn
{
    if (btn.isChoosed == YES) {
        return;
    }
    JJImagePicker *picker = [ToolView selectImageFromAlbum];
    [picker actionSheetWithTakePhotoTitle:@"" albumTitle:@"从相册选择一张图片" cancelTitle:@"取消" InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
        [[ApiFetch share]upload:image success:^(NSString *msg) {
            [self hideHud];
            btn.isChoosed = YES;
            btn.str=msg;
            [btn setImage:image forState:UIControlStateNormal];
            //添加删除按钮
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self->fengMianTuBtn.frame)-10, CGRectGetMinY(self->fengMianTuBtn.frame)-10, 20, 20)];
            imageView.image = [UIImage imageNamed:@"delete.png"];
            [self->bgView addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
                UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
                [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
                [t.view removeFromSuperview];
                self->fengMianTuBtn.isChoosed = NO;
                self->fengMianTuBtn.str = @"";
            }];
            [imageView addGestureRecognizer:tap];
        } failure:^{
            [self hideHud];
        }];
    }];
}
//钓场认证提交
-(void)tijiao:(UIButton *)btn
{
    if (![self.appDelegate hasAuthor]) {
        [self makeToask:@"请开启定位权限"];
        return;
    }
    [self.appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        if (onError) {
            [self makeToask:@"无法获取位置信息，请开启GPS"];
        }else{
            NSLog(@"self->rgcData222222) = %@",rgcData.adCode);
            [self fetchValue:self->mCoordinate
                     rgcData:rgcData loction:location];
            
        }
        return YES;
    }];
    
}

//最终发送请求的地方
-(void)fetchValue:(CLLocationCoordinate2D ) coordinate
          rgcData:(BMKLocationReGeocode * _Nullable) rgcData loction:(CLLocation * _Nullable) location{
    NSMutableDictionary * preRequest = [[NSMutableDictionary alloc]init];
    if(_cityId == nil)
    {
        if(rgcData.adCode == nil)
        {
            [self makeToask:@"请选择您钓场的地址"];
                   return;
        }else{
            [preRequest setValue:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
            [preRequest setValue:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
            [preRequest setValue:rgcData.adCode forKey:@"areaId"];
        }
    }else{
        [preRequest setValue:[NSString stringWithFormat:@"%f", coordinate.longitude] forKey:@"lng"];
        [preRequest setValue:[NSString stringWithFormat:@"%f", coordinate.latitude] forKey:@"lat"];
        [preRequest setValue:_cityId forKey:@"areaId"];
    }
  
    NSString *fishesStr = @"";
    NSString *postersStr = @"";
    NSString *spotTypeStr = @"";
    if((nameGreenTF.enterTextField.text==nil)||(nameGreenTF.enterTextField.text.length == 0))
    {
        [self showDefaultInfo:@"钓场名称不能为空"];
        return;
    }else if ((addressGreenTF.enterTextField.text == nil)||(addressGreenTF.enterTextField.text.length==0))
    {
        [self showDefaultInfo:@"详细地址不能为空"];
        return;
    }else if ((phoneNumGreenTF.enterTextField.text == nil)||(phoneNumGreenTF.enterTextField.text.length==0))
    {
        [self showDefaultInfo:@"咨询电话不能为空"];
        return;
    }
    
    if(fishesView.selectedMarkArray.count == 0)
    {
        [self showDefaultInfo:@"选择鱼种不能为空不能为空"];
        return;
    }else if(fishesView.selectedMarkArray.count != 0)
    {
        NSArray *arr = @[@"鲤鱼",@"鲫鱼",@"青鱼",@"草鱼",@"鲢鳙",@"翘嘴",@"鳊鱼",@"黑鱼",@"罗非",@"鲶鱼",@"鲈鱼",@"红尾",@"黄尾",@"鲳鱼",@"鲟鱼",@"鳕鱼"];
        for(int i = 0 ;i<fishesView.selectedMarkArray.count;i++)
        {
            
            int index = [[fishesView.selectedMarkArray objectAtIndex:i]intValue];
            if(fishesStr.length ==0)
            {
                fishesStr = [arr objectAtIndex:index];
                continue;
            }
            fishesStr = [NSString stringWithFormat:@"%@,%@",fishesStr,[arr objectAtIndex:index]];
        }
    }
    if(spotTypeView.selectedMarkArray.count == 0)
    {
        [self showDefaultInfo:@"钓坑类型不能为空不能为空"];
        return;
    }else if(spotTypeView.selectedMarkArray.count != 0)
    {
        NSArray *arr = @[@"1",@"7",@"8",@"9",@"2"];
        for(int i=0;i<spotTypeView.selectedMarkArray.count;i++)
        {
            int index = [[spotTypeView.selectedMarkArray objectAtIndex:i]intValue];
            if(spotTypeStr.length == 0)
            {
                spotTypeStr = [arr objectAtIndex:index];
                continue;
            }
            spotTypeStr = [NSString stringWithFormat:@"%@,%@",spotTypeStr,[arr objectAtIndex:index]];
        }
    }
    if(container.imageUrls.count != 0)
    {
        for(int i =0;i<container.imageUrls.count;i++)
        {
            if(postersStr.length ==0)
            {
                postersStr = [container.imageUrls objectAtIndex:i];
                continue;
            }
            postersStr = [NSString stringWithFormat:@"%@,%@",postersStr,[container.imageUrls objectAtIndex:i] ];
        }
    }
    
    [preRequest setValue:[AppManager manager].token forKey:@"token"];
    [preRequest setValue:@([AppManager manager].userInfo.id) forKey:@"userId"];
    [preRequest setValue:nameGreenTF.enterTextField.text forKey:@"name"];
  
    
    [preRequest setValue:addressGreenTF.enterTextField.text forKey:@"address"];
    [preRequest setValue:phoneNumGreenTF.enterTextField.text forKey:@"phone"];
    [preRequest setValue:spotTypeStr forKey:@"spotType"];
    [preRequest setValue:@([shuiYuMianJiGreenTF.enterTextField.text floatValue]) forKey:@"waterSquare"];
    [preRequest setValue:@([chiTangNumGreenTF.enterTextField.text intValue]) forKey:@"waterCount"];
    [preRequest setValue:@([diaoWeiNumGreenTF.enterTextField.text intValue]) forKey:@"spotCount"];
    [preRequest setValue:@([diaoWeiSpaceGreenTF.enterTextField.text floatValue]) forKey:@"spotDistance"];
    [preRequest setValue:fishesStr forKey:@"fishes"];
    [preRequest setValue:@([xianGanLengthGreenTF.enterTextField.text floatValue]) forKey:@"rodLong"];
    [preRequest setValue:@([pingJunShuiShenGreenTF.enterTextField.text floatValue]) forKey:@"waterDepth"];
    [preRequest setValue:fengMianTuBtn.str forKey:@"icon"];
    [preRequest setValue:postersStr forKey:@"posters"];
    [preRequest setValue:jianJieGreenTF.textView.text forKey:@"content"];
    [preRequest setValue:lianXiRenNameGreenTF.enterTextField.text forKey:@"leaderName"];
    [preRequest setValue:lianXiRenPhoneGreenTF.enterTextField.text forKey:@"leaderPhone"];
    
    NSLog(@"%@",preRequest);
    @weakify(self)
    NSString *fetchs = nil;
    if(self.spotId !=nil)
    {
        fetchs = SPOT_UPDATE_INFO;
        [preRequest setValue:yaoqingmaGreenTF.enterTextField.text forKey:@"inviteCode"];
    }else{
        fetchs = SPOT_ADD_INFO;
        [preRequest setValue:yaoqingmaGreenTF.enterTextField.text forKey:@"inviteCode"];
        
    }
    [preRequest setValue:self.spotId forKey:@"id"];
    [[ApiFetch share] spotPostFetch:fetchs
                               body:preRequest
                             holder:self
                          dataModel:NSDictionary.class
                          onSuccess:^(NSObject * _Nonnull modelValue, id _Nonnull responseObject) {
        //       TODO 此处补全数据
        [weak_self hideHud];
        //        [self makeToask:@"提交成功等待审核"];
        [weak_self addAlert];
        
    }];
}
-(void)onOptionalFailureHandler:(NSString *_Nullable) message uri:(NSString *_Nullable) uri
{
    [self hideHud];
}
-(BOOL)autoHudForLink:(NSString *) link
{
    //    if([link isEqualToString:])
    return YES;
}
-(void)addAlert{
    NSString *title = nil;
    if(self.spotId !=nil)
    {
        title = @"钓场信息修改成功";
    }else{
        title = @"提交成功等待审核";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //弹出请输入正确的手机号
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
@end
