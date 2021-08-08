//
//  FNavigationView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/16.
//  Copyright © 2019 yue. All rights reserved.
//

#import "FNavigationView.h"
#import "NSString+StringSize.h"
#define NAVIGATIONVIEW_LEFTBUTTON_FRAME (CGRect){0, Height_StatusBar, 70, 50}  //!<导航视图左侧按钮的Frame
#define NAVIGATIONVIEW_RIGHTBUTTON_FRAME (CGRect){SCREEN_WIDTH - 70, Height_StatusBar, 70, 50}
NS_ASSUME_NONNULL_BEGIN
@interface FNavigationView ()<UISearchBarDelegate>
{
    LPButton    *btnLeft;  //!<左侧按钮
    LPButton    *btnRight;  //!<右侧按钮

}

@end

@implementation FNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = NAVBGCOLOR;
        _navLineView = [FViewCreateFactory createViewWithFrame:(CGRect){0, frame.size.height - 0.5, frame.size.width, 0.5} bgColor:UIColorFromRGB(0xdddddd)];
        [self addSubview:_navLineView];
        
        self.lblTitle = [FViewCreateFactory createLabelWithFrame:(CGRect){0, Height_StatusBar, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - Height_StatusBar}
                                                             name:@""
                                                             font:[UIFont systemFontOfSize:17.0f]
                                                        textColor:WHITECOLOR
                                                    textAlignment:NSTextAlignmentCenter];
        _lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _lblTitle.numberOfLines = 0;
        [self addSubview:_lblTitle];
    }
    return self;
}

- (void)setNavLineHidden
{
    _navLineView.hidden = YES;
}

/**
 *  设置导航视图标题
 *
 *  @param title 标题
 */
- (void)setNavBarViewTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

#pragma mark - 返回按钮

/**
 *  初始化导航视图返回按钮
 *
 *  @param target    事件响应者
 *  @param action    响应函数
 */
- (void)setNavBarViewBackBtnWithtarget:(id)target
                                action:(SEL)action
{
    btnLeft = [FViewCreateFactory createCustomButtonWithFrame:NAVIGATIONVIEW_LEFTBUTTON_FRAME
                                                          name:nil
                                                      delegate:target
                                                      selector:action
                                                           tag:NAVIGATIONVIEW_LEFTBUTTON_TAG];
    
    [btnLeft setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateHighlighted];
    [self addSubview:btnLeft];
}

#pragma mark - 导航视图左侧按钮

/**
 *  初始化导航视图左侧按钮(不带标题的)
 *
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewLeftBtnWithNormalImage:(NSString *)normalImage
                           highlightedImage:(NSString *)highlightedImage
                                     target:(id)target
                                     action:(SEL)action
{
    btnLeft = [FViewCreateFactory createCustomButtonWithFrame:NAVIGATIONVIEW_LEFTBUTTON_FRAME
                                                          name:nil
                                                      delegate:target
                                                      selector:action
                                                           tag:NAVIGATIONVIEW_LEFTBUTTON_TAG];
    
    [btnLeft setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [self addSubview:btnLeft];
}

/**
 *  初始化导航视图左侧按钮(带标题的)
 *
 *  @param title            标题
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewLeftBtnWithTitle:(NSString *)title
                          normalImage:(NSString *)normalImage
                     highlightedImage:(NSString *)highlightedImage
                               target:(id)target
                               action:(SEL)action
{
    btnLeft  = [[LPButton alloc] init];
    btnLeft.style = LPButtonStyleTop;
    btnLeft.frame = NAVIGATIONVIEW_LEFTBUTTON_FRAME;
    [btnLeft setTitle:title forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnLeft setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [btnLeft addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnLeft];
//    [self setNavBarViewLeftBtnWithTitle:title
//         normalImage:normalImage
//    highlightedImage:highlightedImage
//           titleFont:10
//              target:target
//                                 action:action];
}
- (void)setNavBarViewLeftBtnWithTitle:(NSString *)title
     normalImage:(NSString *)normalImage
highlightedImage:(NSString *)highlightedImage
       titleFont:(float )fontSize
          target:(id)target
                                action:(SEL)action{
    
    btnLeft  = [[LPButton alloc] init];
      btnLeft.style = LPButtonStyleLeft;
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    btnLeft.frame = (CGRect){0, Height_StatusBar-10, [title sizeWithFont: btnLeft.titleLabel.font inHeight:30].width*2.5, 45}  ;
      [btnLeft setTitle:title forState:UIControlStateNormal];
      [btnLeft setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
      [btnLeft setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [btnLeft addTarget:target action:action?action:@selector(btnClickBack) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:btnLeft];
    
}

- (UIButton *)getNavBarLeftBtn
{
    return btnLeft;
}

- (void)setNavBarViewLeftBtnTag:(NSInteger)tag
{
    btnLeft.tag = tag;
}

/**
 *  设置左侧返回键为白色按钮
 */
