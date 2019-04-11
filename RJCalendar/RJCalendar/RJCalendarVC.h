//
//  RJCalendarVC.h
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJCalendarModel;
@protocol RJCalendarVCDelegate <NSObject>
- (void)didSelectItem:(RJCalendarModel *)model;//选中对应item
@end
@interface RJCalendarVC : UIViewController
@property (nonatomic,strong) id calendarDate;//日期
@property (nonatomic,assign) BOOL isMoreSelect;//是否多选 yes多选 默认no单选
@property (nonatomic,strong) RJCalendarModel *colorModel;//颜色model
@property (nonatomic,weak) id<RJCalendarVCDelegate> delegate;
- (void)updateData;//更新方法
@end
