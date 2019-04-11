//
//  RJCalendarModel.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJCalendarModel.h"

@implementation RJCalendarModel
- (UIColor *)otherMonthTextColor {
    if (!_otherMonthTextColor) {
        _otherMonthTextColor = [UIColor redColor];
    }
    return _otherMonthTextColor;
}
- (UIColor *)currentMonthTextColor {
    if (!_currentMonthTextColor) {
        _currentMonthTextColor = [UIColor blackColor];
    }
    return _currentMonthTextColor;
}
- (UIColor *)defaultDayBgColor {
    if (!_defaultDayBgColor) {
        _defaultDayBgColor = [UIColor whiteColor];
    }
    return _defaultDayBgColor;
}
- (UIColor *)currentDayBgColor {
    if (!_currentDayBgColor) {
        _currentDayBgColor = [UIColor grayColor];
    }
    return _currentDayBgColor;
}
- (UIColor *)selectDayBgColor {
    if (!_selectDayBgColor) {
        _selectDayBgColor = [UIColor orangeColor];
    }
    return _selectDayBgColor;
}
@end
