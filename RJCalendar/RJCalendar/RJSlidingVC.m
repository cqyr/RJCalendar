//
//  RJSlidingVC.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/27.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJSlidingVC.h"
#import "RJCalendarVC.h"
#import "RJCalendarData.h"
#import "RJCalendarModel.h"
typedef NS_ENUM(NSInteger,MonthType) {
    MonthTypeLastMonth = 1, //上个月
    MonthTypeCurrentMonth, //本月
    MonthTypeNextMonth //下个月
};
@interface RJSlidingVC ()<UIScrollViewDelegate,RJCalendarVCDelegate>
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) RJCalendarVC *lastMonth;//上个月日历控件
@property (nonatomic,strong) RJCalendarVC *currentMonth;//本月日历控件
@property (nonatomic,strong) RJCalendarVC *nextMonth;//下个月日历控件

@end

@implementation RJSlidingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    if (self.calendarDateStr.length <= 0) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        self.calendarDateStr = strDate;
    }
    [self updateMonth:MonthTypeCurrentMonth isCurrentMonthUpdate:YES];
}

#pragma mark - 布局
- (void)setUI{
    [self.view addSubview:self.scroll];
    
    [self addChildViewController:self.lastMonth];
    [self.scroll addSubview:self.lastMonth.view];
    [self addChildViewController:self.currentMonth];
    [self.scroll addSubview:self.currentMonth.view];
    [self addChildViewController:self.nextMonth];
    [self.scroll addSubview:self.nextMonth.view];
    
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view);
    }];
    [self.lastMonth.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(self.scroll);
        make.width.mas_equalTo(ScreenWidth);
        make.left.mas_equalTo(self.scroll);
    }];
    [self.currentMonth.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(self.scroll);
        make.width.mas_equalTo(ScreenWidth);
        make.left.mas_equalTo(self.scroll).offset(ScreenWidth);
    }];
    [self.nextMonth.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(self.scroll);
        make.width.mas_equalTo(ScreenWidth);
        make.left.mas_equalTo(self.scroll).offset(ScreenWidth * 2);
    }];
}

#pragma mark - 方法
//修改月份
- (void)updateMonth:(MonthType)monthStatus isCurrentMonthUpdate:(BOOL)currentMonthUpdate{
    NSDate *calendarDate = [RJCalendarData convertStringToDate:self.calendarDateStr];
    //移动到中间位置
    [_scroll setContentOffset:CGPointMake(ScreenWidth, 0)];
    //判断移动到哪个月份
    switch (monthStatus) {
        case MonthTypeLastMonth:
            calendarDate = [RJCalendarData getDateFrom:calendarDate offsetMonths:-1];
            break;
        case MonthTypeCurrentMonth:
            if (currentMonthUpdate) {
                break;
            }else{
                return;
            }
        case MonthTypeNextMonth:
            calendarDate = [RJCalendarData getDateFrom:calendarDate offsetMonths:1];
            break;
        default:
            break;
    }
    //更新本月
    self.calendarDateStr = [RJCalendarData convertDateToString:calendarDate];
    self.lastMonth.calendarDate = [RJCalendarData getDateFrom:calendarDate offsetMonths:-1];
    [self.lastMonth updateData];
    self.currentMonth.calendarDate = calendarDate;
    [self.currentMonth updateData];
    self.nextMonth.calendarDate = [RJCalendarData getDateFrom:calendarDate offsetMonths:1];
    [self.nextMonth updateData];
    
}

#pragma mark scrollViewdelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width) / scrollView.frame.size.width;
    [self updateMonth:page isCurrentMonthUpdate:NO];
}

#pragma mark - RJCalendarVCDelegate
- (void)didSelectItem:(RJCalendarModel *)model {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.delegate didSelectItem:model];
    }
}

#pragma mark - 懒加载
- (UIScrollView *)scroll{
    if (!_scroll) {
        _scroll = [UIScrollView new];
        //隐藏滚动条
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.backgroundColor = [UIColor whiteColor];
        //弹簧效果
        _scroll.bounces = YES;
        //允许滑动
        _scroll.scrollEnabled = !self.isBanSlidingAround;
        //设置分页
        _scroll.pagingEnabled = YES;
        [_scroll setContentSize:CGSizeMake(ScreenWidth * 3, ScreenHeight)];
        _scroll.delegate = self;
    }
    return _scroll;
}

- (RJCalendarVC *)lastMonth{
    if (!_lastMonth) {
        _lastMonth = [RJCalendarVC new];
        _lastMonth.isMoreSelect = self.isMoreSelect;
        _lastMonth.colorModel = self.colorModel;
        _lastMonth.delegate = self;
    }
    return _lastMonth;
}

- (RJCalendarVC *)currentMonth{
    if (!_currentMonth) {
        _currentMonth = [RJCalendarVC new];
        _currentMonth.isMoreSelect = self.isMoreSelect;
        _currentMonth.colorModel = self.colorModel;
        _currentMonth.delegate = self;
    }
    return _currentMonth;
}

- (RJCalendarVC *)nextMonth{
    if (!_nextMonth) {
        _nextMonth = [RJCalendarVC new];
        _nextMonth.isMoreSelect = self.isMoreSelect;
        _nextMonth.colorModel = self.colorModel;
        _nextMonth.delegate = self;
    }
    return _nextMonth;
}

- (RJCalendarModel *)colorModel {
    if (!_colorModel) {
        _colorModel = [RJCalendarModel new];
    }
    return _colorModel;
}
@end
