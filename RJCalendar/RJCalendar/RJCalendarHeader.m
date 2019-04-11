//
//  RJCalendarHeader.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJCalendarHeader.h"
@interface RJCalendarHeader()
@property (nonatomic,strong) UIButton *screening;
@end
@implementation RJCalendarHeader
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 布局
- (void)setUI{
    [self addSubview:self.screening];
    
    self.backgroundColor = [UIColor clearColor];
    NSArray *array = [[NSArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",@"七", nil];
    for (int i = 0; i < array.count; i++) {
        UILabel *lab = [UILabel new];
        lab.font = [UIFont systemFontOfSize:ZYFloatW(12)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor grayColor];
        lab.text = array[i];
        
        [self addSubview:lab];
        
        if (i == 0) {
            [self.screening mas_makeConstraints:^(MASConstraintMaker *make) {
                //间距 自己微调
                CGFloat spacing = (ScreenWidth - 7 * ZYFloatW(34) ) / 8;
                make.left.mas_equalTo(self).offset(spacing - ZYFloatW(-7));
                make.top.mas_equalTo(ZYFloatW(26));
            }];
        }
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ZYFloatW(75));
            make.width.mas_equalTo(ZYFloatW(34));
            //间距 + (间距 + cell宽 * i)
            CGFloat spacing = (ScreenWidth - 7 * ZYFloatW(34) ) / 8;
            make.left.mas_equalTo(self.mas_left).offset(spacing+ (spacing + ZYFloatW(34)) * i);
            make.height.mas_equalTo(ZYFloatW(20));
        }];
    }
    
}

#pragma mark - 方法
- (void)addData:(NSString *)strs{
    self.screening.titleLabel.text = [NSString stringWithFormat:@"%@ 区头",strs];
    [self.screening setTitle:[NSString stringWithFormat:@"%@ 区头",strs] forState:UIControlStateNormal];
}

#pragma mark -懒加载
- (UIButton *)screening{
    if (!_screening) {
        _screening = [UIButton buttonWithType:UIButtonTypeSystem];
        _screening.tintColor = [UIColor grayColor];
        _screening.titleLabel.textColor = [UIColor grayColor];
        _screening.titleLabel.font = [UIFont systemFontOfSize:ZYFloatW(16)];
        [_screening setTitle:@"--" forState:UIControlStateNormal];
    }
    return _screening;
}
@end