-(void)setNavLeftWhiteBack
{
    [btnLeft setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateHighlighted];
}

#pragma mark - 导航视图右侧按钮

/**
 *  初始化导航视图右侧按钮(不带标题的)
 *
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewRightBtnWithNormalImage:(NSString *)normalImage
                            highlightedImage:(NSString *)highlightedImage
                                      target:(id)target
                                      action:(SEL)action
{
    btnRight = [FViewCreateFactory createCustomButtonWithFrame:NAVIGATIONVIEW_RIGHTBUTTON_FRAME
                                                           name:nil
                                                       delegate:target
                                                       selector:action
                                                            tag:NAVIGATIONVIEW_RIGHTBUTTON_TAG];
    
    [btnRight setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    
    [self addSubview:btnRight];
}

/**
 *  更新导航栏右侧按钮图标
 *
 *  @param imageName 图标名称
 */
- (void)updateRightBtnImage:(NSString *)imageName
{
    if (btnRight)
    {
        [btnRight setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btnRight setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
}

/**
 *  初始化右侧按钮(带标题的)
 *
 *  @param title            标题
 *  @param normalImage      常态下的图片名称
 *  @param highlightedImage 选中状态下的图片名称
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewRightBtnWithTitle:(NSString *)title
                           normalImage:(NSString *)normalImage
                      highlightedImage:(NSString *)highlightedImage
                                target:(id)target
                                action:(SEL)action
{
    btnRight  = [[LPButton alloc] init];
    btnRight.style = LPButtonStyleTop;
    btnRight.frame = NAVIGATIONVIEW_RIGHTBUTTON_FRAME;
    [btnRight setTitle:title forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnRight setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [btnRight addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnRight];
}
/**
 *  初始化导航视图右侧按钮(不带图片的)
 *
 *  @param target           事件响应者
 *  @param action           响应函数
 */
- (void)setNavBarViewRightBtnWithName:(NSString *)nameStr
                                      target:(id)target
                                      action:(SEL)action
{
    btnRight = [FViewCreateFactory createCustomButtonWithFrame:NAVIGATIONVIEW_RIGHTBUTTON_FRAME
                                                          name:nameStr
                                                      delegate:target
                                                      selector:action
                                                           tag:NAVIGATIONVIEW_RIGHTBUTTON_TAG];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [self addSubview:btnRight];
}
- (void)setNavBarViewRightBtnWithTitle:(NSString *)title
                           normalImage:(NSString *)normalImage
                      highlightedImage:(NSString *)highlightedImage
                             titleFont:(float )fontSize
                                target:(id)target
                                action:(SEL)action
{
    btnRight  = [[LPButton alloc] init];
    btnRight.style = LPButtonStyleRight;
    btnRight.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [btnRight setTitle:title forState:UIControlStateNormal];

    btnRight.frame = (CGRect){SCREEN_WIDTH - 45-[title sizeWithFont: btnRight.titleLabel.font inHeight:30].width, Height_StatusBar-10, [title sizeWithFont: btnRight.titleLabel.font inHeight:30].width*2, 45};
    [btnRight setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btnRight setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [btnRight addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnRight];
}
-(void)setNavBarViewLeftSearchTag:(int)tag
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, Height_StatusBar + 10, SCREEN_WIDTH - 70, 35)];
        _searchBar.delegate = self;
        _searchBar.tag = tag;
        _searchBar.placeholder = @"搜索钓场关键字";

    if (@available(iOS 13,*)) {
         self.searchBar.barStyle = UIBarStyleDefault;
         self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
         self.searchBar.searchTextField.font = [UIFont systemFontOfSize:15];
         self.searchBar.searchTextField.backgroundColor=WHITECOLOR;
        self.searchBar.searchTextField.textColor = BLACKCOLOR;
        self.searchBar.tintColor = BLACKCOLOR;
    } else {
        _searchBar.backgroundColor = NAVBGCOLOR;
        _searchBar.tintColor = BLACKCOLOR;
        _searchBar.barTintColor = BLACKCOLOR;
       
        UITextField *textfield = nil;
        UITextField *searchField = nil;
        [_searchBar valueForKey:@"_searchField"];
        [textfield setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
        [textfield setValue:BLACKCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        textfield.font = [UIFont systemFontOfSize:12];
        searchField.textColor = WHITECOLOR;
        for (UIView *subview in _searchBar.subviews) {
            for(UIView* grandSonView in subview.subviews){
                if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                    grandSonView.alpha = 0.0f;
                }else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                    NSLog(@"Keep textfiedld bkg color");
                    grandSonView.backgroundColor = WHITECOLOR;
                }else{
                    grandSonView.alpha = 0.0f;
                }
            }
        }
    }
    CUSTOM_SEARCHBAR(_searchBar)
    [self addSubview:_searchBar];
}
-(UITextField *)searBarTextField{
   id provider = [_searchBar valueForKey:@"_visualProvider"] ;
    UITextField * textField = [provider valueForKey:@"_searchField"];
    return textField;
}
-(void)setNavBarViewCenterSearchTag:(int)tag
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(70, Height_StatusBar + 10, SCREEN_WIDTH - 70 -70, 35)];
    _searchBar.placeholder = @"请输入您感兴趣的关键字";
    _searchBar.delegate = self;
    _searchBar.tag = tag;
    
    if (@available(iOS 13,*)) {
         self.searchBar.barStyle = UIBarStyleDefault;
         self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
         self.searchBar.searchTextField.font = [UIFont systemFontOfSize:15];
         self.searchBar.searchTextField.backgroundColor=WHITECOLOR;
        self.searchBar.searchTextField.textColor = BLACKCOLOR;
        self.searchBar.tintColor = BLACKCOLOR;

        
    } else {
        _searchBar.backgroundColor = NAVBGCOLOR;
        _searchBar.tintColor = BLACKCOLOR;
        _searchBar.barTintColor = BLACKCOLOR;
        UITextField *textfield = nil;
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        [textfield setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
        [textfield setValue:BLACKCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        textfield.font = [UIFont systemFontOfSize:12];
        textfield.textColor = BLACKCOLOR;
        searchField.textColor = BLACKCOLOR;
        for (UIView *subview in _searchBar.subviews) {
            for(UIView* grandSonView in subview.subviews){
                if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                    grandSonView.alpha = 0.0f;
                }else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                    NSLog(@"Keep textfiedld bkg color");
                    grandSonView.backgroundColor = WHITECOLOR;
                }else{
                    grandSonView.alpha = 0.0f;
                }
            }
        }
    }
    [self addSubview:_searchBar];

}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if((searchBar.tag == SEARCH_HOME_TAG)||(searchBar.tag == SEARCH_FAXIAN_TAG))
       {
           [_searchBar resignFirstResponder];
           self.searchClick(searchBar);
           return NO;
       }
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(searchBar.tag == SEARCH_SEARCH_TAG)
    {
        [searchBar endEditing:YES];
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchBar.tag == SEARCH_SEARCH_TAG)
      {
          self.searchClick(searchBar);
      }
}
- (void)setNavBarViewRightBtnTag:(NSInteger)tag
{
    btnRight.tag = tag;
}

- (UIButton *)getNavBarRightBtn
{
    return btnRight;
}

- (UILabel *)getNavBarTitleLabel
{
    return self.lblTitle;
}


@end
NS_ASSUME_NONNULL_END
