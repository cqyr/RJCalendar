//
//  RJTbvDragVC.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/28.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJTbvDragVC.h"

@interface RJTbvDragVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbv;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation RJTbvDragVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tbv];
    [self.tbv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZYFloatW(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark 选择编辑模式，添加模式很少用,默认是删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark 排序 当移动了某一行时候会调用
//编辑状态下，只要实现这个方法，就能实现拖动排序
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 取出要拖动的模型数据
    NSString *str = self.dataArray[sourceIndexPath.row];
    //删除之前行的数据
    [self.dataArray removeObject:str];
    // 插入数据到新的位置
    [self.dataArray insertObject:str atIndex:destinationIndexPath.row];
}


#pragma mark - 懒加载
- (UITableView *)tbv{
    if(!_tbv){
        _tbv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbv.delegate = self;
        _tbv.dataSource = self;
        _tbv.backgroundColor = [UIColor whiteColor];
        _tbv.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbv.showsVerticalScrollIndicator = NO;
        //设置成编辑模式
        [_tbv setEditing:YES];
    }
    return _tbv;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22", nil];
    }
    return _dataArray;
}

@end
