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
- (IBAction)cityLabelClick:(id)sender;

- (IBAction)downBtnClick:(id)sender;
-(void)pushToCityList;

@end

NS_ASSUME_NONNULL_END
@interface UIView (subViewOfClassName)
- (UIView*)subViewOfClassName:(NSString*)className ;
@end
