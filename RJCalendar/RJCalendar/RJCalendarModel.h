//
//  RJCalendarModel.h
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJCalendarModel : NSObject
@property(nonatomic,copy) NSString *years;//年
@property(nonatomic,copy) NSString *month;//月
@property(nonatomic,copy) NSString *day;//天
@property(nonatomic,copy) NSString *monthDayNumber;//当月总天数
@property(nonatomic,copy) NSString *isCurrentDay;//是否是当前天 只有本月才会
@property(nonatomic,copy) NSString *isSelect;//是否选中
@property(nonatomic,copy) NSString *isLastMonth;//是否为上月数据
@property(nonatomic,copy) NSString *isNextMonth;//是否为下月数据
@property(nonatomic) UIColor *otherMonthTextColor;//其他月份text颜色 其他月份为上月下月数据
@property(nonatomic) UIColor *currentMonthTextColor;//当前月份text颜色
@property(nonatomic) UIColor *defaultDayBgColor;//默认背景颜色
@property(nonatomic) UIColor *currentDayBgColor;//当天背景颜色
@property(nonatomic) UIColor *selectDayBgColor;//所选中日期的背景颜色
@end
