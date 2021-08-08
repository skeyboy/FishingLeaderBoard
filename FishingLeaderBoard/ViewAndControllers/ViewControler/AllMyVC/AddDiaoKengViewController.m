//
//  AddDiaoKengViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/5.
//  Copyright © 2020 yue. All rights reserved.
//

#import "AddDiaoKengViewController.h"
#import "AddDiaoKengTableViewCell.h"
#import "AddDiaoKengPageViewController.h"
@interface AddDiaoKengViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray *diaokengArr;
@end

@implementation AddDiaoKengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"设置钓坑" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [self initPageView];
}
-(void)initPageView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.addDiaoKenBtn setBackgroundColor:NAVBGCOLOR];
    self.showTableView.dataSource = self;
    self.showTableView.delegate = self;
    self.showTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.showTableView registerNib:[UINib nibWithNibName:@"AddDiaoKengTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddDiaoKengTableViewCell"];
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.diaokengArr = [[NSMutableArray alloc]init];
    [self reloadData];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.diaokengArr removeAllObjects];
    [[ApiFetch share]spotGetFetch:SPOTPOND_BYUSERID query:@{@"userId":@([AppManager manager].userInfo.id)} holder:self dataModel:SpotPondInfoList.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self.diaokengArr addObjectsFromArray:modelValue];
        [self reloadData];
    }];
}
-(void)reloadData{
    if(self.diaokengArr.count == 0)
    {
        self.meiDIaoKengTiShiLabel.hidden = NO;
        self.showTableView.hidden = YES;
    }else{
        self.meiDIaoKengTiShiLabel.hidden = YES;
        self.showTableView.hidden = NO;
    }
    [self.showTableView reloadData];
}
- (IBAction)addDiaoKeng:(id)sender {
    AddDiaoKengPageViewController*vc = [[AddDiaoKengPageViewController alloc]init];
    vc.spotId = self.spotId;
    vc.spot_pondId = nil;
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.diaokengArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddDiaoKengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDiaoKengTableViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SpotPondInfo *spotPondInfo = [self.diaokengArr objectAtIndex:indexPath.row];
    [cell bindData:spotPondInfo];
    cell.deleteBtnClick = ^{
        [[ApiFetch share]spotGetFetch:SPOT_PONDDELETE query:@{@"id":spotPondInfo.id} holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
            [self.diaokengArr removeObjectAtIndex:indexPath.row];
            [self reloadData];
        }];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddDiaoKengPageViewController*vc = [[AddDiaoKengPageViewController alloc]init];
    SpotPondInfo *spotPondInfo = [self.diaokengArr objectAtIndex:indexPath.row];
    vc.spotId = self.spotId;
    vc.spot_pondId = spotPondInfo.id;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
