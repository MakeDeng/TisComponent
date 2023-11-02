//
//  TISChooseArea.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISChooseArea.h"
#import "TISChooseAreaTableViewCell.h"
#import "TISHeader.h"

@implementation TISChooseArea

@synthesize dataArray = _dataArray;

/**
 *  初始化控件
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableBgView];
    }
    return self;
}



/**
 *  懒加载
 */
- (TISHorButtonScroll *)horScroll {
    if (!_horScroll) {
        // 横向滚动button组件
        TIS_WEAKSELF
        _horScroll = [[TISHorButtonScroll alloc]initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, 50)];
        _horScroll.closeData = ^(NSDictionary * _Nonnull dic) {
            // 移除当前选中项
            NSInteger provinceIndex = 0;
            NSInteger cityIndex = 0;
            NSInteger areaIndex = 0;
            for (int i=0; i<weakSelf.dataArray.count; i++) {
                NSDictionary *province = weakSelf.dataArray[i];
                NSArray *cityList = province[@"children"];
                for (int j=0; j<cityList.count; j++) {
                    NSDictionary *city = cityList[j];
                    NSArray *areaList = city[@"children"];
                    for (int k=0; k<areaList.count; k++) {
                        NSDictionary *area = areaList[k];
                        if ([dic[@"value"] isEqualToString:area[@"value"]]) {
                            provinceIndex = i;
                            cityIndex = j;
                            areaIndex = k;
                        }
                    }
                }
            }
            [weakSelf changeAreaSelected:NO provinceIndex:provinceIndex cityIndex:cityIndex areaIndex:areaIndex];
            [weakSelf reloadScrollChosed:dic selected:NO];
        };
    }
    return _horScroll;
}

- (TISResetChoose *)footerView {
    if (!_footerView) {
        _footerView = [[TISResetChoose alloc] initWithFrame:CGRectMake(0, self.viewFrame.size.height - 76, self.viewFrame.size.width, 76)];
        _footerView.backgroundColor = [UIColor whiteColor];
        TIS_WEAKSELF
        _footerView.resetClicked = ^{
            // 重置数据
            [weakSelf resetData];
            weakSelf.selectArray = [[NSMutableArray alloc] initWithArray:@[]];
            weakSelf.horScroll.dataArray = weakSelf.selectArray;
        };
        _footerView.sureClicked = ^{
            // 展示选中结果
            weakSelf.sureClicked(weakSelf.selectArray);
        };
    }
    return _footerView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSArray *)cityList {
    if (!_cityList) {
        _cityList = [NSArray new];
    }
    return _cityList;
}

- (NSArray *)areaList {
    if (!_areaList) {
        _areaList = [NSArray new];
    }
    return _areaList;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray new];
    }
    return _selectArray;
}

- (UIView *)tableBgView {
    if (!_tableBgView) {
        _tableBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height)];
        _tableBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        CGFloat width = (self.viewFrame.size.width - 3) / 3;
        for (int i=0; i<3; i++) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake((width + 1) * i, 1, width, self.viewFrame.size.height - 1) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = 10 + i;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor whiteColor];
            if (i == 0) {
                tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
            tableView.rowHeight = 50;
            [tableView registerNib:[UINib nibWithNibName:@"TISChooseAreaTableViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:@"TISChooseAreaTableViewCell"];
            [_tableBgView addSubview:tableView];
        }
    }
    return _tableBgView;
}



