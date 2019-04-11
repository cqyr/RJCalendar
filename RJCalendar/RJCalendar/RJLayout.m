//
//  RJLayout.m
//  RJCalendar
//
//  Created by 陈钦扬 on 2018/6/27.
//  Copyright © 2018年 liushuangwangluokeji. All rights reserved.
//

#import "RJLayout.h"
#import "RJCalendarModel.h"

@interface RJLayout()
@property (nonatomic,copy) NSArray *attributesArray;
@end

@implementation RJLayout
//该方法和init方法相似，但该方法可能会被调用多次
- (void)prepareLayout{
    [super prepareLayout];
}

//我们在外部调用CollectionView相关的api去插入、删除、刷新、移动cell时首先调用该方法获取更新以后的布局信息
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* attributesToReturn = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    //NSArray *attributesToReturn = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    self.attributesArray = attributesToReturn;
    for (UICollectionViewLayoutAttributes *attr in self.attributesArray) {
        
    }
    return attributesToReturn;
}

//然后通过prepareForCollectionViewUpdates方法来通知layout哪些内容将会发生改变
- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
    [super prepareForCollectionViewUpdates:updateItems];
}
//之后，通过调用layout中的initialLayoutAttributesForAppearingItemAtIndexPath、finalLayoutAttributesForDisappearingItemAtIndexPath方法获取对应indexPath的cell的属性 每个item都会调用一次

//initialLayoutAttributesForAppearingItemAtIndexPath:当前设置的 -渐变动画> cell默认值 finalLayoutAttributesForDisappearingItemAtIndexPath:cell默认值 -渐变动画> 当前设置的 这两个方法是执行两个不相关的动画 都是与cell原先初始值进行动画

//返回插入到集合视图中的项目的开始布局信息。 cell动的动画 与cell默认值形成一个动画 比如cell透明度alpha默认为1，在下列方法中把alpha改成0的话与原先alpha为1时形成一个动画 0 -> 渐变成原先的1,跟finalLayoutAttributesForDisappearingItemAtIndexPath方法无关
- (nullable UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    //UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    UICollectionViewLayoutAttributes *attr = self.attributesArray[itemIndexPath.row];//[super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([((RJCalendarModel *)self.dataArray[itemIndexPath.row]).isSelect boolValue]) {
        attr.alpha = 0.0f;
        attr.transform = CGAffineTransformMakeScale(0.0, 0.0);
    }else{
//        attr.alpha = 1.0f;
//        attr.transform = CGAffineTransformMakeScale(1, 1);
        attr.alpha = 0.0f;
        attr.transform = CGAffineTransformMakeScale(3, 3);
    }
    
    return attr;
}


// 返回即将从集合视图中移除的项目的最终布局信息。 cell本身不动动画 cell真正的本身执行的一个动画 假设cell原先的alpha为1 并且是不旋转的 现在alpha设成0 并且旋转，1 -> 渐变成0 这时cell不动的本身会执行一个动画 与initialLayoutAttributesForAppearingItemAtIndexPath无关
- (nullable UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr =  self.attributesArray[itemIndexPath.row];//[self layoutAttributesForItemAtIndexPath:itemIndexPath];
    //UICollectionViewLayoutAttributes *attr = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    if ([((RJCalendarModel *)self.dataArray[itemIndexPath.row]).isSelect boolValue]) {
        attr.alpha = 1.0f;
        attr.transform = CGAffineTransformMakeScale(1, 1);
    }else{
//        attr.alpha = 0.0f;
//        attr.transform = CGAffineTransformMakeScale(3, 3);
        attr.alpha = 1.0f;
        attr.transform = CGAffineTransformMakeScale(1, 1);
    }

    return attr;
}
//最后调用finalizeCollectionViewUpdates收尾，这里一般用来重置收集的数据。
- (void)finalizeCollectionViewUpdates{
    [super finalizeCollectionViewUpdates];
}

@end
