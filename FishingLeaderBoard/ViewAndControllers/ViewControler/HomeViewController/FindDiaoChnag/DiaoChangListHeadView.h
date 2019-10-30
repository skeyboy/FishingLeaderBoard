//
//  DiaoChangListHeadView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiaoChangListHeadView : UIView


@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)downBtnClick:(id)sender;


@end

NS_ASSUME_NONNULL_END
