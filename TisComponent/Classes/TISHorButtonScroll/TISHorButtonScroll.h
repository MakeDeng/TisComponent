//
//  TISHorButtonScroll.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISHorButtonScroll : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *noneLabel; // 未选择显示label
@property (nonatomic, strong) UICollectionView *buttonCollection; // 滚动视图
@property (nonatomic) CGRect viewFrame; // 视图的fram
/**
 *  数据列表  每个字典对象必须包含name这个字段 例如@[@{@"name": @"北京大学"}], 若有其他字段选中回调方法会原样返回其他字段
 */
@property (nonatomic, strong) NSArray *dataArray; // 数据列表
@property (nonatomic, strong) NSMutableArray *widthArray; // cell宽度列表
@property (nonatomic, copy) void (^closeData)(NSDictionary *dic); // 选择的数据

@end

NS_ASSUME_NONNULL_END
