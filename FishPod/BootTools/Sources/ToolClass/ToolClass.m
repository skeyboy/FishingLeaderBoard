//
//  ToolClass.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ToolClass.h"
#import "JZLocationConverter.h"

@implementation ToolClass

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
// 根据颜色生成UIImage
+ (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays =
    [NSArray arrayWithObjects:
     [NSNull null], @"周日", @"周一", @"周二", @"周三",@"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone =  [NSTimeZone timeZoneForSecondsFromGMT:0*60*60];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//得到当前时间

+ (NSString *)getCurrentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}

//将字符串转成NSDate类型

+ (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
//将字符串转成NSDate类型

+ (NSDate *)dateFromString5:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy年MM月dd日"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
+ (NSDate *)dateFromString2:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

+(NSString *)dateToString:(NSDate *)date
{
    NSLog(@"转化前时间-date %@",date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSLog(@"转化后时间-date %@",strDate);

    return strDate;
}
+(NSString *)dateToString4:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
+(NSString *)dateToString2:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
       NSString *strDate = [dateFormatter stringFromDate:date];
       return strDate;
}
+(NSString *)dateToString3:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"yyyy/MM/dd"];
       NSString *strDate = [dateFormatter stringFromDate:date];
       return strDate;
}
+(NSString *)dateToString1:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];

    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
+ (NSDate *)dateFromString1:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
+(NSString *)qianjiTianWeek:(int)num
{
    
    NSDate *date =[NSDate date];//当前时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDate *lastDay = [NSDate dateWithTimeInterval:num*24*60*60 sinceDate:localeDate];//前num天
    return [self weekdayStringFromDate:lastDay];
}
+(NSString *)qianJiTianDate:(int)num
{
    NSDate *date =[NSDate date];//当前时间
    NSLog(@"today 11= %@",date);
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDate *lastDay = [NSDate dateWithTimeInterval:num*24*60*60 sinceDate:date];//前num天
    NSLog(@"lastDay = %@",lastDay);
    return [self dateToString1:lastDay];
}
+(NSArray *)getWeekArr;
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i =0;i<7;i++)
    {
        NSString*week =[self qianjiTianWeek:i];
        NSLog(@"week = %@",week);
        [arr addObject:week];
    }
    return arr;
}
+(NSArray *)getDateArr;
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i =0;i<7;i++)
    {
        NSString*dateS =[self qianJiTianDate:i];
        NSLog(@"dateS = %@",dateS);
        [arr addObject:dateS];
    }
    return arr;
}


+(void)openGaodeMapAppTo:(NSString*)lat  lng:(NSString*) lng withSpotName:(NSString *) spotName result:(void(^)(BOOL success)) result{
//
//    id<UIApplicationDelegate>  appDelegate =  [UIApplication sharedApplication].delegate;
//    CLLocationCoordinate2D myLocation = appDelegate.location.location.coordinate;
//    CLLocationCoordinate2D storeLoacation = CLLocationCoordinate2DMake([NSNumber numberWithString:lat].floatValue,[NSNumber numberWithString:lng].floatValue);
//
//
//    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%.6f&slon=%.6f&sname=%@&did=BGVIS2&dlat=%.6f&dlon=%.6f&dname=%@&dev=0&m=0&t=0",@"", myLocation.latitude, myLocation.longitude,@"我的位置", storeLoacation.latitude, storeLoacation.longitude, spotName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    BOOL rev =   [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
//    if (result) {
//        result(rev);
//    }
}
+(void)openBaiduMapAppTo:(NSString*)lat  lng:(NSString*) lng withSpotName:(NSString *) spotName result:(void(^)(BOOL success)) result{
    
//    AppDelegate * appDelegate = ( AppDelegate *) [UIApplication sharedApplication].delegate;
//    CLLocationCoordinate2D myLocation = appDelegate.location.location.coordinate;
//    CLLocationCoordinate2D storeLoacation = CLLocationCoordinate2DMake([NSNumber numberWithString:lat].floatValue,[NSNumber numberWithString:lng].floatValue);
//
//    //将 gcj 转换为百度的bd09,然后才能调用导航
//    storeLoacation = [JZLocationConverter gcj02ToBd09:storeLoacation];
//
//    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%.6f,%.6f|name:%@&destination=latlng:%.6f,%.6f|name:%@&mode=driving", myLocation.latitude, myLocation.longitude, @"我的位置", storeLoacation.latitude, storeLoacation.longitude, spotName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
//
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
//        if (result) {
//            result(success);
//        }
//    }];
//
    
}
+(void)openAppNav:(NSString *)lat
              lng:(NSString *)lng
     withSpotName:(NSString *)spotName
           hodler:(UIViewController *)viewController
           result:(void (^)(BOOL))result{
//    UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"App导航" message:@"" preferredStyle:is_iPad ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
//        UIAlertAction * baiduApp = [UIAlertAction actionWithTitle:@"百度导航" style:0 handler:^(UIAlertAction * _Nonnull action) {
//            [self openBaiduMapAppTo:lat
//                                     lng:lng
//                            withSpotName:spotName
//                                  result:^(BOOL success) {
//                if (!success) {
//                    [viewController showDefaultInfo:@"打开百度导航失败，请检查是否安装了App"];
//                }
//            }];
//        }];
//        UIAlertAction * gaodeApp = [UIAlertAction actionWithTitle:@"高德导航" style:0 handler:^(UIAlertAction * _Nonnull action) {
//            [self openGaodeMapAppTo:lat
//                                             lng:lng
//                            withSpotName:spotName
//                                  result:^(BOOL success) {
//                if (!success) {
//                    [viewController showDefaultInfo:@"打开高德导航失败，请检查是否安装了App"];
//                }
//            }];
//        }];
//       [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消"
//                                                       style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//       }]];
//      if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
//        {
//            [actionSheet addAction:baiduApp];
//        }
//        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
//        {
//            [actionSheet addAction:gaodeApp];
//        }
//
//       [viewController presentViewController:actionSheet
//                          animated:YES
//                        completion:^{
//
//       }];
}
+(NSInteger)timeToToday:(NSDate*)dateEnd
{
    if(dateEnd == nil)
    {
        return 0;
    }
    NSDate *date =[NSDate date];//当前时间
    //根据当地时间把时间戳转为当地时间
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    NSLog(@"%@",localeDate);
    return  [dateEnd timeIntervalSinceReferenceDate] - [date timeIntervalSinceReferenceDate];
}
+(NSDate *)dateByShiJianChuo:(NSString*)str
{
    double time =[str doubleValue];

     NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    return myDate;
}
+(NSString *)dateSByShiJianChuo:(NSString*)str
{
   double time =[str doubleValue]/1000.0;

   NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

   //设置时间格式

   NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

   [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

   //将时间转换为字符串

   NSString *timeStr=[formatter stringFromDate:myDate];

   return [timeStr substringToIndex:10];
}
//转换成天时分秒

+ (NSString *)timeFormatted:(NSInteger)totalSeconds

{
    if(totalSeconds<=0)
    {
        return @"已结束~";
    }
    
    int seconds = totalSeconds % 60;
    
    int minutes = (totalSeconds / 60) % 60;
    
    int hours = (totalSeconds / 3600) % 24;
    
    int tian =totalSeconds / (3600 *24);
    
    
    return [NSString stringWithFormat:@"%d天 %02d 时 %02d 分 %02d 秒",tian,hours, minutes, seconds];
    
}

@end
