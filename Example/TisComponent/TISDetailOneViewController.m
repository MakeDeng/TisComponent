//
//  TISDetailOneViewController.m
//  TisComponent_Example
//
//  Created by tanikawa on 2023/1/11.
//  Copyright © 2023 dengchaoyun. All rights reserved.
//

#import "TISDetailOneViewController.h"
#import "TISHeader.h"
#import "TISMBHUD.h"

#define DETAIL_LEFT_SPACE 16
#define DETAIL_WIDTH (TIS_Screen_Width - DETAIL_LEFT_SPACE * 2)

@interface TISDetailOneViewController ()
@property (nonatomic, strong) UIButton *resetButton; // 导航右侧按钮
@property (nonatomic, strong) TISModal *tisModal; // 对话框组件
@end

@implementation TISDetailOneViewController

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
    
    if ([componentName isEqualToString:@""]) {
        // **组件
        [self.resetButton setTitle:@"" forState:UIControlStateNormal];
    }
}

/**
 *  导航右侧按钮点击事件
 */
- (void)resetButtonClicked {
    NSString *componentName = self.componentDic[@"component_title"];
    if ([componentName isEqualToString:@"TISHorButtonScroll"]) {
        // **组件
        
    }
}

/**
 *  展示组件
 */
- (void)showComponent {
    NSString *componentName = self.componentDic[@"component_title"];
    TIS_WEAKSELF
    
    // 缺省页组件
    if ([componentName isEqualToString:@"TISEmptyState"]) {
        TISEmptyState *emptyState = [[TISEmptyState alloc] initWithFrame:CGRectMake(DETAIL_LEFT_SPACE, TIS_Screen_Height / 2 - 25, DETAIL_WIDTH, 50)];
        [[UIApplication sharedApplication].keyWindow addSubview:emptyState];
    }
    
    // 对话框组件
    if ([componentName isEqualToString:@"TISModal"]) {
        NSArray *array = @[
            @"默认对话框",
        ];
        for (int i=0; i<array.count; i++) {
            UIButton *modalButton = [UIButton buttonWithType:UIButtonTypeCustom];
            modalButton.frame = CGRectMake(40, TIS_NAV_HEIGHT + 30+ 70 * i, TIS_Screen_Width - 40 * 2, 40);
            [modalButton setTitle:array[i] forState:UIControlStateNormal];
            modalButton.titleLabel.font = [UIFont systemFontOfSize:16];
            modalButton.backgroundColor = COLOR_PURPLE_5;
            modalButton.layer.cornerRadius = 4;
            modalButton.layer.masksToBounds = YES;
            modalButton.tag = i + 1;
            [modalButton addTarget:self action:@selector(modalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:modalButton];
        }
        
        self.tisModal = [[TISModal alloc] initWithFrame:CGRectMake(0, 0, TIS_Screen_Width, TIS_Screen_Height)];
        self.tisModal.hidden = YES;
        [self.view addSubview:self.tisModal];
    }
}

/**
 *  modal按钮点击事件
 */
- (void)modalButtonClicked:(UIButton *)button {
    NSString *btnStr = button.titleLabel.text;
    if ([btnStr isEqualToString:@"默认对话框"]) {
        // 默认对话框
        
    } else if ([btnStr isEqualToString:@""]) {
        //
        
    } else if ([btnStr isEqualToString:@""]) {
        //
        
    }
    if (self.tisModal.isShow) {
        [self.tisModal hiddenModal];
    } else {
        [self.tisModal showModal];
    }
}

- (void)dealloc {
    [self.tisModal removeFromSuperview];
}

@end
