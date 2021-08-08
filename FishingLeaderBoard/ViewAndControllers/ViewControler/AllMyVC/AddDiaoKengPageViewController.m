//
//  AddDiaoKengPageViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/9.
//  Copyright © 2020 yue. All rights reserved.
//

#import "AddDiaoKengPageViewController.h"

@interface AddDiaoKengPageViewController ()<UITextFieldDelegate>
{
    UIScrollView *bgScrollView;
    UIView *bgView;
    
    GreenLineTextField* diaokenmingcheng;
    GreenLineTextField* diaokenmianji;
    GreenLineTextField* diaoweishu;
    GreenLineTextField* diaoweijianju;
    GreenLineTextField* pingjunshushen;
    GreenLineTextField* xianganchangdu;
}
@end

@implementation AddDiaoKengPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self initPageView];
    if(self.spot_pondId!=nil)
    {
        [[ApiFetch share]spotGetFetch:SPOT_PONDBYID query:@{@"id":self.spot_pondId} holder:self dataModel:SpotPondInfo.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            SpotPondInfo *spotPondInfo = (SpotPondInfo *)modelValue;
            self->diaokenmingcheng.enterTextField.text = spotPondInfo.name;
            self->diaokenmianji.enterTextField.text =[NSString stringWithFormat:@"%.1f",spotPondInfo.waterSquare];
            self->diaoweishu.enterTextField.text = [NSString stringWithFormat:@"%ld",spotPondInfo.spotCount];
            self->diaoweijianju.enterTextField.text = [NSString stringWithFormat:@"%.1f",spotPondInfo.spotDistance];
            self->pingjunshushen.enterTextField.text =[NSString stringWithFormat:@"%.1f",spotPondInfo.waterDepth];
            self->xianganchangdu.enterTextField.text =[NSString stringWithFormat:@"%.1f",spotPondInfo.rodLong];
        }];
    }
    
}
-(void)initPageView
{
    if(self.spot_pondId==nil)
    {
        [self setNavViewWithTitle:@"添加钓坑" isShowBack:YES];
    }else{
        [self setNavViewWithTitle:@"修改钓坑信息" isShowBack:YES];
        
    }
    [hkNavigationView setNavBarViewRightBtnWithName:@"确定" target:self action:@selector(queDingClick:)];
    bgScrollView = [[UIScrollView alloc]init];
    bgScrollView.frame = CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, 300);
    [self.view addSubview:bgScrollView];
    bgView = [FViewCreateFactory createViewWithBgColor:WHITECOLOR];
    [bgScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgScrollView);
        make.width.equalTo(bgScrollView);
        make.height.greaterThanOrEqualTo(bgScrollView.mas_height);
    }];
    __weak __typeof(self) weakSelf = self;
    diaokenmingcheng = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaokenmingcheng];
    diaokenmingcheng.rightLabel.hidden = NO;
    diaokenmingcheng.rightLabel.text = @"";
    diaokenmingcheng.leftLabel.text = @"钓坑名称";
    diaokenmingcheng.enterTextField.placeholder=@"限15个字";
    diaokenmingcheng.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    [diaokenmingcheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    diaokenmianji = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaokenmianji];
    diaokenmianji.rightLabel.hidden = NO;
    diaokenmianji.rightLabel.text = @"亩";
    diaokenmianji.leftLabel.text = @"钓坑面积";
    diaokenmianji.enterTextField.placeholder=@"限5位数字";
    diaokenmianji.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    diaokenmianji.enterTextField.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
    
    [diaokenmianji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaokenmingcheng.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    diaoweishu = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaoweishu];
    diaoweishu.rightLabel.hidden = NO;
    diaoweishu.rightLabel.text = @"个";
    diaoweishu.leftLabel.text = @"钓位数    ";
    diaoweishu.enterTextField.placeholder=@"限5位数字";
    diaoweishu.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    diaoweishu.enterTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [diaoweishu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaokenmianji.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    diaoweijianju = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:diaoweijianju];
    diaoweijianju.rightLabel.hidden = NO;
    diaoweijianju.rightLabel.text = @"米";
    diaoweijianju.leftLabel.text = @"钓位间距";
    diaoweijianju.enterTextField.placeholder=@"限3位数字";
    diaoweijianju.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    diaoweijianju.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [diaoweijianju mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaoweishu.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    pingjunshushen = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:pingjunshushen];
    pingjunshushen.rightLabel.hidden = NO;
    pingjunshushen.rightLabel.text = @"米";
    pingjunshushen.leftLabel.text = @"平均水深";
    pingjunshushen.enterTextField.placeholder=@"限5位数字";
    pingjunshushen.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    pingjunshushen.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [pingjunshushen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diaoweijianju.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    xianganchangdu = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:xianganchangdu];
    xianganchangdu.rightLabel.hidden = NO;
    xianganchangdu.rightLabel.text = @"米";
    xianganchangdu.leftLabel.text = @"限杆长度";
    xianganchangdu.enterTextField.placeholder=@"限3位数字";
    xianganchangdu.enterTextField.borderStyle = UITextBorderStyleRoundedRect;
    xianganchangdu.enterTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [xianganchangdu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pingjunshushen.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(bgView.mas_bottom);
    }];
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
//    // text field 上实际字符长度
//    NSInteger strLength = textField.text.length - range.length + string.length;
//    return (strLength <= 30);
//}
-(void)queDingClick:(UIButton *)btn
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(self.spot_pondId != nil)
    {
        [dict setValue:self.spot_pondId forKey:@"id"];
    }
    [dict setValue:self.spotId forKey:@"spotId"];
    [dict setValue:diaokenmingcheng.enterTextField.text forKey:@"name"];
    [dict setValue:@([diaokenmianji.enterTextField.text floatValue]) forKey:@"waterSquare"];
    [dict setValue:@([diaoweishu.enterTextField.text intValue]) forKey:@"spotCount"];
    [dict setValue:@([diaoweijianju.enterTextField.text floatValue]) forKey:@"spotDistance"];
    [dict setValue:@([pingjunshushen.enterTextField.text floatValue]) forKey:@"waterDepth"];
    [dict setValue:@([xianganchangdu.enterTextField.text floatValue]) forKey:@"rodLong"];
    NSString *fetchS = nil;
    if(self.spot_pondId !=nil)
    {
        fetchS = SPOT_PONDUPDATE;
    }else{
        fetchS = SPOT_ADDPOND;
    }
    [[ApiFetch share]spotPostFetch:fetchS body:dict holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self addAlert];
    }];
    
    
}
-(void)addAlert{
    NSString *title = nil;
    if(self.spot_pondId !=nil)
    {
        title = @"钓坑信息修改成功";
    }else{
        title = @"钓坑添加成功";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //弹出请输入正确的手机号
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
@end
