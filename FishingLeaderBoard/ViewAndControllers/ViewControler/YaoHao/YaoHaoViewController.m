//
//  YaoHaoViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/22.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YaoHaoViewController.h"
#import "YaoHaoTableViewCell.h"
@interface YaoHaoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation YaoHaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageView];
}
-(void)initPageView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"抽号" isShowBack:YES];
    [hkNavigationView setNavLineHidden];
    hkNavigationView.backgroundColor = NAVBGCOLOR;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(hkNavigationView.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"YaoHaoTableViewCell" bundle:nil] forCellReuseIdentifier:@"YaoHaoTableViewCell"];

    [self.view addSubview:self.tableView];
    
    UIButton *btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(20, SCREEN_HEIGHT-60, SCREEN_WIDTH/2 - 25, 40) name:@"手机号添加" delegate:self selector:@selector(addPhoneNum:) tag:0];
     btn.backgroundColor = NAVBGCOLOR;
     btn.layer.cornerRadius = 5.0;
     [self.view addSubview:btn];
     btn = [FViewCreateFactory createCustomButtonWithFrame:CGRectMake(SCREEN_WIDTH/2+10, SCREEN_HEIGHT-60, SCREEN_WIDTH/2-25 , 40) name:@"二维码扫描" delegate:self selector:@selector(addByScan:) tag:0];
       btn.backgroundColor = NAVBGCOLOR;
       btn.layer.cornerRadius = 5.0;
       [self.view addSubview:btn];
}
#pragma mark -点击事件
-(void)addPhoneNum:(UIButton *)btn
{
    [self addAlert];

}
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"号码分配" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请添加手机号" ;
        }];
         UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
             //弹出请输入正确的手机号
             [self addAlert];
         }];
      UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
}
-(void)addByScan:(UIButton *)btn
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
        return 1;
    }else{
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
          if(cell == nil)
          {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
          }
        cell.textLabel.text = @"待抽号人数：6人";
        return cell;
    }else{
        YaoHaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YaoHaoTableViewCell" forIndexPath:indexPath];
           [cell.headBtn setImage:[UIImage imageNamed:@"page1"] forState:UIControlStateNormal];
           return cell;
    }
}
@end
