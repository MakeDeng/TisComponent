//
//  TISDetailViewController.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISDetailViewController.h"
#import "TISHeader.h"
#import "TISMBHUD.h"

#define DETAIL_LEFT_SPACE 16
#define DETAIL_WIDTH (TIS_Screen_Width - DETAIL_LEFT_SPACE * 2)

@interface TISDetailViewController ()

@property (nonatomic, strong) NSArray *exampleArray; // 示例数组
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据数组
@property (nonatomic, strong) NSArray *areaExampleArray; // 地区示例数组
@property (nonatomic, strong) NSMutableArray *areaArray; // 地区数据数组
@property (nonatomic, strong) UIButton *resetButton; // 导航右侧按钮

@property (nonatomic, strong) TISHorButtonScroll *horButtonScroll; // 横向滚动button组件
@property (nonatomic, strong) TISChooseListView *chooseList; // 列表选择弹窗组件（可单选或多选）
@property (nonatomic, strong) TISChooseArea *chooseArea; // 选择地区弹窗组件（可单选或多选）
@property (nonatomic, strong) TISChooseItem *chooseItem; // 载体等级或咨询方式类型选择组件（可单选或多选）
@property (nonatomic, strong) TISChooseItem *chooseItemOne; // 载体等级或咨询方式类型选择组件（可单选或多选）
@property (nonatomic, strong) TISInputSection *inputSection; // 载体面积输入区间组件
@property (nonatomic, strong) TISPhone *tisPhone; // 手机号及座机号输入组件
@property (nonatomic, strong) TISTextArea *tisTextArea; // 文本域多行输入组件（可计数与不可计数）

@end

@implementation TISDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.componentDic[@"component_title"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 设置导航栏
    [self configNavigation];
    
    // 展示组件
    [self showComponent];
}

/**
 *  隐藏键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

/**
 *  设置导航栏
 */
- (void)configNavigation {
    NSString *componentName = self.componentDic[@"component_title"];
    
    self.resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.resetButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    [self.resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.resetButton];
    self.navigationItem.rightBarButtonItem = item;
    
    if ([componentName isEqualToString:@"TISHorButtonScroll"]) {
        // 横向滚动button组件
        [self.resetButton setTitle:@"重置数据" forState:UIControlStateNormal];
    }
    
    if ([componentName isEqualToString:@"TISChooseListView"]) {
        // 列表选择弹窗组件（可单选或多选）
        [self.resetButton setTitle:@"切换单/多选" forState:UIControlStateNormal];
    }
    
    if ([componentName isEqualToString:@"TISChooseArea"]) {
        // 选择地区弹窗组件（可单选或多选）
        [self.resetButton setTitle:@"切换单/多选" forState:UIControlStateNormal];
    }
    
    if ([componentName isEqualToString:@"TISChooseItem"]) {
        // 载体等级或咨询方式类型选择组件（可单选或多选）
        [self.resetButton setTitle:@"切换单/多选" forState:UIControlStateNormal];
    }
    
    if ([componentName isEqualToString:@"TISTextArea"]) {
        // 文本域多行输入组件（可计数与不可计数）
        [self.resetButton setTitle:@"切换可/不可计数" forState:UIControlStateNormal];
    }
}

/**
 *  导航右侧按钮点击事件
 */
- (void)resetButtonClicked {
    NSString *componentName = self.componentDic[@"component_title"];
    if ([componentName isEqualToString:@"TISHorButtonScroll"]) {
        // 横向滚动button组件
        
        self.horButtonScroll.dataArray = self.dataArray;
    }
    
    if ([componentName isEqualToString:@"TISChooseListView"]) {
        // 列表选择弹窗组件（可单选或多选）
        self.chooseList.isMore = !self.chooseList.isMore;
    }
    
    if ([componentName isEqualToString:@"TISChooseArea"]) {
        // 选择地区弹窗组件（可单选或多选）
        self.chooseArea.isMore = !self.chooseArea.isMore;
    }
    
    if ([componentName isEqualToString:@"TISChooseItem"]) {
        // 载体等级或咨询方式类型选择组件（可单选或多选）
        self.chooseItem.isMore = !self.chooseItem.isMore;
        self.chooseItemOne.isMore = !self.chooseItemOne.isMore;
    }
    
    if ([componentName isEqualToString:@"TISTextArea"]) {
        // 文本域多行输入组件（可计数与不可计数）
        self.tisTextArea.showNumber = !self.tisTextArea.showNumber;
    }
}

