//
//  ZhangMuGuanLiViewController.h
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/26.
//  Copyright © 2020 yue. All rights reserved.
//

#import "FViewController.h"
#import "AgentInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZhangMuGuanLiViewController : FViewController
@property(nonatomic) AgentInfo *agentInfo;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *yearBtn;

- (IBAction)yearClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *monthBtn;

- (IBAction)monthClick:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *saishishouru;
@property (weak, nonatomic) IBOutlet UILabel *saishibaomingLabel;

@property (weak, nonatomic) IBOutlet UILabel *baomingrenshuLabel;

@property (weak, nonatomic) IBOutlet UITableView *mainTablView;



@end

NS_ASSUME_NONNULL_END
