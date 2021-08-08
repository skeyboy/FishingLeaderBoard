//
//  ToolClass.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YuWeChatShareManager.h"
//#import "AlipaySDK+pay.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToolClass : NSObject
//得到当前时间

+ (NSString *)getCurrentTime;
//计算字体长度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
// 根据颜色生成UIImage
+ (UIImage*)imageWithColor:(UIColor*)color;
//得到
+(NSString *)qianjiTianWeek:(int)num;
//得到日期
+(NSString *)qianJiTianDate:(int)num;
//获取未来7天的星期数组
+(NSArray *)getWeekArr;
//获取未来7d天的日期数组
+(NSArray *)getDateArr;
///yyyy-mm-ss hh:mm:ss
+(NSString *)dateToString:(NSDate *)date;
/// yyyy年MM月dd日 HH:mm:ss
+(NSString *)dateToString2:(NSDate *)date;
/// MM/dd
+(NSString *)dateToString3:(NSDate *)date;

//时间戳转化成时间
+(NSString *)dateSByShiJianChuo:(NSString*)str;
+(NSDate *)dateByShiJianChuo:(NSString*)str;

///yyyy-mm-ss
+(NSString *)dateToString1:(NSDate *)date;
+(NSString *)dateToString4:(NSDate *)date;

+ (NSDate *)dateFromString2:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString5:(NSString *)dateString ;
//获取截止时间到今天的时间差
+(NSInteger)timeToToday:(NSDate*)dateEnd;
//转换成天时分秒
+ (NSString *)timeFormatted:(NSInteger)totalSeconds;

+(void)openBaiduMapApp;


+(void)openBaiduMapAppTo:(NSString*)lat
                     lng:(NSString*) lng
            withSpotName:(NSString *) spotName
                  result:(void(^)(BOOL success)) result;
+(void)openGaodeMapAppTo:(NSString*)lat
                     lng:(NSString*) lng
            withSpotName:(NSString *) spotName
                  result:(void(^)(BOOL success)) result;
+(void)openAppNav:(NSString *) lat
              lng:(NSString *) lng
     withSpotName:(NSString *) spotName
      hodler:(UIViewController *)viewController
           result:(void(^)(BOOL success)) result;

@end

NS_ASSUME_NONNULL_END
