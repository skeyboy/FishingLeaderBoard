//
//  BaoMingDetailViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/2.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BaoMingDetailViewController.h"
#import "PKYStepper.h"
#import "YuPosterShareViewController.h"
@interface BaoMingDetailViewController ()
@property (weak, nonatomic) IBOutlet PKYStepper *stepper;

@end

@implementation BaoMingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.stepper.value = 500.0f;
    [self.stepper setButtonTextColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stepper setLabelTextColor:[UIColor blackColor]];
    [self.stepper setBorderColor:[UIColor clearColor]];
       self.stepper.stepInterval = 1.0f;
       self.stepper.valueChangedCallback = ^(PKYStepper *stepper, float count) {
           stepper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
       };
       [self.stepper setup];
}
- (IBAction)showPosterShare:(id)sender {
    YuPosterShareViewController *posterVc = [[YuPosterShareViewController alloc] init];
    posterVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:posterVc
                       animated:YES
                     completion:^{
        
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
