//
//  HomeTableViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/18.
//  Copyright © 2019 yue. All rights reserved.
//

#import "HomeTableViewController.h"
#import "DiaoChangDetailViewController.h"
#import "YuQrViewController.h"
#import "FindDiaoChangViewController.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface HomeTableViewController ()<UITableViewDataSource,UITableViewDelegate,FSSegmentTitleViewDelegate>
{
    NSArray *arrTableSource;
}
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.headType == FPageTypeFishingClassHeadView)
    {
        [self setNavFishingClass];
    }else{
        [self setNavHome];
    }
    [self initPageView];
}
-(void)setNavFishingClass
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"钓技课堂" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
}
-(void)setNavHome
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"" isShowBack:NO];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [hkNavigationView setNavBarViewLeftBtnWithTitle:@"扫一扫" normalImage:@"saoyisao" highlightedImage:@"saoyisao" target:self action:@selector(btnLeftClick:)];
    [hkNavigationView setNavBarViewRightBtnWithTitle:@"消息" normalImage:@"msg" highlightedImage:@"msg" target:self action:@selector(btnRightClick:)];
    
    [hkNavigationView setNavBarViewCenterSearchTag:SEARCH_HOME_TAG];
    __weak __typeof(self) weakSelf = self;
    hkNavigationView.searchClick = ^(UISearchBar *se) {
        SearchViewController *vc =[[SearchViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
-(void)btnLeftClick:(UIButton *)btn
{
//    TODO
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    //读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请在iOS设置中打开App相机使用权限";
        [hud hideAnimated:YES
               afterDelay:1.0];
        return;
    
    }
    
    YuQrViewController *qrScanVC  =[[YuQrViewController alloc] init];
    qrScanVC.modalPresentationStyle = UIModalPresentationFullScreen;
    qrScanVC.qrResult = ^(NSArray<LBXScanResult *> * result) {
        
    };
    [self presentViewController:qrScanVC animated:YES completion:^{
        
    }];
}

-(void)btnRightClick:(UIButton *)btn
{
    
}
-(void)initPageView
{
    arrTableSource = @[@"账号和或或或或或或",@"男男女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女女斤斤计较军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军军"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainOneTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainNoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainNoTableViewCell"];
    int headY = 0;
    if(_headType == FPageTypeHomeHeadView)
    {
        headY = 120 +150 +120 + 80 + 45;
    }else{
        headY = 40 + 10 + 60 + 10 + 60 + 10 + 45;
    }
    self.headView = [[HomeHeadTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headY) withType:_headType vc:self];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    __weak __typeof(self) weakSelf = self;
    self.headView.btnCtrlClick = ^(UIButton * btn) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        [strongSelf btnClick:btn];
    };
   
}
#pragma mark - 
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 3||indexPath.row ==8 )
    {
        MainOneTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MainOneTableViewCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleTextLabel.text = [arrTableSource objectAtIndex:(indexPath.row%2)];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://www.51pptmoban.com/d/file/2014/01/20/e382d9ad5fe92e73a5defa7b47981e07.jpg"] placeholderImage:nil];
        cell.timeLabel.text = @"19/19月05日 17：16";
        return cell;
    }else if(indexPath.row == 2)
    {
        MainNoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainNoTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"哈哈哈哈哈或或或";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 9)
    {
        MainNoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainNoTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"哈哈哈哈哈或或或案件噢ID渐浓此女IE荣VR按此内内此女of是你去你哦是农女 你才能从偶发内容一农村人";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        MainTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleTextLabel.text = [arrTableSource objectAtIndex:(indexPath.row%2)];
        cell.imageView1.image = [UIImage imageNamed:@"page1"];
        //cell.imageView2.image = [UIImage imageNamed:@"page1"];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://www.51pptmoban.com/d/file/2014/01/20/e382d9ad5fe92e73a5defa7b47981e07.jpg"] placeholderImage:nil];
        cell.imageView3.image = [UIImage imageNamed:@"page1"];
        cell.detailTimeLabel.text = @"19/19月05日 17：16";
        return cell;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)btnClick:(UIButton *)btn
{
    
    NSInteger tag = btn.tag;
    switch (tag) {
        case BUTTON_FISHCLASS_HOME_TAG:
            {
//                HomeTableViewController *fishingClassVc = [[HomeTableViewController alloc]init];
//                fishingClassVc.headType = FPageTypeFishingClassHeadView;
//                [self.navigationController pushViewController:fishingClassVc animated:YES];
                
                DiaoChangDetailViewController *diaoChangDetailVc = [[DiaoChangDetailViewController alloc]init];
                AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
                           de.tbc.tabBar.hidden =YES;
                [self.navigationController pushViewController:diaoChangDetailVc animated:YES];
            }
            break;
            case BUTTON_FAXIANYUCHANG_HOME_TAG:
        {
            FindDiaoChangViewController*vc =[[FindDiaoChangViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
            AppDelegate *de =(AppDelegate *)[UIApplication sharedApplication].delegate;
            de.tbc.tabBar.hidden =YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

@end