/**
 *  展示组件
 */
- (void)showComponent {
    NSString *componentName = self.componentDic[@"component_title"];
    TIS_WEAKSELF
    
    // 搜索组件
    if ([componentName isEqualToString:@"TISSearch"]) {
        TISSearch *tisSearch = [[TISSearch alloc] initWithFrame:CGRectMake(DETAIL_LEFT_SPACE, TIS_Screen_Height / 2 - 25, DETAIL_WIDTH, 50)];
        [self.view addSubview:tisSearch];
        tisSearch.goSearch = ^(NSString * _Nonnull string) {
            NSString *name = [NSString stringWithFormat:@"回调搜索的内容: \n%@", string];
            [TISMBHUD showTostHud:name];
        };
    }
    
    // 横向滚动button组件
    if ([componentName isEqualToString:@"TISHorButtonScroll"]) {
        TISSearch *tisSearch = [[TISSearch alloc] initWithFrame:CGRectMake(DETAIL_LEFT_SPACE, TIS_NAV_HEIGHT, DETAIL_WIDTH, 50)];
        tisSearch.textFiled.returnKeyType = UIReturnKeyJoin;
        [self.view addSubview:tisSearch];
        tisSearch.goSearch = ^(NSString * _Nonnull string) {
            NSDictionary *dic = @{
                @"id": [NSString stringWithFormat:@"%d", [self getMaxId:weakSelf.horButtonScroll.dataArray] + 1],
                @"name": string,
                @"select": @"0",
            };
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:weakSelf.horButtonScroll.dataArray];
            [array addObject:dic];
            self.horButtonScroll.dataArray = array;
        };
        
        self.horButtonScroll = [[TISHorButtonScroll alloc]initWithFrame:CGRectMake(0, TIS_Screen_Height / 2 - 25, TIS_Screen_Width, 50)];
        self.horButtonScroll.dataArray = self.dataArray;
        [self.view addSubview:self.horButtonScroll];
        self.horButtonScroll.closeData = ^(NSDictionary * _Nonnull dic) {
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:weakSelf.horButtonScroll.dataArray];
            for (int i=0; i<array.count; i++) {
                NSDictionary *dictionary = array[i];
                if ([dic[@"id"] isEqualToString:dictionary[@"id"]]) {
                    [array removeObject:dic];
                }
            }
            weakSelf.horButtonScroll.dataArray = array;
        };
    }
    
    // 重置组件
    if ([componentName isEqualToString:@"TISResetChoose"]) {
        TISResetChoose *resetChoose = [[TISResetChoose alloc] initWithFrame:CGRectMake(0, TIS_Screen_Height / 2 - 32, TIS_Screen_Width, 64)];
        resetChoose.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:resetChoose];
        resetChoose.resetClicked = ^{
            [TISMBHUD showTostHud:@"重置按钮点击了"];
        };
        resetChoose.sureClicked = ^{
            [TISMBHUD showTostHud:@"确定按钮点击了"];
        };
    }
    
    // 列表选择弹窗组件（可单选或多选）
    if ([componentName isEqualToString:@"TISChooseListView"]) {
        self.chooseList = [[TISChooseListView alloc] initWithFrame:CGRectMake(0, TIS_NAV_HEIGHT, TIS_Screen_Width, TIS_Screen_Height - TIS_NAV_HEIGHT)];
        self.chooseList.isMore = YES;
        self.chooseList.dataArray = self.dataArray;
        self.chooseList.selectedData = ^(NSArray * _Nonnull array) {
            NSString *name = [NSString stringWithFormat:@"回调确认的内容: \n%@", [weakSelf getShowName:array]];
            [TISMBHUD showTostHud:name];
        };
        self.chooseList.goSearch = ^(NSString * _Nonnull string) {
            NSString *name = [NSString stringWithFormat:@"回调搜索的内容: \n%@", string];
            [TISMBHUD showTostHud:name];
        };
        [self.view addSubview:self.chooseList];
    }
    
    // 选择地区弹窗组件（可单选或多选）
    if ([componentName isEqualToString:@"TISChooseArea"]) {
        self.chooseArea = [[TISChooseArea alloc] initWithFrame:CGRectMake(0, TIS_NAV_HEIGHT, TIS_Screen_Width, TIS_Screen_Height - TIS_NAV_HEIGHT)];
        self.chooseArea.isMore = YES;
        self.chooseArea.dataArray = self.areaArray;
        self.chooseArea.sureClicked = ^(NSArray * _Nonnull array) {
            NSString *name = [NSString stringWithFormat:@"回调确认的内容: \n%@", [weakSelf getShowName:array]];
            [TISMBHUD showTostHud:name];
        };
        [self.view addSubview:self.chooseArea];
    }
    
    // 载体等级或咨询方式类型选择组件（可单选或多选）
    if ([componentName isEqualToString:@"TISChooseItem"]) {
        self.chooseItem = [[TISChooseItem alloc] init];
        self.chooseItem.frame = CGRectMake(0, TIS_NAV_HEIGHT, TIS_Screen_Width, TIS_Screen_Height - TIS_NAV_HEIGHT);
        self.chooseItem.isMore = YES;
        self.chooseItem.dataArray = self.dataArray;
        [self.view addSubview:self.chooseItem];
        
        self.chooseItemOne = [[TISChooseItem alloc] init];
        self.chooseItemOne.frame = CGRectMake(0, 450, TIS_Screen_Width, TIS_Screen_Height - TIS_NAV_HEIGHT);
        self.chooseItemOne.isMore = YES;
        self.chooseItemOne.dataArray = [[NSMutableArray alloc] initWithArray:@[
            @{
                @"id": @"1",
                @"name": @"★",
                @"select": @"0",
            },
            @{
                @"id": @"2",
                @"name": @"★★",
                @"select": @"0",
            },
            @{
                @"id": @"3",
                @"name": @"★★★",
                @"select": @"0",
            },
            @{
                @"id": @"4",
                @"name": @"★★★★",
                @"select": @"0",
            },
            @{
                @"id": @"5",
                @"name": @"★★★★★",
                @"select": @"0",
            },
        ]];
        [self.view addSubview:self.chooseItemOne];
    }
    
    // 载体面积输入区间组件
    if ([componentName isEqualToString:@"TISInputSection"]) {
        self.inputSection = [[TISInputSection alloc] initWithFrame:CGRectMake(50, TIS_NAV_HEIGHT + 30, TIS_Screen_Width - 100, 60)];
        self.inputSection.backgroundColor = [UIColor whiteColor];
        self.inputSection.pointNumber = 4;
        self.inputSection.layer.cornerRadius = 5;
        self.inputSection.layer.masksToBounds = YES;
        [self.view addSubview:self.inputSection];
    }
    
    // 手机号及座机号输入组件
    if ([componentName isEqualToString:@"TISPhone"]) {
        self.tisPhone = [[TISPhone alloc] initWithFrame:CGRectMake(100, TIS_NAV_HEIGHT + 30, TIS_Screen_Width - 200, 60)];
        self.tisPhone.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.tisPhone];
    }
    
    // 文本域多行输入组件（可计数与不可计数）
    if ([componentName isEqualToString:@"TISTextArea"]) {
        self.tisTextArea = [[TISTextArea alloc] initWithFrame:CGRectMake(100, TIS_NAV_HEIGHT + 30, TIS_Screen_Width - 200, 200)];
        self.tisTextArea.backgroundColor = [UIColor whiteColor];
        self.tisTextArea.placeholder = @"请输入";
        self.tisTextArea.limitCount = 30;
        self.tisTextArea.defaultText = @"是拉萨开发萨菲隆卡射流风机暗示法拉发送到是拉萨开发萨菲隆卡射流风机暗示法拉发送到";
        [self.view addSubview:self.tisTextArea];
        
        TISTextArea *tisTextAreaTitle = [[TISTextArea alloc] initWithFrame:CGRectMake(100, TIS_NAV_HEIGHT + 260, TIS_Screen_Width - 200, 200)];
        tisTextAreaTitle.backgroundColor = [UIColor whiteColor];
        tisTextAreaTitle.textAreaSpace = 8;
        tisTextAreaTitle.limitCount = 200;
        tisTextAreaTitle.placeholder = @"请输入自定义默认文字内容";
        tisTextAreaTitle.showNumber = YES;
        tisTextAreaTitle.title = @"这是一个标题哟";
        tisTextAreaTitle.titleLabelHeight = 15;
        [self.view addSubview:tisTextAreaTitle];
    }
    
    // 单选及多选组件
    if ([componentName isEqualToString:@"TISRadio"]) {
        NSArray *array = @[
            @{
                @"text": @"大尺寸正常未选中",
                @"status": @(RADIO_NORMAL),
                @"size": @(RADIO_LARGE)
            },
            @{
                @"text": @"大尺寸正常已选中",
                @"status": @(RADIO_SELECTED),
                @"size": @(RADIO_LARGE)
            },
            @{
                @"text": @"大尺寸失效未选中",
                @"status": @(RADIO_DISABLE_NORMAL),
                @"size": @(RADIO_LARGE)
            },
            @{
                @"text": @"大尺寸失效已选中",
                @"status": @(RADIO_DISABLE_SELECTED),
                @"size": @(RADIO_LARGE)
            },
            @{
                @"text": @"小尺寸正常未选中",
                @"status": @(RADIO_NORMAL),
                @"size": @(RADIO_SMALL)
            },
            @{
                @"text": @"小尺寸正常已选中",
                @"status": @(RADIO_SELECTED),
                @"size": @(RADIO_SMALL)
            },
            @{
                @"text": @"小尺寸失效未选中",
                @"status": @(RADIO_DISABLE_NORMAL),
                @"size": @(RADIO_SMALL)
            },
            @{
                @"text": @"小尺寸失效已选中",
                @"status": @(RADIO_DISABLE_SELECTED),
                @"size": @(RADIO_SMALL)
            },
            @{
                @"text": @"大尺寸自定义样式未选中测试超出屏幕改变父组件宽度",
                @"status": @(RADIO_NORMAL),
                @"size": @(RADIO_LARGE)
            },
            @{
                @"text": @"大尺寸自定义样式已选中父视图变宽",
                @"status": @(RADIO_SELECTED),
                @"size": @(RADIO_LARGE)
            },
            @{
                @"text": @"小尺寸自定义样式未选中",
                @"status": @(RADIO_NORMAL),
                @"size": @(RADIO_SMALL)
            },
            @{
                @"text": @"小尺寸自定义样式已选中",
                @"status": @(RADIO_SELECTED),
                @"size": @(RADIO_SMALL)
            },
        ];
        for (int i=0; i<array.count; i++) {
            NSDictionary *dic = array[i];
            TISRadio *radio = [[TISRadio alloc] initWithFrame:CGRectMake(100, TIS_NAV_HEIGHT + 30 + 40 * i, TIS_Screen_Width - 200, 30)];
            radio.backgroundColor = [UIColor whiteColor];
            radio.layer.cornerRadius = 4;
            radio.text = dic[@"text"];
            radio.status = [dic[@"status"] integerValue];
            radio.radioSize = [dic[@"size"] integerValue];
            if (i==8 || i==10) {
                radio.normal_image = [UIImage imageNamed:TISCommonSrcName(@"checkbox_react_normal")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"checkbox_react_normal")];
                radio.selected_image = [UIImage imageNamed:TISCommonSrcName(@"checkbox_react_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"checkbox_react_selected")];
            }
            if (i==9 || i==11) {
                radio.normal_image = [UIImage imageNamed:TISCommonSrcName(@"checkbox_react_normal")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"checkbox_react_normal")];
                radio.selected_image = [UIImage imageNamed:TISCommonSrcName(@"checkbox_react_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"checkbox_react_selected")];
            }
            [self.view addSubview:radio];
        }
    }
    
    // 输入框组件
    if ([componentName isEqualToString:@"TISInput"]) {
        // 基础输入框
        TISInput *baseInput = [[TISInput alloc] initWithFrame:CGRectMake(30, TIS_NAV_HEIGHT + 30, TIS_Screen_Width - 60, 60)];
        baseInput.backgroundColor = [UIColor whiteColor];
        baseInput.layer.cornerRadius = 4;
        baseInput.clearEnable = YES;
        baseInput.inputTextFiled.placeholder = @"基础输入框";
        [self.view addSubview:baseInput];

        // 左侧布局
        TISInput *leftExpandInput = [[TISInput alloc] initWithFrame:CGRectMake(30, (TIS_NAV_HEIGHT + 30) + (20 + 60), TIS_Screen_Width - 60, 60)];
        leftExpandInput.backgroundColor = [UIColor whiteColor];
        leftExpandInput.layer.cornerRadius = 4;
        leftExpandInput.clearEnable = YES;
        leftExpandInput.inputType = HORRIZONTAL_LEFT;
        leftExpandInput.inputTextFiled.placeholder = @"左侧拓展布局输入框";
        [self.view addSubview:leftExpandInput];
        // 添加上方拓展组件
        UILabel *leftExpandLabel = [UILabel new];
        leftExpandLabel.frame = CGRectMake(0, 0, 110, 60 - 36);
        leftExpandLabel.text = @"左侧拓展布局";
        [leftExpandInput.expandView addSubview:leftExpandLabel];
        leftExpandInput.expandView.frame = CGRectMake(0, 0, leftExpandLabel.frame.size.width, 60);
        
        // 右侧布局
        TISInput *rightExpandInput = [[TISInput alloc] initWithFrame:CGRectMake(30, (TIS_NAV_HEIGHT + 30) + (20 + 60) * 2, TIS_Screen_Width - 60, 60)];
        rightExpandInput.backgroundColor = [UIColor whiteColor];
        rightExpandInput.layer.cornerRadius = 4;
        rightExpandInput.clearEnable = YES;
        rightExpandInput.inputType = HORRIZONTAL_RIGHT;
        rightExpandInput.inputTextFiled.placeholder = @"右侧拓展布局输入框";
        rightExpandInput.inputTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
        [self.view addSubview:rightExpandInput];
        // 添加上方拓展组件
        UILabel *rightExpandLabel = [UILabel new];
        rightExpandLabel.frame = CGRectMake(0, 0, 25, 60 - 36);
        rightExpandLabel.text = @"m²";
        [rightExpandInput.expandView addSubview:rightExpandLabel];
        rightExpandInput.expandView.frame = CGRectMake(0, 0, rightExpandLabel.frame.size.width, 60);
        
        // 上下布局
        TISInput *topExpandInput = [[TISInput alloc] initWithFrame:CGRectMake(30,(TIS_NAV_HEIGHT + 30) + (20 + 60) * 3, TIS_Screen_Width - 60, 108)];
        topExpandInput.backgroundColor = [UIColor whiteColor];
        topExpandInput.layer.cornerRadius = 4;
        topExpandInput.clearEnable = YES;
        topExpandInput.inputType = VERTICAL;
        topExpandInput.inputTextFiled.placeholder = @"上下布局输入框";
        [self.view addSubview:topExpandInput];
        // 添加上方拓展组件
        UILabel *topExpandLabel = [UILabel new];
        topExpandLabel.frame = CGRectMake(0, 0, topExpandInput.expandView.frame.size.width, 30);
        topExpandLabel.text = @"上下拓展布局";
        [topExpandInput.expandView addSubview:topExpandLabel];
        topExpandInput.expandView.frame = CGRectMake(0, 0, 0, topExpandLabel.frame.size.height);
        
        // 自定义拓展组件
        CGFloat height = 40;
        TISInput *diyExpandInput = [[TISInput alloc] initWithFrame:CGRectMake(30, (TIS_NAV_HEIGHT + 30) + (20 + 60) * 4 + 48, TIS_Screen_Width - 60, height)];
        diyExpandInput.backgroundColor = [UIColor whiteColor];
        diyExpandInput.layer.cornerRadius = 4;
        diyExpandInput.horizontalSpace = 10;
        diyExpandInput.verticalSpace = 8;
        diyExpandInput.clearEnable = YES;
        diyExpandInput.inputType = HORRIZONTAL_RIGHT;
        diyExpandInput.inputTextFiled.placeholder = @"拓展组件随便自定义，大小自己控制尺寸就行";
        diyExpandInput.inputTextFiled.font = [UIFont systemFontOfSize:10];
        [self.view addSubview:diyExpandInput];
        // 添加自定义拓展组件
        CGFloat verticalSpace = diyExpandInput.verticalSpace * 2;
        UIView *diyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, height - verticalSpace)];
        diyView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        diyView.layer.cornerRadius = 4;
        UILabel *diyExpandLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, height - verticalSpace)];
        diyExpandLabel.text = @"自定义拓展布局";
        diyExpandLabel.font = [UIFont systemFontOfSize:10];
        [diyView addSubview:diyExpandLabel];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, (height - verticalSpace - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"AppIcon"];
        [diyView addSubview:imageView];
        [diyExpandInput.expandView addSubview:diyView];
        diyExpandInput.expandView.frame = CGRectMake(0, 0, diyView.frame.size.width, height);
    }
    
}