#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 10:
            return self.dataArray.count;
        case 11:
            return self.cityList.count;
        case 12:
            return self.areaList.count;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TISChooseAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TISChooseAreaTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.isMore = self.isMore;
    switch (tableView.tag) {
        case 10:
        {
            // 省
            NSDictionary *dic = self.dataArray[indexPath.row];
            cell.nameLabel.text = dic[@"name"];
            if ([dic[@"select"] intValue] > 0) {
                // 显示数量
                cell.type = 1;
                cell.numberLabel.text = dic[@"select"];
                if (indexPath.row == self.selectProvince) {
                    // 选中
                    cell.type = 3;
                }
            } else {
                // 不显示数量
                cell.type = 2;
                if (indexPath.row == self.selectProvince) {
                    // 选中
                    cell.type = 4;
                }
            }
        }
            break;
        case 11:
        {
            // 市
            NSDictionary *dic = self.cityList[indexPath.row];
            cell.nameLabel.text = dic[@"name"];
            if (indexPath.row == self.selectCity) {
                // 选中
                cell.type = 6;
            } else {
                // 未选中
                cell.type = 5;
            }
        }
            break;
        case 12:
        {
            // 区
            NSDictionary *dic = self.areaList[indexPath.row];
            cell.nameLabel.text = dic[@"name"];
            if ([dic[@"select"] intValue] > 0) {
                // 选中
                cell.type = 8;
            } else {
                // 未选中
                cell.type = 7;
            }
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (tableView.tag) {
        case 10:
        {
            // 省
            self.selectProvince = indexPath.row;
            self.selectCity = 0;
            self.selectArea = 0;
            NSDictionary *dictionary = self.dataArray[indexPath.row];
            self.cityList = dictionary[@"children"];
            NSDictionary *dic = self.cityList[0];
            self.areaList = dic[@"children"];
            [self reloadTableView:0];
        }
            break;
        case 11:
        {
            // 市
            self.selectCity = indexPath.row;
            self.selectArea = 0;
            NSDictionary *dic = self.cityList[indexPath.row];
            self.areaList = dic[@"children"];
            [self reloadTableView:0];
        }
            break;
        case 12:
        {
            // 区
            self.selectArea = indexPath.row;
            NSDictionary *dic = self.areaList[indexPath.row];
            if (self.isMore) {
                // 多选
                BOOL select = [dic[@"select"] intValue]>0 ? NO : YES;
                [self changeAreaSelected:select provinceIndex:self.selectProvince cityIndex:self.selectCity areaIndex:self.selectArea];
                [self reloadScrollChosed:dic selected:select];
            } else {
                // 单选
                NSArray *array = @[dic];
                self.sureClicked(array);
            }
        }
            break;
        default:
            break;
    }
}



#pragma mark - 方法

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    if (_isMore) {
        // 设置为多选模式
        [self addSubview:self.horScroll];
        [self addSubview:self.footerView];
        self.horScroll.frame = CGRectMake(0, 0, self.viewFrame.size.width, 50);
        self.tableBgView.frame = CGRectMake(0, self.horScroll.frame.size.height, self.viewFrame.size.width, self.viewFrame.size.height - self.horScroll.frame.size.height - self.footerView.frame.size.height);
    } else {
        // 设置未单选模式
        [self.horScroll removeFromSuperview];
        [self.footerView removeFromSuperview];
        self.tableBgView.frame = CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height);
    }
    [self reloadTableView:0];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self updateCityAndAreaList];
    // 刷新全部列表
    [self reloadTableView:0];
}

/**
 *  更新市区列表
 */
- (void)updateCityAndAreaList {
    if (_dataArray.count > 0) {
        // 设置市级列表
        NSDictionary *city = _dataArray[self.selectProvince];
        self.cityList = city[@"children"];
        // 设置区级列表
        NSDictionary *area = self.cityList[self.selectCity];
        self.areaList = area[@"children"];
    }
}

/**
 *  刷新已选滚动视图
 *
 *  @param select 是否是选中
 */
- (void)reloadScrollChosed:(NSDictionary *)area selected:(BOOL)select {
    if (select) {
        [self.selectArray addObject:area];
    } else {
        for (int i=0; i<self.selectArray.count; i++) {
            NSDictionary *dic = self.selectArray[i];
            if ([dic[@"value"] isEqualToString:area[@"value"]]) {
                [self.selectArray removeObject:dic];
            }
        }
    }
    self.horScroll.dataArray = self.selectArray;
}


/**
 *  刷新指定tableview  0：刷新全部列表  1:刷新省级列表  2：刷新市级列表  3：刷新区级列表
 *
 *  @parama type 类型
 *
 */
