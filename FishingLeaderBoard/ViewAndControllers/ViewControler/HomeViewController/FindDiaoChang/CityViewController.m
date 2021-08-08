//
//  CityViewController.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    NSDictionary * city;
    NSMutableDictionary *citySource;
}
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *citySearcgBar;
@property (weak, nonatomic) IBOutlet UILabel *locationIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *defaultLocationView;

@end

@implementation CityViewController
- (IBAction)cancellCityPicker:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#define CellReuseIdentifier @"CellReuseIdentifier"
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundColor:NAVIGATION_IMG_COLOR];
//    self.citySearcgBar.searchTextField.textColor = [UIColor blackColor];
//    self.citySearcgBar.searchTextField.backgroundColor=[UIColor whiteColor];
   
    CUSTOM_SEARCHBAR(self.citySearcgBar)
    
    self.view.backgroundColor = NAVIGATION_IMG_COLOR;
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    if (self.deafultCityName) {
        self.defaultLocationView.text =[NSString stringWithFormat:@"您正在看:%@", self.deafultCityName];
    } else {
    self.defaultLocationView.text = @"";
    }
    [appDelegate fetchNewLocationInfo:^BOOL(CLLocation * _Nullable location, BMKLocationReGeocode * _Nullable rgcData, NSError *onError) {
        if (onError) {
            [self makeToask:@"定位失败，请手动选择城市"];
        } else {
            self.locationIndicatorView.text = [NSString stringWithFormat:@"当前定位城市:%@",rgcData.city];
        }
        return YES;
    }];
    // Do any additional setup after loading the view from its nib.
    if (@available(iOS 13,*)) {
        self.citySearcgBar.searchTextField.textColor = [UIColor whiteColor];

    } else {
        self.citySearcgBar.backgroundColor = NAVBGCOLOR;
        
        self.citySearcgBar.tintColor = WHITECOLOR;
        self.citySearcgBar.barTintColor = WHITECOLOR;
    }
    self.citySearcgBar.delegate = self;
    NSString * cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    city = [[[NSString alloc] initWithContentsOfURL:[NSURL fileURLWithPath:cityPath] encoding:NSUTF8StringEncoding error:nil] jsonValueDecoded];
   
    [self.cityTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"CellReuseIdentifier"];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    [self.cityTableView reloadData];
    citySource = [NSMutableDictionary dictionaryWithDictionary:city];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier
                                                            forIndexPath:indexPath];
    NSArray * cities = city[[self allTitles][indexPath.section]];
      NSDictionary *cityENtity = cities[indexPath.row];
    NSString * cityName = cityENtity[@"name"];
    NSString *cityId = cityENtity[@"id"];
    cell.textLabel.text = cityName;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    header.text = [self allTitles][section];
    header.backgroundColor = [UIColor lightTextColor];
    UIView *headerBg = [[UIView alloc] initWithFrame:header.bounds];
    headerBg.backgroundColor = [UIColor lightGrayColor];
    [headerBg addSubview:header];
    return headerBg;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * cities = city[[self allTitles][indexPath.section]];
      NSDictionary *cityENtity = cities[indexPath.row];
    NSString * cityName = cityENtity[@"name"];
       NSString *cityId = cityENtity[@"id"];
    if (self.CityResult) {
        self.CityResult(cityName, cityId);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return city.allKeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return  [city[[self allTitles][section]] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self allTitles][section];
}
-(NSArray *) allTitles{
    NSArray *titles = [city.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
           return [obj1 compare:obj2];
       }];
    return titles;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;                               // return list of section titles to display in section index view (e.g. "ABCD...Z#")
{
    return [self allTitles];
}

#pragma 搜索
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        city = citySource;
        [self.cityTableView reloadData];
        return;
    }
    NSMutableDictionary * searchResultCities = [NSMutableDictionary dictionary];
    for (NSString * title in [self allTitles]) {
        NSArray * cities = citySource[title];
        NSMutableArray * items = [NSMutableArray array];
        for (NSDictionary * item in cities) {
            if ([item[@"name"]  containsString: searchText]) {
                [items addObject:item];
            }
        }
        searchResultCities[title] = items;
        
    }
    if (searchResultCities.allValues.count) {
        city = searchResultCities;
    }else{
        if (searchText.length) {
            [self makeToask:@"没有搜索到您输入的城市"];
        }else{
            city = citySource;
        }
    }
    [self.cityTableView reloadData];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}
@end