/**
 *  获取数据中最大的id
 */
- (int)getMaxId:(NSArray *)array {
    NSString *ID = @"";
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        if (i == 0) {
            ID = dic[@"id"];
        } else {
            if ([dic[@"id"] intValue] > [ID intValue]) {
                ID = dic[@"id"];
            }
        }
    }
    return [ID intValue];
}

/**
 *  拼接要显示的结果
 */
- (NSString *)getShowName:(NSArray *)array {
    NSString *name = @"";
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        if (i == 0) {
            name = dic[@"name"];
        } else {
            name = [NSString stringWithFormat:@"%@\n%@", name, dic[@"name"]];
        }
    }
    return name;
}



#pragma mark - 数据源

- (NSArray *)exampleArray {
    if (!_exampleArray) {
        _exampleArray = @[
            @{
                @"id": @"1",
                @"name": @"北京大学",
                @"select": @"0",
            },
            @{
                @"id": @"2",
                @"name": @"清华",
                @"select": @"0",
            },
            @{
                @"id": @"3",
                @"name": @"天津大",
                @"select": @"0",
            },
            @{
                @"id": @"4",
                @"name": @"南大",
                @"select": @"0",
            },
            @{
                @"id": @"5",
                @"name": @"天津师范大学",
                @"select": @"0",
            },
            @{
                @"id": @"6",
                @"name": @"师",
                @"select": @"0",
            }
        ];
    }
    return _exampleArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithArray:self.exampleArray];
    }
    return _dataArray;
}

