//
//  TISChooseListView.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISChooseListView.h"
#import "TISChooseListTableViewCell.h"
#import "TISHeader.h"

@implementation TISChooseListView

@synthesize dataArray = _dataArray;

/**
 *  初始化控件
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerView];
        [self addSubview:self.listTableView];
        [self addSubview:self.requestView];
    }
    return self;
}

/**
 *  懒加载
 */
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 56, self.viewFrame.size.width, self.viewFrame.size.height - 56) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor = [UIColor whiteColor];
        _listTableView.rowHeight = 56;
        [_listTableView registerNib:[UINib nibWithNibName:@"TISChooseListTableViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:@"TISChooseListTableViewCell"];
    }
    return _listTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, 56)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        // 搜索组件
        self.tisSearch = [[TISSearch alloc]initWithFrame:CGRectMake(16, 0, self.viewFrame.size.width - 16 * 2, 56)];
        [_headerView addSubview:self.tisSearch];
        TIS_WEAKSELF
        self.tisSearch.goSearch = ^(NSString * _Nonnull string) {
            weakSelf.goSearch(string);
            [weakSelf.listTableView reloadData];
        };
        
        // 横向滚动button组件
        self.horScroll = [[TISHorButtonScroll alloc]initWithFrame:CGRectMake(16, 60, self.viewFrame.size.width - 16 * 2, 28)];
        self.horScroll.hidden = YES;
        [_headerView addSubview:self.horScroll];
        self.horScroll.closeData = ^(NSDictionary * _Nonnull dic) {
            [weakSelf changeChoose:dic[@"id"]];
            [weakSelf showSelectedData:nil];
        };
        
        [_headerView addSubview:self.lineView];
    }
    return _headerView;
}

- (TISResetChoose *)footerView {
    if (!_footerView) {
        _footerView = [[TISResetChoose alloc] initWithFrame:CGRectMake(0, self.viewFrame.size.height - 76, self.viewFrame.size.width, 76)];
        _footerView.backgroundColor = [UIColor whiteColor];
        TIS_WEAKSELF
        _footerView.resetClicked = ^{
            // 清空已选择状态
            for (int i=0; i<weakSelf.dataArray.count; i++) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:weakSelf.dataArray[i]];
                dic[@"select"] = @"0";
                [weakSelf.dataArray replaceObjectAtIndex:i withObject:dic];
            }
            [weakSelf.listTableView reloadData];
            // 清空头部滚动选项
            [weakSelf resetAll];
            weakSelf.horScroll.dataArray = @[];
            // 重置搜索条件
            weakSelf.tisSearch.textFiled.text = @"";
        };
        _footerView.sureClicked = ^{
            NSMutableArray *array = [weakSelf getSelectArray];
            weakSelf.selectedData(array);
        };
    }
    return _footerView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 98, TIS_Screen_Width, 1)];
        _lineView.backgroundColor = COLOR_M8;
    }
    return _lineView;
}

- (TISChooseListRequestView *)requestView {
    if (!_requestView) {
        _requestView = [[TISChooseListRequestView alloc] initWithFrame:CGRectMake(0, 100, self.viewFrame.size.width, self.viewFrame.size.height - 176)];
        _requestView.viewType = EMPTY;
        _requestView.hidden = YES;
    }
    return _requestView;
}



#pragma mark - 方法

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    NSArray *array = [self getSelectArray];
    if (_isMore) {
        // 设置为多选模式
        if (array.count>0) {
            self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 100);
            self.listTableView.frame = CGRectMake(0, self.headerView.frame.size.height, self.viewFrame.size.width, self.viewFrame.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height);
        } else {
            self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 56);
            self.listTableView.frame = CGRectMake(0, self.headerView.frame.size.height, self.viewFrame.size.width, self.viewFrame.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height);
        }
    } else {
        // 设置为单选模式
        self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 56);
        self.listTableView.frame = CGRectMake(0, 56, self.viewFrame.size.width, self.viewFrame.size.height - 56);
    }
    self.requestView.frame = self.listTableView.frame;
    [self.requestView resizeSubview];
    if (isMore) {
        [self addSubview:self.footerView];
    } else {
        [self.footerView removeFromSuperview];
    }
    [self.listTableView reloadData];
}

