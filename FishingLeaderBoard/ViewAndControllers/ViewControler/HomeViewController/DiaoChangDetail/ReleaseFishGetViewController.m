//
//  ReleaseFishGetViewController.m
//  FishingLeaderBoard
//   发渔获
//  Created by yue on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ReleaseFishGetViewController.h"
#import "RemovableView.h"
#import "GreenLineTextField.h"
@interface ReleaseFishGetViewController ()
{
    GreenLineTextField* sayGreenTF;
    GreenLineTextField* titleGreenTF;
    UIScrollView *bgScrollView;
    UIButton *fenMianTuBtn;
}
@end

@implementation ReleaseFishGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"发布渔获" isShowBack:YES];
    bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar)];
    [self.view addSubview:bgScrollView];
    NSLog(@"height = %f",Height_NavBar);
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - Height_NavBar)];
    [bgScrollView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgScrollView);
        make.width.equalTo(bgScrollView);
        make.height.greaterThanOrEqualTo(bgScrollView.mas_height);
    }];
    
    UILabel *label = [FViewCreateFactory createLabelWithName:@"发布到 聚缘休闲垂钓园" font:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft];
    label.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, 21);
    [bgView addSubview:label];
    titleGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
       [bgView addSubview:titleGreenTF];
    [titleGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(label.mas_bottom).offset(20);
           make.left.equalTo(bgView.mas_left);
           make.height.equalTo(@50);
           make.width.equalTo(@(SCREEN_WIDTH));
       }];
       titleGreenTF.leftTextField.placeholder=@"渔获标题";
       titleGreenTF.leftLabel.hidden = YES;
       titleGreenTF.enterTextField.hidden =YES;
       titleGreenTF.leftTextField.hidden = NO;
    __weak __typeof(self) weakSelf = self;
    sayGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:sayGreenTF];
    [sayGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleGreenTF.mas_bottom);
        make.left.equalTo(bgView.mas_left);
        make.height.equalTo(@300);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    sayGreenTF.leftLabel.hidden = YES;
    sayGreenTF.enterTextField.hidden =YES;
    sayGreenTF.textView.hidden = NO;
    sayGreenTF.placeHolderLabel.text = @"说点什么吧~";
    
    label = [FViewCreateFactory createLabelWithName:@"渔获封面图(单图必填)" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(sayGreenTF.mas_bottom).offset(10);
          make.left.equalTo(bgView.mas_left).offset(20);
          make.height.equalTo(@21);
          make.width.equalTo(@(SCREEN_WIDTH-40));
      }];
    
    fenMianTuBtn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(fengmianClick:) tag:0];
    [fenMianTuBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    fenMianTuBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    fenMianTuBtn.layer.borderWidth = 1;
    [fenMianTuBtn setImageEdgeInsets:UIEdgeInsetsMake(30,30,30,30)];
    [fenMianTuBtn setBackgroundColor:[UIColor lightGrayColor]];
    [bgView addSubview:fenMianTuBtn];
    [fenMianTuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@70);
        make.width.equalTo(@(70));
    }];
    UIView * lineView =  [UIView new];
    lineView.backgroundColor = WHITEGRAY;
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(fenMianTuBtn.mas_bottom).offset(5);
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
    container.OnAddClicked = ^(RemovableViewContainer *__weak  _Nonnull selfView){
     NSString * path =   [[NSBundle mainBundle] pathForResource:@"plus" ofType:@"png"];
        [selfView addItem:path];
        selfView.backgroundColor = WHITEGRAY;
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
        make.bottom.equalTo(lineView.mas_top);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(1));
        make.top.equalTo(av.mas_bottom).offset(10);
    }];
    
    UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"发布" delegate:self selector:@selector(faBu:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(lineView.mas_bottom).offset(10);
          make.left.equalTo(bgView.mas_left).offset(10);
          make.right.equalTo(bgView.mas_right).offset(-10);
          make.height.equalTo(@(40));
          make.bottom.equalTo(bgView.mas_bottom).offset(-20);
      }];
    btn.layer.cornerRadius = 5;
}

-(void)faBu:(UIButton*)Btn
{
    
}
-(void)fengmianClick:(UIButton *)btn
{
    
}
@end