- (NSArray *)areaExampleArray {
    if (!_areaExampleArray) {
        _areaExampleArray = @[
            @{
                @"name": @"全部",
                @"children": @[
                    @{
                        @"name": @"全部",
                        @"children": @[
                            @{
                                @"name": @"全部",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"1",
                            },
                        ],
                        @"select": @"0",
                        @"value": @"2",
                    },
                ],
                @"select": @"0",
                @"value": @"3",
            },
            @{
                @"name": @"北京市",
                @"children": @[
                    @{
                        @"name": @"北京市",
                        @"children": @[
                            @{
                                @"name": @"朝阳区",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"4",
                            },
                            @{
                                @"name": @"大兴区",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"5",
                            },
                            @{
                                @"name": @"东城区",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"6",
                            },
                        ],
                        @"select": @"0",
                        @"value": @"7",
                    },
                ],
                @"select": @"0",
                @"value": @"8",
            },
            @{
                @"name": @"河南省",
                @"children": @[
                    @{
                        @"name": @"安阳市",
                        @"children": @[
                            @{
                                @"name": @"滑县",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"9",
                            },
                            @{
                                @"name": @"林州市",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"10",
                            },
                            @{
                                @"name": @"龙安区啊",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"11",
                            },
                        ],
                        @"select": @"0",
                        @"value": @"12",
                    },
                    @{
                        @"name": @"郑州市",
                        @"children": @[
                            @{
                                @"name": @"二七区",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"13",
                            },
                            @{
                                @"name": @"经开区",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"14",
                            },
                            @{
                                @"name": @"金水区",
                                @"children": @[],
                                @"select": @"0",
                                @"value": @"15",
                            },
                        ],
                        @"select": @"0",
                        @"value": @"16",
                    },
                ],
                @"select": @"0",
                @"value": @"17",
            },
        ];
    }
    return _areaExampleArray;
}

- (NSMutableArray *)areaArray {
    if (!_areaArray) {
        _areaArray = [[NSMutableArray alloc] initWithArray:self.areaExampleArray];
    }
    return _areaArray;
}


@end
