//
//  RJLayout.h
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/27.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJLayout : UICollectionViewFlowLayout
@property (nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,copy) NSString *isDrag;//是否在拖动
@end
