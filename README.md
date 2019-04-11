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
    
![](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554961514722&di=478241aaf519014b4127b31e42164b18&imgtype=0&src=http%3A%2F%2Fhiphotos.baidu.com%2Fdoc%2Fpic%2Fitem%2F9825bc315c6034a86deaed63c2134954082376c3.jpg) 
