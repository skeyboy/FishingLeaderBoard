//
//  ChooseFaBuDateViewController.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/8.
//  Copyright © 2020 yue. All rights reserved.
//

#import "ChooseFaBuDateViewController.h"
#import "BSLCalendar.h"
#import "MonthOpeartion.h"
#import "CalendarModel.h"

@interface ChooseFaBuDateViewController ()

@end

@implementation ChooseFaBuDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavViewWithTitle:@"赛事日期选择" isShowBack:YES];
     hkNavigationView.backgroundColor = NAVBGCOLOR;
    [hkNavigationView setNavBarViewRightBtnWithName:@"确定" target:self action:@selector(endSelect:)];
    [self initPageView];
           NSString *ss = @"";
           for (int i=0; i<[MonthOpeartion defaultMonthOpeartion].selectedDays.count; i++) {
               DayModel *dayModel = [[MonthOpeartion defaultMonthOpeartion].selectedDays objectAtIndex:i];
               if(i==0)
               {
                   ss = [NSString stringWithFormat:@"%ld-%ld-%ld",dayModel.year,dayModel.month,dayModel.day];
               }else{
                  
                    if((i==3)||(i==6))
                    {
                        ss = [NSString stringWithFormat:@"%@\n",ss];

                        ss = [NSString stringWithFormat:@"%@%ld-%ld-%ld",ss,dayModel.year,dayModel.month,dayModel.day];
                    }else{
                      ss = [NSString stringWithFormat:@"%@，%ld-%ld-%ld",ss,dayModel.year,dayModel.month,dayModel.day];

                    }
               }
           }
           self.textView.text = ss;
}
-(void)endSelect:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initPageView
{
       BSLCalendar *calendar = [[BSLCalendar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
       [self.calendarBgView addSubview:calendar];

       calendar.showChineseCalendar = YES;
       [calendar selectDateOfMonth:^(NSInteger year, NSInteger month, NSInteger day) {
           NSLog(@"sss = %@",[MonthOpeartion defaultMonthOpeartion].selectedDays);
           NSString *ss = @"";
           for (int i=0; i<[MonthOpeartion defaultMonthOpeartion].selectedDays.count; i++) {
               DayModel *dayModel = [[MonthOpeartion defaultMonthOpeartion].selectedDays objectAtIndex:i];
               if(i==0)
               {
                   ss = [NSString stringWithFormat:@"%ld-%ld-%ld",dayModel.year,dayModel.month,dayModel.day];
               }else{
                  
                    if((i==3)||(i==6))
                    {
                        ss = [NSString stringWithFormat:@"%@\n",ss];

                        ss = [NSString stringWithFormat:@"%@%ld-%ld-%ld",ss,dayModel.year,dayModel.month,dayModel.day];
                    }else{
                      ss = [NSString stringWithFormat:@"%@，%ld-%ld-%ld",ss,dayModel.year,dayModel.month,dayModel.day];

                    }
               }
           }
           self.textView.text = ss;
       }];
}
@end
