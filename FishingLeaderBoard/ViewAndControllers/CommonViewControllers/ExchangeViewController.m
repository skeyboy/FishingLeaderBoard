//
//  ExchangeViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/17.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ExchangeViewController.h"

@interface ExchangeViewController ()

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 }
- (IBAction)backkFromExchange:(id)sender {
    @weakify(self)
   [self dismissViewControllerAnimated:YES
                            completion:^{
       UIViewController *vc = [weak_self.fromVc.navigationController.viewControllers objectAtIndex:1];
       [weak_self.fromVc.navigationController popToViewController:vc animated:NO];
   }];
}
- (IBAction)scanExchangeBill:(id)sender {
        [self dismissViewControllerAnimated:YES
                                 completion:^{
            [self.exchangeVcDelegate scanExchangeBill];
        }];
        
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
