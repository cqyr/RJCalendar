//
//  RJCalendarCell.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJCalendarCell.h"
#import "RJCalendarModel.h"
@interface RJCalendarCell()
@property (nonatomic,strong) UILabel *day;
@end

@implementation RJCalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 布局
- (void)setUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.day];
    
    [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - 添加数据
- (void)addData:(RJCalendarModel *)model{
    _day.textColor = [model.isLastMonth boolValue] == YES || [model.isNextMonth boolValue] == YES ? model.otherMonthTextColor : model.currentMonthTextColor;
    _day.backgroundColor = [model.isCurrentDay boolValue] == YES ? model.currentDayBgColor : model.defaultDayBgColor;
    _day.backgroundColor = [model.isSelect boolValue] == YES ? model.selectDayBgColor : [model.isCurrentDay boolValue] == YES ? model.currentDayBgColor : model.defaultDayBgColor;
    _day.text = model.day;
}

#pragma mark - 懒加载

- (UILabel *)day{
    if (!_day) {
        _day = [UILabel new];
        _day.textAlignment = NSTextAlignmentCenter;
        _day.textColor = [UIColor blackColor];
        _day.font = [UIFont systemFontOfSize:ZYFloatW(12)];
        _day.backgroundColor = [UIColor grayColor];
        _day.layer.cornerRadius = ZYFloatW(34/2);
        _day.layer.masksToBounds = YES;
        _day.text = @"1";

    }
    return _day;
}
@end
