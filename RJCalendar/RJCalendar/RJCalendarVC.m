//
//  RJCalendarVC.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/26.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJCalendarVC.h"
#import "RJCalendarCell.h"
#import "RJCalendarHeader.h"
#import "RJCalendarFooter.h"
#import "RJCalendarData.h"
#import "RJCalendarModel.h"
#import "RJLayout.h"

#define CellID @"cellID"
#define HeaderID @"headerID"
#define FooterID @"footerID"

@interface RJCalendarVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) RJLayout *layout;
@property (nonatomic,strong) UIView *selectItem;
@property (nonatomic,assign) BOOL isReloadData;
@end

@implementation RJCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - 布局
- (void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.collection];
    
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self updateData];
}



//更新
- (void)updateData{
    
    [self.dataArray removeAllObjects];
    if ([self.calendarDate isKindOfClass:[NSString class]]) {
        self.dateStr = (NSString *)self.calendarDate;
        if (self.dateStr.length > 7) {
            self.dateStr = [self.dateStr substringToIndex:7];
        }
    }else if ([self.calendarDate isKindOfClass:[NSDate class]]){
        self.dateStr = [RJCalendarData convertDateToString:(NSDate *)self.calendarDate];
    }else {
        return;
    }
    
    //当前月是周几    0 - 6 周日 周一至周六
    NSDate *currentDate = [RJCalendarData convertStringToDate:self.dateStr];
    NSInteger currentMonthWeeks = [RJCalendarData convertDateToWeekDay:currentDate];
    //大于周日时铺垫上月的数据
    if (currentMonthWeeks > 0) {
        //上个月date
        NSDate *lastMonthDate = [RJCalendarData getDateFrom:currentDate offsetMonths:-1];
        //上个月总天数
        NSInteger lastMonthDayNumber = [RJCalendarData convertDateToTotalDays:lastMonthDate];
        //上个月需要显示天的起始点 上个月总天数 - 当前月的起始周 + 1
        NSInteger lastMonthDaysStart = lastMonthDayNumber - currentMonthWeeks + 1;
        
        //上个月-年
        NSInteger lastMonthYears = [RJCalendarData convertDateToYear:lastMonthDate];
        //上个月
        NSInteger lastMonthNumber = [RJCalendarData convertDateToMonth:lastMonthDate];
        for (int j = (int)lastMonthDaysStart; j <= lastMonthDayNumber; j++) {
            RJCalendarModel *model = [RJCalendarModel new];
            //如果使用了YYModel可使用映射来优化
            model.otherMonthTextColor = self.colorModel.otherMonthTextColor;
            model.currentMonthTextColor = self.colorModel.currentMonthTextColor;
            model.defaultDayBgColor = self.colorModel.defaultDayBgColor;
            model.currentDayBgColor = self.colorModel.currentDayBgColor;
            model.selectDayBgColor = self.colorModel.selectDayBgColor;
            model.years = [NSString stringWithFormat:@"%li",(long)lastMonthYears];
            model.month = [NSString stringWithFormat:@"%li",(long)lastMonthNumber];
            model.day = [NSString stringWithFormat:@"%i",j];
            model.monthDayNumber = [NSString stringWithFormat:@"%li",(long)lastMonthDayNumber];
            model.isSelect = @"0";
            model.isCurrentDay = @"0";
            model.isLastMonth = @"1";
            model.isNextMonth = @"0";
            [self.dataArray addObject:model];
        }
    }
    //铺垫当前月数据
    //当前月份总天数
    NSInteger currentDayNumber = [RJCalendarData convertDateToTotalDays:currentDate];
    //当前月份-年
    NSInteger currentYears = [RJCalendarData convertDateToYear:currentDate];
    //当前月份
    NSInteger currentMonth = [RJCalendarData convertDateToMonth:currentDate];
    for (int i = 0; i< currentDayNumber; i++) {
        RJCalendarModel *model = [RJCalendarModel new];
        model.otherMonthTextColor = self.colorModel.otherMonthTextColor;
        model.currentMonthTextColor = self.colorModel.currentMonthTextColor;
        model.defaultDayBgColor = self.colorModel.defaultDayBgColor;
        model.currentDayBgColor = self.colorModel.currentDayBgColor;
        model.selectDayBgColor = self.colorModel.selectDayBgColor;
        model.years = [NSString stringWithFormat:@"%li",(long)currentYears];
        model.month = [NSString stringWithFormat:@"%li",(long)currentMonth];
        model.day = [NSString stringWithFormat:@"%i",i + 1];
        model.monthDayNumber = [NSString stringWithFormat:@"%li",(long)currentDayNumber];
        model.isSelect = @"0";
        NSString *dayStr = [NSString stringWithFormat:@"%@-%.2i",self.dateStr,i + 1];
        model.isCurrentDay = [NSString stringWithFormat:@"%d",[RJCalendarData isCurrentDay:dayStr]];
        model.isLastMonth = @"0";
        model.isNextMonth = @"0";
        [self.dataArray addObject:model];
    }
    //铺垫下月数据
    //下个月总天数
    NSInteger nextDayNumber = [RJCalendarData convertDateToTotalDays:currentDate];
    //下月-年
    NSInteger nextYears = [RJCalendarData convertDateToYear:currentDate];
    //下个月
    NSInteger nextMonth = [RJCalendarData convertDateToMonth:currentDate];
    //下月总天数
    NSInteger nextMonthNumber = (7 - self.dataArray.count % 7) % 7;
    for (int k = 1; k <= nextMonthNumber; k++) {
        RJCalendarModel *model = [RJCalendarModel new];
        model.otherMonthTextColor = self.colorModel.otherMonthTextColor;
        model.currentMonthTextColor = self.colorModel.currentMonthTextColor;
        model.defaultDayBgColor = self.colorModel.defaultDayBgColor;
        model.currentDayBgColor = self.colorModel.currentDayBgColor;
        model.selectDayBgColor = self.colorModel.selectDayBgColor;
        model.years = [NSString stringWithFormat:@"%li",(long)nextYears];
        model.month = [NSString stringWithFormat:@"%li",(long)nextMonth];
        model.day = [NSString stringWithFormat:@"%i",k];
        model.monthDayNumber = [NSString stringWithFormat:@"%li",(long)nextDayNumber];
        model.isSelect = @"0";
        model.isCurrentDay = @"0";
        model.isLastMonth = @"0";
        model.isNextMonth = @"1";
        [self.dataArray addObject:model];
    }
    [self.collection reloadData];
}


