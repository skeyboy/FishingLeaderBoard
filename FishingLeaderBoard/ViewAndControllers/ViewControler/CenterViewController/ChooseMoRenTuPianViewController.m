//
//  ChooseMoRenTuPianViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/9.
//  Copyright © 2020 yue. All rights reserved.
//

#import "ChooseMoRenTuPianViewController.h"

@interface ChooseMoRenTuPianViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)NSInteger sRow;
@end

@implementation ChooseMoRenTuPianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"选择默认图片" isShowBack:YES];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    [self.quedingBtn setBackgroundColor:NAVBGCOLOR];
    self.quedingBtn.layer.cornerRadius = 5; 
    self.sRow = 0;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ChooseMoRenTuPianTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChooseMoRenTuPianTableViewCell"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moRenTuPianArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseMoRenTuPianTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseMoRenTuPianTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:[self.moRenTuPianArr objectAtIndex:indexPath.row]]];
    cell.leftBtn.tag = 100+indexPath.row;
    [cell.leftBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    if(self.sRow == indexPath.row)
    {
        [cell.leftBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }else{
        [cell.leftBtn setImage:[UIImage imageNamed:@"nomorl"] forState:UIControlStateNormal];

    }
    return cell;
}
-(void)selectClick:(UIButton*)btn
{
    self.sRow = btn.tag - 100;
    [self.mainTableView reloadData];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.sRow = indexPath.row;
    [self.mainTableView reloadData];
}
- (IBAction)sureClick:(id)sender {
    UIImage *im = [UIImage imageNamed:[self.moRenTuPianArr objectAtIndex:self.sRow]];
    self.selectBtnClick(im,[self.moRenTuPianArr objectAtIndex:self.sRow]);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
