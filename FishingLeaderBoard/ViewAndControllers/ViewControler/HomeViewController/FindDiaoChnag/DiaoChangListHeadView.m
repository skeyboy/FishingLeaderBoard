//
//  DiaoChangListHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangListHeadView.h"

@implementation DiaoChangListHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.searchTextField.font = [UIFont systemFontOfSize:15];
}

- (IBAction)downBtnClick:(id)sender {
    
}


@end
