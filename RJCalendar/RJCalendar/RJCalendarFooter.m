//
//  RJCalendarFooter.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJCalendarFooter.h"
@interface RJCalendarFooter()
@property(nonatomic,strong) UILabel *lab;
@end

@implementation RJCalendarFooter
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 布局
- (void)setUI{
    [self addSubview:self.lab];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
    }];
}

#pragma mark - 懒加载
- (UILabel *)lab{
    if (!_lab) {
        _lab = [UILabel new];
        _lab.textAlignment = NSTextAlignmentLeft;
        _lab.font = [UIFont systemFontOfSize:16];
        _lab.textColor = [UIColor grayColor];
        _lab.text = @"区尾";
    }
    return _lab;
}
@end
