//
//  RJSlidingVC.h
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/27.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJCalendarModel;
@protocol RJSlidingVCDelegate <NSObject>
- (void)didSelectItem:(RJCalendarModel *)model;//选中对应item
@end
@interface RJSlidingVC : UIViewController
@property (nonatomic,weak) id<RJSlidingVCDelegate> delegate;
@property (nonatomic,strong) NSString *calendarDateStr;//本月日期字符串
@property (nonatomic,assign) BOOL isMoreSelect;//是否多选 yes多选 默认no单选
@property (nonatomic,assign) BOOL isBanSlidingAround;//是否禁止左右滑动 yes禁止 no允许
@property (nonatomic,strong) RJCalendarModel *colorModel;//颜色model
@end