/// 设置是否有已选区(多选)
/// - Parameter isHave: 是否有
- (void)setIsHaveSelectArea:(BOOL)isHave {
    if (isHave) {
        self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 100);
        self.horScroll.hidden = NO;
        self.listTableView.frame = CGRectMake(0, self.headerView.frame.size.height, self.viewFrame.size.width, self.viewFrame.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height);
        [self bringSubviewToFront:self.lineView];
        
    } else {
        self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 56);
        self.horScroll.hidden = YES;
        self.listTableView.frame = CGRectMake(0, self.headerView.frame.size.height, self.viewFrame.size.width, self.viewFrame.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height);
    }
    self.requestView.frame = self.listTableView.frame;
    [self.requestView resizeSubview];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.listTableView reloadData];
}



#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TISChooseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TISChooseListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //数据
    NSDictionary *dictionary = self.dataArray[indexPath.row];
    cell.keyword = self.tisSearch.textFiled.text;
    cell.nameLabel.text = dictionary[@"name"];
    if (self.isMore) {
         // 多选
        if ([dictionary[@"select"] isEqualToString:@"1"]) {
            // 选中
            if (![self.tisSearch.textFiled.text isEqualToString:@""]) {
                // 高亮
                cell.chooseType = MORE_HIGHTLIGHT_SELECT;
            } else {
                cell.chooseType = MORE_SELECT;
            }
        } else {
            // 未选中
            if (![self.tisSearch.textFiled.text isEqualToString:@""]) {
                // 高亮
                cell.chooseType = MORE_HIGHTLIGHT_UNSELECT;
            } else {
                cell.chooseType = MORE;
            }
        }
    } else {
        // 单选
        if (![self.tisSearch.textFiled.text isEqualToString:@""]) {
            cell.chooseType = SINGLE_HIGHTLIGHT;
        } else {
            cell.chooseType = SINGLE;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[indexPath.row]];
    if (self.isMore) {
        // 多选
        [self changeChoose:dictionary[@"id"]];
        // 筛选出已选中的展示出来
        [self showSelectedData:indexPath];
    } else {
        // 单选
        NSMutableArray *array = [NSMutableArray new];
        [array addObject:dictionary];
        self.selectedData(array);
    }
    [self.listTableView reloadData];
}

/**
 *  展示已选结果
 */
- (void)showSelectedData:(nullable NSIndexPath *)indexPath {
    NSMutableArray *array = [self getSelectArray];
    [self setIsHaveSelectArea:array.count>0 ? YES : NO];
    self.footerView.chooseNumber = array.count;
    self.horScroll.dataArray = array;
    if (indexPath == nil) {
        [self.listTableView reloadData];
    } else {
        [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

/// 改变选中状态
/// - Parameter ID: 要改变的对象的id
- (void)changeChoose:(NSString *)ID {
    for (int i=0; i<self.dataArray.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[i]];
        if ([dic[@"id"] isEqualToString:ID]) {
            if ([dic[@"select"] isEqualToString:@"1"]) {
                dic[@"select"] = @"0";
            } else {
                dic[@"select"] = @"1";
            }
            self.dataArray[i] = dic;
            break;
        }
    }
}

/// 清空所有选中
- (void)resetAll {
    for (int i=0; i<self.dataArray.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[i]];
        dic[@"select"] = @"0";
        self.dataArray[i] = dic;
    }
    [self showSelectedData:nil];
}

/// 获取已选中数组
- (NSMutableArray *)getSelectArray {
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in self.dataArray) {
        if ([dic[@"select"] isEqualToString:@"1"]) {
            [array addObject:dic];
        }
    }
    return array;
}


@end
