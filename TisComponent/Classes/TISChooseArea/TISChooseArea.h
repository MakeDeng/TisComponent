//
//  TISChooseArea.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISBaseView.h"
#import "TISHorButtonScroll.h"
#import "TISResetChoose.h"

NS_ASSUME_NONNULL_BEGIN

@interface TISChooseArea : TISBaseView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL isMore; // 是否是多选（默认为单选）
@property (nonatomic, strong) TISResetChoose *footerView; // 多选尾部视图
@property (nonatomic, strong) TISHorButtonScroll *horScroll; // 头部已选结果滚动视图
@property (nonatomic, strong) UIView *tableBgView; // 表格背景视图
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据列表(省市区，最外层是省)
@property (nonatomic, strong) NSArray *cityList; // 市级数据列表(只有市级)
@property (nonatomic, strong) NSArray *areaList; // 区级数据列表(只有区级)
@property (nonatomic, assign) NSInteger selectProvince; // 当前选中的省
@property (nonatomic, assign) NSInteger selectCity; // 当前选中的市
@property (nonatomic, assign) NSInteger selectArea; // 当前选中的区
@property (nonatomic, strong) NSMutableArray *selectArray; // 已选地区（头部滚动视图展示数据）
@property (nonatomic, copy) void (^sureClicked)(NSArray *array); // 选择完成回调事件

@end

NS_ASSUME_NONNULL_END
