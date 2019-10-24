//
//  UserInfoViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
{
    UIScrollView *bgScrollView;
    UIImageView *_userHeadImageView;
    GreenLineTextField *userNameGreenTF;
    GreenLineTextField *phoneNumberGreenTF;
    GreenLineTextField *sexGreenTF;
    GreenLineTextField *areaGreenTF;
    GreenLineTextField *birthdayGreenTF;
    GreenLineTextField *qianMingGreenTF;
}
@property (strong,nonatomic)UIView *editingView;

@end

@implementation UserInfoViewController
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:@"信息编辑" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    de.tbc.tabBar.hidden =YES;
    [self initPageView];
    // 在ViewController加载到时候注册通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)     // 软键盘出现的时候，回调到方法
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)     // 软键盘消失的时候，回调到方法
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if (!(self.editingView && ([self.editingView isKindOfClass:[UITextField class]]||[self.editingView isKindOfClass:[UITextView class]]))) {
        // 如果没有响应者不进行操作
        return;
    }
    //获取currentResponderTextField相对于self.view的frame信息
    CGRect rect = [self.editingView.superview convertRect:self.editingView.frame toView:self.view];
    //获取弹出键盘的frame的value值
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    //获取键盘相对于self.view的frame信息 ，传window和传nil是一样的
    keyboardRect = [self.view convertRect:keyboardRect fromView:self.view.window];
    //弹出软键盘左上角点Y轴的值
    CGFloat keyboardTop = keyboardRect.origin.y;
    //获取键盘弹出动画时间值
    NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationValue doubleValue];
    if (keyboardTop < CGRectGetMaxY(rect)) {
        // true 键盘盖住了输入框
        // 计算整体界面需要往上移动的偏移量，CGRectGetMaxY(rect)表示，输入框Y轴最大值
        CGFloat gap = keyboardTop - CGRectGetMaxY(rect);
        // 存在多个TextField的情况下，可能整体界面可能以及往上移多次，导致self.view的Y轴值不再为0，而是负数
//        gap = gap + self.view.frame.origin.y;
//        __weak typeof(self)weakSelf = self;
//        [UIView animateWithDuration:animationDuration animations:^{
//            weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, gap, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
//        }];
        bgScrollView.contentOffset=CGPointMake(0, -gap);
    }
}


- (void)keyboardWillHide:(NSNotification *)notification {
    if (!(self.editingView && ([self.editingView isKindOfClass:[UITextField class]]||[self.editingView isKindOfClass:[UITextView class]]))) {
        // 如果没有响应者不进行操作
        return;
    }
//    //获取键盘隐藏动画时间值
//    NSDictionary *userInfo = [notification userInfo];
//    NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration = [animationDurationValue doubleValue];
//    if (self.view.frame.origin.y < 0) {
//        //true 证明已经往上移动，软键盘消失时，整个界面要恢复原样
//        __weak typeof(self)weakSelf = self;
//        [UIView animateWithDuration:animationDuration animations:^{
//            weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
//        }];
//    }
    bgScrollView.contentOffset = CGPointMake(0, 0);
}
-(void)initPageView
{
    bgScrollView = [[UIScrollView alloc]init];
    bgScrollView.backgroundColor = WHITECOLOR;
    [self.view addSubview:bgScrollView];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [bgScrollView addGestureRecognizer:tap];
    __weak __typeof(self) weakSelf = self;
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->hkNavigationView.mas_bottom);
        make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(-20);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
    }];
    _userHeadImageView = [FViewCreateFactory createImageViewWithImageName:@"avatar_none"];
    _userHeadImageView.contentMode = UIViewContentModeCenter;
    [bgScrollView addSubview:_userHeadImageView];
    [_userHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->bgScrollView.mas_top).mas_offset(20);
        make.centerX.equalTo(self->bgScrollView.mas_centerX);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    _userHeadImageView.layer.cornerRadius=30;
    _userHeadImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *photo = [FViewCreateFactory createImageViewWithImageName:@"camera"];
    [bgScrollView addSubview:photo];
    [photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userHeadImageView.mas_bottom).offset(-22.5);
        make.left.equalTo(self->_userHeadImageView.mas_right).offset(-22.5);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    UILabel*label = [FViewCreateFactory createLabelWithName:@"上传头像" font:[UIFont systemFontOfSize:15] textColor:BLACKCOLOR];
    [bgScrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self->_userHeadImageView.mas_bottom).offset(15);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@21);
    }];
    
    userNameGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgScrollView addSubview:userNameGreenTF];
    [userNameGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    userNameGreenTF.leftLabel.text = @"昵称";
    userNameGreenTF.enterTextField.text = @"用户-13621019411";
    userNameGreenTF.editingViewBlock = ^(UIView * view) {
        weakSelf.editingView =view;
    };
    phoneNumberGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgScrollView addSubview:phoneNumberGreenTF];
    [phoneNumberGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->userNameGreenTF.mas_bottom);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    phoneNumberGreenTF.leftLabel.text = @"手机号";
    phoneNumberGreenTF.enterTextField.text = @"13621019411";
    phoneNumberGreenTF.leftLabel.textColor = [UIColor lightGrayColor];
    phoneNumberGreenTF.enterTextField.enabled =NO;
    phoneNumberGreenTF.enterTextField.textColor=[UIColor lightGrayColor];
    
    sexGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgScrollView addSubview:sexGreenTF];
    [sexGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->phoneNumberGreenTF.mas_bottom);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    sexGreenTF.leftLabel.text = @"性别";
    sexGreenTF.enterTextField.hidden = YES;
    sexGreenTF.rightButton.hidden = NO;
    [sexGreenTF.rightButton setTitle:@"请选择" forState:UIControlStateNormal];
    
    areaGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgScrollView addSubview:areaGreenTF];
    [areaGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->sexGreenTF.mas_bottom);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    areaGreenTF.enterTextField.hidden = YES;
    areaGreenTF.leftLabel.text = @"地区";
    
    birthdayGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgScrollView addSubview:birthdayGreenTF];
    [birthdayGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->areaGreenTF.mas_bottom);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    birthdayGreenTF.leftLabel.text = @"生日";
    birthdayGreenTF.enterTextField.hidden = YES;
    birthdayGreenTF.rightButton.hidden = NO;
    [birthdayGreenTF.rightButton setTitle:@"请选择日期" forState:UIControlStateNormal];
    
    qianMingGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgScrollView addSubview:qianMingGreenTF];
    [qianMingGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->birthdayGreenTF.mas_bottom);
        make.centerX.equalTo(self->bgScrollView);
        make.height.equalTo(@120);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    qianMingGreenTF.editingViewBlock = ^(UIView * editView) {
        weakSelf.editingView = editView;
    };
    qianMingGreenTF.leftLabel.hidden = YES;
    qianMingGreenTF.enterTextField.hidden =YES;
    qianMingGreenTF.textView.hidden = NO;
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor orangeColor]];
    [confirmBtn setTintColor:WHITECOLOR];
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-30);
        make.height.equalTo(@40);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
}
-(void)confirmBtnClick
{
    [bgScrollView endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
    de.tbc.tabBar.hidden =NO;
    [bgScrollView endEditing:YES];
}
-(void)tap
{
    [bgScrollView endEditing:YES];
}


- (void)dealloc
{
    // 注册了通知，在ViewController消失到时候，要移除通知的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
     object:nil];
}

@end
