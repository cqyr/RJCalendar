//
//  RJCalendarData.h
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJCalendarData : NSObject
//字符串转data yyyy-MM
+ (NSDate *)convertStringToDate:(NSString *)string;
+ (NSDate *)convertStringToDates:(NSString *)string;

//date转字符串
+ (NSString *)convertDateToString:(NSDate *)date;

//根据date获取当月总天数
+ (NSInteger)convertDateToTotalDays:(NSDate *)date;

//根据date获取当月周几 (美国时间周日-周六为 1-7,改为0-6方便计算)
+ (NSInteger)convertDateToWeekDay:(NSDate *)date;

//根据date获取日
+ (NSInteger)convertDateToDay:(NSDate *)date;

//根据date获取月
+ (NSInteger)convertDateToMonth:(NSDate *)date;

//根据date获取年
+ (NSInteger)convertDateToYear:(NSDate *)date;

//根据date获取偏移指定月数的date
+ (NSDate *)getDateFrom:(NSDate *)date offsetMonths:(NSInteger)offsetMonths;

//根据date获取偏移指定年数的date
+ (NSDate *)getDateFrom:(NSDate *)date offsetYears:(NSInteger)offsetYears;

//判断是否为当天 yyyy-MM-dd
+ (BOOL)isCurrentDay:(NSString *)dayStr;

//计算两个日期间隔多少天
+ (NSInteger)statusDate:(NSDate *)statusDate endDate:(NSDate *)endDate;
@end
