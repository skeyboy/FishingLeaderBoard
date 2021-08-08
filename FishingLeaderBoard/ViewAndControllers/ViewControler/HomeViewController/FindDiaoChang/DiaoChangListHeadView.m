//
//  DiaoChangListHeadView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/30.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DiaoChangListHeadView.h"
#import "CityViewController.h"
#import "DiaoChangListViewController.h"

@implementation DiaoChangListHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
       
       if (@available(iOS 13,*)) {
            self.searchBar.barStyle = UIBarStyleDefault;
            self.searchBar.searchTextField.font = [UIFont systemFontOfSize:15];
            self.searchBar.searchTextField.backgroundColor=[UIColor whiteColor];
           self.searchBar.searchTextField.textColor = [UIColor blackColor];
           self.searchBar.backgroundColor = [UIColor whiteColor];
           self.searchBar.barTintColor = BLACKCOLOR;
           self.searchBar.tintColor = [UIColor whiteColor];

           
       } else {
           _searchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
           _searchBar.tintColor = BLACKCOLOR;
           _searchBar.barTintColor = BLACKCOLOR;
          
           UITextField *textfield = nil;
           UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
           [textfield setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
           [textfield setValue:[UIColor colorWithWhite:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
           textfield.font = [UIFont systemFontOfSize:12];
           textfield.textColor = BLACKCOLOR;
           searchField.textColor = BLACKCOLOR;
           for (UIView *subview in _searchBar.subviews) {
               for(UIView* grandSonView in subview.subviews){
                   if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                       grandSonView.alpha = 0.0f;
                   }else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                       NSLog(@"Keep textfiedld bkg color");
                       grandSonView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
                   }else{
                       grandSonView.alpha = 0.0f;
                   }
               }
           }
       }
    
}

- (IBAction)cityLabelClick:(id)sender {
    [self pushToCityList];

}

- (IBAction)downBtnClick:(id)sender {
    [self pushToCityList];
}
-(void)pushToCityList{
    @weakify(self)
       CityViewController *cityVc = [[CityViewController alloc] init];
       cityVc.CityResult = ^(NSString * _Nonnull cityName, NSString * _Nonnull cityId) {
           weak_self.cityLabel.text = cityName;
           DiaoChangListViewController *diaChangVC =  weak_self.viewController;
           [diaChangVC userSelect:cityName
                           cityId:cityId];
       };
       [self.viewController.navigationController pushViewController:cityVc
                                                           animated:YES];

}


@end
@implementation UIView (subViewOfClassName)

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }

        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

@end