- (void)reloadTableView:(NSInteger)type {
    switch (type) {
        case 1:
        {
            // 刷新省级列表
            UITableView *tableView = [self.tableBgView viewWithTag:10];
            [tableView reloadData];
        }
            break;
        case 2:
        {
            // 刷新市级列表
            UITableView *tableView = [self.tableBgView viewWithTag:11];
            [tableView reloadData];
        }
            break;
        case 3:
        {
            // 刷新区级列表
            UITableView *tableView = [self.tableBgView viewWithTag:12];
            [tableView reloadData];
        }
            break;
        default:
        {
            // 刷新全部列表
            for (int i=0; i<3; i++) {
                UITableView *tableView = [self.tableBgView viewWithTag:10 + i];
                [tableView reloadData];
            }
        }
            break;
    }
}

/**
 *  改变选择的数据
 *
 *  @param select 是否是选中
 *  @param provinceIndex 当前对象所在province位置
 *  @param cityIndex 当前对象所在city位置
 *  @param areaIndex 当前对象所在area位置
 */
- (void)changeAreaSelected:(BOOL)select provinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex {
    for (int i=0; i<self.dataArray.count; i++) {
        if (i == provinceIndex) {
            NSMutableDictionary *province = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[provinceIndex]];
            NSMutableArray *cityArray = [[NSMutableArray alloc] initWithArray:province[@"children"]];
            if (select) {
                // 选中
                province[@"select"] = [NSString stringWithFormat:@"%d", [province[@"select"] intValue] + 1];
            } else {
                // 未选中
                province[@"select"] = [NSString stringWithFormat:@"%d", [province[@"select"] intValue] - 1];
            }
            for (int j=0; j<cityArray.count; j++) {
                if (j == cityIndex) {
                    NSMutableDictionary *city = [[NSMutableDictionary alloc] initWithDictionary:cityArray[cityIndex]];
                    NSMutableArray *areaArray = [[NSMutableArray alloc] initWithArray:city[@"children"]];
                    for (int k=0; k<areaArray.count; k++) {
                        if (k == areaIndex) {
                            NSMutableDictionary *area = [[NSMutableDictionary alloc] initWithDictionary:areaArray[areaIndex]];
                            if (select) {
                                // 选中
                                area[@"select"] = [NSString stringWithFormat:@"%d", [area[@"select"] intValue] + 1];
                            } else {
                                // 未选中
                                area[@"select"] = [NSString stringWithFormat:@"%d", [area[@"select"] intValue] - 1];
                            }
                            [areaArray replaceObjectAtIndex:k withObject:area];
                            break;
                        }
                    }
                    city[@"children"] = areaArray;
                    [cityArray replaceObjectAtIndex:j withObject:city];
                    break;
                }
            }
            province[@"children"] = cityArray;
            [self.dataArray replaceObjectAtIndex:i withObject:province];
            [self updateCityAndAreaList];
            break;
        }
    }
    [self reloadTableView:0];
}

/**
 *  重置数据
 */
- (void)resetData {
    for (int i=0; i<self.dataArray.count; i++) {
        NSMutableDictionary *province = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[i]];
        NSMutableArray *cityArray = [[NSMutableArray alloc] initWithArray:province[@"children"]];
        province[@"select"] = @"0";
        for (int j=0; j<cityArray.count; j++) {
            NSMutableDictionary *city = [[NSMutableDictionary alloc] initWithDictionary:cityArray[j]];
            NSMutableArray *areaArray = [[NSMutableArray alloc] initWithArray:city[@"children"]];
            for (int k=0; k<areaArray.count; k++) {
                NSMutableDictionary *area = [[NSMutableDictionary alloc] initWithDictionary:areaArray[k]];
                area[@"select"] = @"0";
                [areaArray replaceObjectAtIndex:k withObject:area];
            }
            city[@"children"] = areaArray;
            [cityArray replaceObjectAtIndex:j withObject:city];
        }
        province[@"children"] = cityArray;
        [self.dataArray replaceObjectAtIndex:i withObject:province];
        [self updateCityAndAreaList];
    }
    [self reloadTableView:0];
}

@end
