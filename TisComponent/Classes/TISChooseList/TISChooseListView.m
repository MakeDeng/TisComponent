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
    }
    return self;
}

/**
 *  懒加载
 */
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.viewFrame.size.width, self.viewFrame.size.height - 50) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor = [UIColor whiteColor];
        _listTableView.rowHeight = 50;
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

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    return _selectedArray;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, 100)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        // 搜索组件
        self.tisSearch = [[TISSearch alloc]initWithFrame:CGRectMake(16, 0, self.viewFrame.size.width - 16 * 2, 50)];
        [_headerView addSubview:self.tisSearch];
        TIS_WEAKSELF
        self.tisSearch.goSearch = ^(NSString * _Nonnull string) {
            weakSelf.goSearch(string);
        };
        
        // 横向滚动button组件
        self.horScroll = [[TISHorButtonScroll alloc]initWithFrame:CGRectMake(16, 50, self.viewFrame.size.width - 16 * 2, 50)];
        [_headerView addSubview:self.horScroll];
        self.horScroll.closeData = ^(NSDictionary * _Nonnull dic) {
            for (NSMutableDictionary *dictionary in weakSelf.dataArray) {
                if ([dictionary[@"id"] isEqualToString:dic[@"id"]]) {
                    if ([dictionary[@"select"] isEqualToString:@"1"]) {
                        dictionary[@"select"] = @"0";
                    } else {
                        dictionary[@"select"] = @"1";
                    }
                    [weakSelf showSelectedData:dictionary];
                    [weakSelf.listTableView reloadData];
                    break;
                }
            }
        };
    }
    return _headerView;
}

- (TISResetChoose *)footerView {
    if (!_footerView) {
        _footerView = [[TISResetChoose alloc] initWithFrame:CGRectMake(0, self.viewFrame.size.height - 64, self.viewFrame.size.width, 64)];
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
            [weakSelf.selectedArray removeAllObjects];
            weakSelf.horScroll.dataArray = @[];
            // 重置搜索条件
            weakSelf.tisSearch.textFiled.text = @"";
        };
        _footerView.sureClicked = ^{
            weakSelf.selectedData(weakSelf.selectedArray);
        };
    }
    return _footerView;
}



#pragma mark - 方法

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    if (_isMore) {
        // 设置为多选模式
        [self addSubview:self.footerView];
        self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 100);
        self.listTableView.frame = CGRectMake(0, self.headerView.frame.size.height, self.viewFrame.size.width, self.viewFrame.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height);
    } else {
        // 设置未单选模式
        [self.footerView removeFromSuperview];
        self.headerView.frame = CGRectMake(0, 0, self.viewFrame.size.width, 50);
        self.listTableView.frame = CGRectMake(0, 50, self.viewFrame.size.width, self.viewFrame.size.height - 50);
    }
    [self.listTableView reloadData];
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
    cell.isMore = self.isMore;
    cell.nameLabel.text = dictionary[@"name"];
    if ([dictionary[@"select"] isEqualToString:@"1"]) {
        cell.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"selected")];
    } else {
        cell.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"un_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"un_selected")];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[indexPath.row]];
    if ([dictionary[@"select"] isEqualToString:@"1"]) {
        dictionary[@"select"] = @"0";
    } else {
        dictionary[@"select"] = @"1";
    }
    if (self.isMore) {
        // 多选
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dictionary];
        // 筛选出已选中的展示出来
        [self showSelectedData:dictionary];
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
- (void)showSelectedData:(NSDictionary *)dictionary {
    if ([dictionary[@"select"] isEqualToString:@"1"]) {
        // 选中
        [self.selectedArray addObject:dictionary];
    } else {
        // 取消选中
        for (int i=0; i<self.selectedArray.count; i++) {
            NSDictionary *dic = self.selectedArray[i];
            if ([dic[@"id"] isEqualToString:dictionary[@"id"]]) {
                [self.selectedArray removeObject:dic];
            }
        }
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.selectedArray];
    self.horScroll.dataArray = array;
}


@end
