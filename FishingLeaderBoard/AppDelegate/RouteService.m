//
//  RouteService.m
//  FishingLeaderBoard
//
//  Created by sk on 2021/8/8.
//  Copyright © 2021 yue. All rights reserved.
//

#import "RouteService.h"
#import "AppDelegate.h"
#import "YuQrViewController.h"
#import "InfoBanner.h"
#import "H5Header.h"
@implementation RouteService
+ (void)startService {
    JLRoutes *routes = [JLRoutes globalRoutes];
    
  
    [routes addRoute:@"/scan" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        YuQrViewController * scan = [[YuQrViewController alloc] initWithNibName:@"YuQrViewController" bundle:[NSBundle bundleForClass:YuQrViewController.class]];
        scan.modalPresentationStyle = UIModalPresentationFullScreen;
        [[self currentViewController] presentViewController:scan animated:YES completion:^{
            
        }];
        return  YES;
    }];
    
    [routes addRoute:@"/find" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController*vc =[[NSClassFromString(@"FindDiaoChangViewController") alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    [routes addRoute:@"/find/:spot" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
       
        UIViewController *diaoChangDetailVc = [[NSClassFromString(@"DiaoChangDetailViewController") alloc]init];
//        diaoChangDetailVc.spotId  = spotSurronund.id;
//    [diaoChangDetailVc setValue:@(spotSurronund.id) forKey:@"spotId"]l
    [diaoChangDetailVc setValue:parameters[@"spotId"] forKey:@"spotId"];
        diaoChangDetailVc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:diaoChangDetailVc animated:YES];
        
        return YES;
    }];
    
    [routes addRoute:@"/search/spot" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        UIViewController *vc =[[NSClassFromString(@"SearchViewController") alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    [routes addRoute:@"/find/more/spot" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController*vc =[[NSClassFromString(@"FindDiaoChangViewController") alloc]init];
           vc.hidesBottomBarWhenPushed = YES;
           [[self currentViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    [routes addRoute:@"/banner/click" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        InfoBanner *infoBanner = parameters[@"infoBanner"];
        if(infoBanner.type ==1)
        {
            
            [[JLRoutes globalRoutes] routeURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"/find/%@",@(infoBanner.targetId)]] withParameters:@{
                @"spotId":@(infoBanner.targetId)
            }];
           
        }else if (infoBanner.type == 3)
        {
            UIViewController *vc = [[NSClassFromString(@"EnrollGameNewViewController") alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [vc setValue: @(infoBanner.targetId) forKey:@"eventId"];
            //                vc.eventId = infoBanner.targetId;
            //                vc.isAct = 0;
            [vc setValue:@(0) forKey:@"isAct"];
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }else if (infoBanner.type == 2)
        {
            UIViewController *vc = [[NSClassFromString(@"EnrollGameNewViewController") alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [vc setValue:@(infoBanner.targetId) forKey:@"eventId"];
            [vc setValue:@(1) forKey:@"isAct"];
            
            //                               vc.eventId = infoBanner.targetId;
            //                               vc.isAct = 1;
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }else if (infoBanner.type == 4)
        {
            
            UIViewController * articleVc =[[NSClassFromString(@"H5ArticalDetailViewController") alloc] init];
            
            [articleVc setValue:ARTICAL_DETAIL_URL(infoBanner.targetId) forKey:@"url"];
//            articleVc.url = ARTICAL_DETAIL_URL(articleId);
            articleVc.hidesBottomBarWhenPushed = YES;
            [[self currentViewController].navigationController pushViewController:articleVc
                                                                         animated:YES];
            
        }else if(infoBanner.type == 5){//全部钓场
            [[JLRoutes globalRoutes] routeURL:[NSURL fileURLWithPath:@"/find"]];
        }
        
        
        return YES;
    }];
    
}

+ (UIViewController *)currentViewController {
    UIViewController * rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController * currentViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabBarViewController = (UITabBarController *) rootViewController;
        UIViewController * selectedViewController = tabBarViewController.selectedViewController;
        if ([selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController * currentNav = (UINavigationController *)selectedViewController;
            currentViewController = currentNav.topViewController;
        } else {
            currentViewController = selectedViewController;
        }
    }
    return currentViewController;
}
@end
