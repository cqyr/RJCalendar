# RJCalendar
###### 日期控件
    RJSlidingVC *vc = [RJSlidingVC new];
    vc.calendarDateStr = @"2019-4";//只传年月
    vc.isMoreSelect = NO;//是否多选
    vc.isBanSlidingAround = NO;//禁止左右滑动
    vc.colorModel.otherMonthTextColor = [UIColor redColor];//上下月月份颜色
    vc.colorModel.currentMonthTextColor = [UIColor blackColor];//当前月份颜色
    vc.colorModel.defaultDayBgColor = [UIColor whiteColor];//默认背景颜色
    vc.colorModel.currentDayBgColor = [UIColor grayColor];//当天背景颜色
    vc.colorModel.selectDayBgColor = [UIColor orangeColor];//选中的背景颜色
    //如果需要改变区头区尾巴布局 在RJCalendarHeader 和 RJCalendarFooter类中修改即可
    
![](https://github.com/cqyr/RJCalendar/raw/master/calendarDemo.gif) 
