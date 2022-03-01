//
//  TISViewController.m
//  TisComponent
//
//  Created by dengchaoyun on 02/21/2022.
//  Copyright (c) 2022 dengchaoyun. All rights reserved.
//

#import "TISViewController.h"
#import "TISHeader.h"
#import "TISDetailViewController.h"

@interface TISViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *componentTabelVeiw;
@property (nonatomic, strong) NSArray *componentArray;

@end

@implementation TISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"组件";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.componentTabelVeiw];
}



#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.componentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.componentArray[indexPath.row];
    cell.textLabel.text = dic[@"component_title"];
    cell.detailTextLabel.text = dic[@"component_desc"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TISDetailViewController *vc = [TISDetailViewController new];
    vc.componentDic = self.componentArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 懒加载

- (UITableView *)componentTabelVeiw {
    if (!_componentTabelVeiw) {
        _componentTabelVeiw = [[UITableView alloc] initWithFrame:CGRectMake(0, TIS_NAV_HEIGHT, TIS_Screen_Width, TIS_Screen_Height - TIS_NAV_HEIGHT) style:UITableViewStylePlain];
        _componentTabelVeiw.delegate = self;
        _componentTabelVeiw.dataSource = self;
        _componentTabelVeiw.rowHeight = 60;
    }
    return _componentTabelVeiw;
}

- (NSArray *)componentArray {
    if (!_componentArray) {
        _componentArray = @[
            @{
                @"component_title": @"TISSearch",
                @"component_desc": @"搜索组件",
            },
            @{
                @"component_title": @"TISHorButtonScroll",
                @"component_desc": @"横向滚动可点击组件",
            },
            @{
                @"component_title": @"TISResetChoose",
                @"component_desc": @"重置组件",
            },
            @{
                @"component_title": @"TISChooseListView",
                @"component_desc": @"列表选择弹窗组件（可单选或多选）",
            },
            @{
                @"component_title": @"TISChooseArea",
                @"component_desc": @"选择地区弹窗组件（可单选或多选）",
            },
        ];
    }
    return _componentArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
