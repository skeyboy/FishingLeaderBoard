//
//  BSLMonthCollectionView.m
//  CalendarDemo
//
//  Created by shuai pan on 2017/1/20.
//  Copyright © 2017年 BSL. All rights reserved.
//

#import "BSLMonthCollectionView.h"
#import "CalendaDaysCell.h"
#import "NSDate+Decomposer.h"
#import "MonthOpeartion.h"
#import "CalendarModel.h"

@interface BSLMonthCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic ,strong)UICollectionView *collection;
@property (nonatomic ,strong)NSMutableArray *showMonths;
@property (nonatomic ,strong)NSArray *days;
@property (nonatomic ,strong)NSMutableArray *daysArray;
@property (nonatomic ,strong)NSIndexPath *index;


@property (nonatomic ,strong)UILabel *monthLabel;
@property (nonatomic ,assign)NSInteger maxContainer;


@property (nonatomic ,copy)NSString *yearLabel;

@property(nonatomic,strong)NSMutableArray *selectedDays;


@end
@implementation BSLMonthCollectionView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bsl_controls];
    }
    return self;
}
- (void)bsl_controls{
    self.selectedDays = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.daysArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self addSubview:self.monthLabel];

    [self addSubview:self.collection];

    _collection.delegate = self;
    _collection.dataSource = self;

 
}
- (void)calendarContainerWhereMonth:(NSInteger)currentTag month:(void(^)(MonthModel *month))currentMonth{
    __weak typeof(self) weakSelf = self;

    [[MonthOpeartion defaultMonthOpeartion] calendarContainerWithNearByMonths:currentTag daysOfMonth:^(NSArray *daysArray,MonthModel *month) {
        if (daysArray.count>0) {
            [weakSelf.daysArray removeAllObjects];
            [weakSelf.daysArray  addObjectsFromArray: daysArray];
            weakSelf.monthLabel.text = [NSString stringWithFormat:@"%ld",month.month];
            currentMonth(month);
            [weakSelf.collection reloadData];
        }
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    self.collection.frame = CGRectMake(0, 0, w, h);
    self.monthLabel.frame = self.bounds;
    
}

#pragma mark init UICollectionView
- (UICollectionView*)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor clearColor];
        [_collection registerClass:NSClassFromString(@"CalendaDaysCell") forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.daysArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    CalendaDaysCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DayModel *dayModel = self.daysArray[indexPath.row];
    cell.dayModel = dayModel;
    [cell signCurrentDay:dayModel];
    [cell selectedView:dayModel];
    cell.showChinaCalendar = self.showChineseCalendar;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        if (self.selectDateBlock) {
               MonthOpeartion *opeartion = [MonthOpeartion defaultMonthOpeartion];
               CalendaDaysCell *cell = (CalendaDaysCell *)[collectionView cellForItemAtIndexPath:indexPath];
              
            NSString *str = [NSString stringWithFormat:@"%ld-%ld-%ld",opeartion.currentYear,opeartion.currentMonth,cell.dayModel.day];
              DayModel *dayModel = self.daysArray[indexPath.row];
              if(dayModel.isSelectedDay==NO)
              {
                  if([MonthOpeartion defaultMonthOpeartion].selectedDays.count<7)
                  {
                      [[MonthOpeartion defaultMonthOpeartion].selectedDays addObject:dayModel];
                      dayModel.isSelectedDay = YES;
                      [self.selectedDays addObject:str];
                  }
              }else{
                  NSMutableArray *s = [[NSMutableArray alloc]initWithArray:[MonthOpeartion defaultMonthOpeartion].selectedDays];
                                for(int i=0;i<s.count;i++)
                                {
                                    DayModel *d = s[i];
                                    if((d.year == dayModel.year)&&(d.month == dayModel.month)&&(d.day == dayModel.day))
                                    {
                                        [[MonthOpeartion defaultMonthOpeartion].selectedDays removeObject:d];
                                    }
                                }
                  dayModel.isSelectedDay = NO;
                  [self.selectedDays removeObject:str];
              }
              [self.daysArray replaceObjectAtIndex:indexPath.row withObject:dayModel];
               [self.collection reloadData];
             self.selectDateBlock(opeartion.currentYear, opeartion.currentMonth, cell.dayModel.day);
           }
                
    
        
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger weeks = self.daysArray.count/7;
    CGFloat w = CGRectGetWidth(collectionView.bounds);
    CGFloat h = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(w/7.0, h/weeks);
    
}


- (NSMutableArray *)showMonths{
    if (!_showMonths) {
        _showMonths = [NSMutableArray arrayWithCapacity:2];
    }
    return _showMonths;
}


- (UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _monthLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:200/2550.f];
        _monthLabel.font = [UIFont systemFontOfSize:150.0f weight:120.f];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
}













@end
