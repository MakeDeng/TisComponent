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
#import "TISButtonDetailViewController.h"

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
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = self.componentArray[indexPath.row];
    
    if ([[dictionary objectForKey:@"component_title"] isEqualToString:@"TISButton"]) {
        // TISButton按钮组件
        TISButtonDetailViewController *vc = [TISButtonDetailViewController new];
        vc.componentDic = dictionary;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        // TIS组件
        TISDetailViewController *vc = [TISDetailViewController new];
        vc.componentDic = dictionary;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark - 懒加载

- (UITableView *)componentTabelVeiw {
    if (!_componentTabelVeiw) {
        _componentTabelVeiw = [[UITableView alloc] initWithFrame:CGRectMake(0, TIS_NAV_HEIGHT, TIS_Screen_Width, TIS_Screen_Height - TIS_NAV_HEIGHT) style:UITableViewStylePlain];
        _componentTabelVeiw.delegate = self;
        _componentTabelVeiw.dataSource = self;
        _componentTabelVeiw.estimatedRowHeight = 60;
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
            @{
                @"component_title": @"TISChooseItem",
                @"component_desc": @"载体等级或咨询方式类型选择组件（可单选或多选）",
            },
            @{
                @"component_title": @"TISInputSection",
                @"component_desc": @"载体面积输入区间组件",
            },
            @{
                @"component_title": @"TISPhone",
                @"component_desc": @"手机号及座机号输入组件",
            },
            @{
                @"component_title": @"TISButton",
                @"component_desc": @"按钮组件",
            },
            @{
                @"component_title": @"TISTextArea",
                @"component_desc": @"文本域多行输入框组件",
            },
            @{
                @"component_title": @"TISRadio",
                @"component_desc": @"单选及多选组件",
            },
            @{
                @"component_title": @"TISInput",
                @"component_desc": @"输入框组件",
            },
            @{
                @"component_title": @"TISSwitch",
                @"component_desc": @"开关组件",
            },
            @{
                @"component_title": @"TISLoading",
                @"component_desc": @"loading组件",
            },
            @{
                @"component_title": @"TISToast",
                @"component_desc": @"toast组件",
            },
            @{
                @"component_title": @"TISNoticeBar",
                @"component_desc": @"通知栏组件",
            },
            @{
                @"component_title": @"TISBadge",
                @"component_desc": @"徽标组件",
            },
            @{
                @"component_title": @"TISActionSheet",
                @"component_desc": @"动作面板组件",
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
