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
    if (@available(iOS 13,*)) {
           self.searchBar.barStyle = UIBarStyleDefault;
           self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
           self.searchBar.searchTextField.font = [UIFont systemFontOfSize:15];
           self.searchBar.searchTextField.backgroundColor=[UIColor colorWithWhite:1 alpha:0.2];
          self.searchBar.searchTextField.textColor = [UIColor lightGrayColor];
          
      } else {
          _searchBar.backgroundColor = [UIColor clearColor];
          UIView* searchTextField = [_searchBar subViewOfClassName:@"UISearchBarTextField"];
          searchTextField.backgroundColor=[UIColor groupTableViewBackgroundColor];
//          backgroundView.layer.cornerRadius = 14.50f;
//          backgroundView.clipsToBounds = YES;

          //          _searchBar.tintColor = WHITECOLOR;
//          _searchBar.barTintColor = WHITECOLOR;
//
//          UITextField *textfield = nil;
//          UITextField *searchField = nil;
//          [_searchBar valueForKey:@"_searchField"];
//          [textfield setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
//          [textfield setValue:[UIColor colorWithWhite:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
//          textfield.font = [UIFont systemFontOfSize:12];
//          searchField.textColor = WHITECOLOR;
//          for (UIView *subview in _searchBar.subviews) {
//              for(UIView* grandSonView in subview.subviews){
//                  if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//                      grandSonView.alpha = 0.0f;
//                  }else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
//                      NSLog(@"Keep textfiedld bkg color");
//                      grandSonView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//                  }else{
//                      grandSonView.alpha = 0.0f;
//                  }
//              }
//          }
      }
}

- (IBAction)downBtnClick:(id)sender {
    
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
