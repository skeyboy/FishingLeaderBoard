//
//  SearchViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self setNavViewWithTitle:@"" isShowBack:YES];
    [hkNavigationView setNavBarViewCenterSearchTag:SEARCH_SEARCH_TAG];
    [hkNavigationView setNavBarViewRightBtnWithName:@"搜索" target:self action:@selector(search:) ];
    hkNavigationView.searchClick = ^(UISearchBar * search) {
        
    };
    
    [self initPageView];
}
-(void)search:(UIButton *)btn
{
    NSString *searchText = hkNavigationView.searchBar.text;
    hkNavigationView.searchBar.text = @"";
    [hkNavigationView.searchBar resignFirstResponder];
    NSLog(@"seach click");
    
}

-(void)initPageView
{
    
}
@end