#pragma mark collectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RJCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    [cell addData:self.dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ZYFloatW(34), ZYFloatW(34));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(ScreenWidth, ZYFloatW(108));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(ScreenWidth, ZYFloatW(100));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RJCalendarHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        [header addData:self.dateStr];
        return header;
    }else {
        RJCalendarFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID forIndexPath:indexPath];
        return footer;
    }
}

//collectionViewCell将要显示时 放大缩小
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isReloadData) {
        RJCalendarModel *model = self.dataArray[indexPath.row];
        if ([model.isSelect boolValue]) {
            cell.transform = CGAffineTransformMakeScale(0, 0);//CGAffineTransformMake(1.4, 0, 0, 1.4, 10, 10);
            [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.transform = CGAffineTransformMakeScale(1, 1);;
            } completion:nil];
        }
    }

}


//点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isMoreSelect) {
        RJCalendarModel *model = self.dataArray[indexPath.row];
        BOOL isPass = NO;
        if (![model.isSelect boolValue]) {//item之前也选中时不处理
            isPass = YES;
        }
        model.isSelect = [NSString stringWithFormat:@"%d",![model.isSelect boolValue]];
        self.layout.dataArray = self.dataArray;
        self.isReloadData = NO;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:)] && isPass) {
            [self.delegate didSelectItem:model];
        }
    } else {
        RJCalendarModel *model = self.dataArray[indexPath.row];
        BOOL isPreviousSelect = NO;//是否存在上一个选中的item
        NSIndexPath *previousSelectIndex;
        if (![model.isSelect boolValue]) {//不能取消
            if ([model.isLastMonth boolValue] || [model.isNextMonth boolValue]) {
                return;
            }
            for (int i = 0;i < self.dataArray.count;i++) {
                RJCalendarModel *calendarModel = self.dataArray[i];
                //取消上一个选中的item
                if (calendarModel != model && [calendarModel.isSelect boolValue]) {
                    calendarModel.isSelect = [NSString stringWithFormat:@"%d",![calendarModel.isSelect boolValue]];
                    isPreviousSelect = YES;
                    previousSelectIndex = [NSIndexPath indexPathForRow:i inSection:0];
                    break;
                }
            }
            model.isSelect = [NSString stringWithFormat:@"%d",![model.isSelect boolValue]];
            self.layout.dataArray = self.dataArray;
            self.isReloadData = NO;
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            if (isPreviousSelect) {
                [collectionView reloadItemsAtIndexPaths:@[previousSelectIndex]];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:)]) {
                [self.delegate didSelectItem:model];
            }
        }
    }
}

#pragma mark - 懒加载
- (UICollectionView *)collection{
    if (!_collection) {
        //UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        RJLayout *layout = [[RJLayout alloc] init];
        layout.dataArray = self.dataArray;
        //每行之间竖直之间的最小间距
        layout.minimumLineSpacing = 0;
        //同行的cell与cell之间水平之间的最小间距
        //假设cell高宽为34 计算间距 = （总宽 - 7个cell总宽）/ 8个间隔
        CGFloat spacing = (ScreenWidth - 7 * ZYFloatW(34) ) / 8;
        layout.minimumInteritemSpacing = spacing;
        //竖直滚动
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置item内边距
        layout.sectionInset = UIEdgeInsetsMake(0, spacing, 0, spacing);
        self.layout = layout;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        //去除滚动条
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.scrollEnabled = YES;
        //允许反弹
        _collection.bounces = YES;
        //注册cell和区头区尾
        [_collection registerClass:[RJCalendarCell class] forCellWithReuseIdentifier:CellID];
        [_collection registerClass:[RJCalendarHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
        [_collection registerClass:[RJCalendarFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
        _collection.backgroundColor = [UIColor clearColor];
    }
    return _collection;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.backgroundColor = [UIColor whiteColor];
    }
    return _bgImageView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
}

- (UIView *)selectItem{
    if (!_selectItem) {
        _selectItem = [UIView new];
    }
    return _selectItem;
}

- (RJCalendarModel *)colorModel {
    if (!_colorModel) {
        _colorModel = [RJCalendarModel new];
    }
    return _colorModel;
}
@end
