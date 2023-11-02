//
//  TISChooseListView.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISBaseView.h"
#import "TISHorButtonScroll.h"
#import "TISResetChoose.h"
#import "TISSearch.h"
#import "TISChooseListRequestView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TISChooseListView : TISBaseView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTableView; // 数据列表视图
/**
 *  数据列表  每个字典对象必须包含id,name,select这三个字段 例如@[@{@"id": @"1", @"name": @"北京大学", @"select": @"0"}]
 */
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据列表
@property (nonatomic, assign) BOOL isMore; // 是否是多选（默认为单选）
@property (nonatomic, copy) void (^selectedData)(NSArray *array); // 选择完成回调事件
@property (nonatomic, copy) void (^goSearch)(NSString *string); // 搜索数据
@property (nonatomic, strong) UIView *headerView; // 多选头部视图
@property (nonatomic, strong) TISResetChoose *footerView; // 多选尾部视图
@property (nonatomic, strong) TISHorButtonScroll *horScroll; // 已选结果滚动视图
@property (nonatomic, strong) TISSearch *tisSearch; // 搜索组件
@property (nonatomic, strong) UIView *lineView; // 已选区底部线条
@property (nonatomic, strong) TISChooseListRequestView *requestView; // 请求视图

@end

NS_ASSUME_NONNULL_END
