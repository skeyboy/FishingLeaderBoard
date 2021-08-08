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
@interface DiaoChangZhuRenZhengViewController ()
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
    UIButton * fengMianTuBtn;
    
    GreenLineTextField* lianXiRenNameGreenTF;//联系人姓名
    GreenLineTextField* lianXiRenPhoneGreenTF;//联系人电话
}
@end

@implementation DiaoChangZhuRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavViewWithTitle:@"钓场认证" isShowBack:YES];
    [self initPageView];
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
      nameGreenTF.leftLabel.text = @"钓场姓名";
      nameGreenTF.enterTextField.placeholder=@"请填写姓名";
    [nameGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(bg.mas_bottom);
          make.centerX.equalTo(weakSelf.view.mas_centerX);
          make.height.equalTo(@50);
          make.width.equalTo(@(SCREEN_WIDTH));
      }];
    dingWeiGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:dingWeiGreenTF];
    dingWeiGreenTF.leftLabel.text = @"钓场定位";
    dingWeiGreenTF.enterTextField.hidden = YES;
    dingWeiGreenTF.rightButton.hidden = NO;
    [dingWeiGreenTF.rightButton setImage:[UIImage imageNamed:@"arrow_primary"] forState:UIControlStateNormal];
    [dingWeiGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameGreenTF.mas_bottom);
            make.centerX.equalTo(weakSelf.view.mas_centerX);
            make.height.equalTo(@50);
            make.width.equalTo(@(SCREEN_WIDTH));
        }];
    addressGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:addressGreenTF];
    addressGreenTF.leftLabel.text = @"详细地址";
    addressGreenTF.enterTextField.placeholder=@"请添加详细地址";
    [addressGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dingWeiGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    phoneNumGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:phoneNumGreenTF];
    phoneNumGreenTF.leftLabel.text = @"咨询电话";
    phoneNumGreenTF.enterTextField.placeholder=@"请添加咨询电话";
    [phoneNumGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressGreenTF.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    label = [FViewCreateFactory createLabelWithName:@"钓场类型(单选)" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
       [bgView addSubview:label];
       [label mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(phoneNumGreenTF.mas_bottom);
           make.left.equalTo(bgView.mas_left).offset(20);
           make.height.equalTo(@50);
       }];
    
    SelectView *slView = [[SelectView alloc]initWithArr:@[@"  黑坑  ",@"  路亚  ",@"  自然水域  ",@"  海钓  "] row:@"5"];
    [bgView addSubview:slView];
    slView.isMuli = NO;//单选
    slView.selectIndex = @"0";
    [slView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(label.mas_bottom);
           make.centerX.equalTo(weakSelf.view.mas_centerX);
           make.width.equalTo(@(SCREEN_WIDTH));
           make.height.equalTo(@40);
       }];

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
               [diaoWeiSpaceGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.top.equalTo(diaoWeiNumGreenTF.mas_bottom);
                   make.centerX.equalTo(weakSelf.view.mas_centerX);
                   make.height.equalTo(@50);
                   make.width.equalTo(@(SCREEN_WIDTH));
               }];
             
    label = [FViewCreateFactory createLabelWithName:@"鱼种(多选)" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaoWeiSpaceGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@50);
    }];
    
    SelectView *mulView = [[SelectView alloc]initWithArr:@[@"  鲤鱼  ",@"  鲫鱼  ",@"  青鱼  ",@"  草鱼  ",@"  鲢鳙  ",@"  翘嘴  ",@"  鳊鱼  ",@"  黑鱼  ",@"  罗非  ",@"  鲶鱼  ",@"  鲈鱼  ",@"  红尾  ",@"  黄尾  ",@"  鲳鱼  ",@"  鲟鱼  ",@"  鳕鱼  "] row:@"5"];
       [bgView addSubview:mulView];
       mulView.isMuli = YES;//多选
       [mulView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(label.mas_bottom);
              make.centerX.equalTo(weakSelf.view.mas_centerX);
              make.width.equalTo(@(SCREEN_WIDTH));
              make.height.equalTo(@160);
          }];
    
    
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
      [pingJunShuiShenGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(xianGanLengthGreenTF.mas_bottom);
          make.centerX.equalTo(weakSelf.view.mas_centerX);
          make.height.equalTo(@50);
          make.width.equalTo(@(SCREEN_WIDTH));
      }];
    
    label = [FViewCreateFactory createLabelWithName:@"钓场封面(单图)" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
          [bgView addSubview:label];
          [label mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(pingJunShuiShenGreenTF.mas_bottom);
              make.left.equalTo(bgView.mas_left).offset(20);
              make.height.equalTo(@50);
          }];
    
    fengMianTuBtn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(fengmianClick:) tag:0];
       [fengMianTuBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
       fengMianTuBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
       fengMianTuBtn.layer.borderWidth = 1;
       [fengMianTuBtn setImageEdgeInsets:UIEdgeInsetsMake(30,30,30,30)];
       [fengMianTuBtn setBackgroundColor:[UIColor lightGrayColor]];
       [bgView addSubview:fengMianTuBtn];
       [fengMianTuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(label.mas_bottom).offset(10);
           make.left.equalTo(bgView.mas_left).offset(20);
           make.height.equalTo(@70);
           make.width.equalTo(@(70));
       }];
       UIView * lineView =  [UIView new];
       lineView.backgroundColor = WHITEGRAY;
       [bgView addSubview:lineView];
       [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(fengMianTuBtn.mas_bottom).offset(5);
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
       
       RemovableViewContainer *container = [[RemovableViewContainer alloc]initWithFrame:CGRectMake(40,CGRectGetMaxY(label.frame) , 300, 0) columCount:3];
    container.imageWidthAndHieight = 75;
       container.OnAddClicked = ^(RemovableViewContainer *__weak  _Nonnull selfView){
        NSString * path =   [[NSBundle mainBundle] pathForResource:@"plus" ofType:@"png"];
           [selfView addItem:path];
           selfView.backgroundColor = WHITECOLOR;
       };
       UIView * av = [UIView new];
       [av addSubview:container];
       [bgView addSubview:av];
       
       lineView =  [UIView new];
       lineView.backgroundColor = WHITEGRAY;
       [bgView addSubview:lineView];
       [container mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(av.mas_left);
           make.top.equalTo(av.mas_top);
           make.right.equalTo(av.mas_right);
           make.bottom.equalTo(av.mas_bottom);
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
    [self.view addSubview:jianJieGreenTF];
    [jianJieGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
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
      [lianXiRenPhoneGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(lianXiRenNameGreenTF.mas_bottom);
          make.centerX.equalTo(weakSelf.view.mas_centerX);
          make.height.equalTo(@50);
          make.width.equalTo(@(SCREEN_WIDTH));
      }];
     label = [FViewCreateFactory createLabelWithName:@"提交信息后请耐心等待2~3个工作日，工作人员会尽快回访核实；加快审核进度，请拨打客服电话：13810347506" font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor]];
      label.numberOfLines = 0;
      label.textAlignment = NSTextAlignmentLeft;
       [bg addSubview:label];
       [label mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(lianXiRenPhoneGreenTF.mas_bottom);
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
-(void)fengmianClick:(UIButton *)btn
{
    
}
-(void)tijiao:(UIButton *)btn
{
    
}
@end
