//
//  TISButtonDetailViewController.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/5/19.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISButtonDetailViewController.h"
#import "TISHeader.h"

@interface TISButtonDetailViewController ()

@property (nonatomic, strong) TISButton *loadingButton; // loading按钮

@end

@implementation TISButtonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.componentDic[@"component_title"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建button实例
    [self creatButtonExample];
}

/*
 *  创建button实例
 */
- (void)creatButtonExample {
    CGFloat left = 20;
    CGFloat width = (TIS_Screen_Width - left * 2);
    CGFloat height = 40;
    
    // 普通按钮
    TISButton *normalButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [normalButton setTitle:@"普通按钮" forState:UIControlStateNormal];
    normalButton.frame = CGRectMake(left, 100, width, height);
    normalButton.cornerRadius = 4;
    normalButton.normalColor = COLOR_S5;
    normalButton.pressColor = [UIColor redColor];
    [self.view addSubview:normalButton];
    
    // 失效按钮
    TISButton *disableButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [disableButton setTitle:@"失效按钮" forState:UIControlStateNormal];
    disableButton.frame = CGRectMake(left, 100 + height + 30, width, height);
    disableButton.cornerRadius = 4;
    disableButton.enabled = NO;
    disableButton.disableColor = [UIColor lightGrayColor];
    [self.view addSubview:disableButton];
    
    // 边框按钮
    TISButton *borderButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [borderButton setTitle:@"边框按钮" forState:UIControlStateNormal];
    borderButton.frame = CGRectMake(left, 100 + (height + 30) * 2, width, height);
    borderButton.cornerRadius = 4;
    borderButton.normalColor = [UIColor lightGrayColor];
    borderButton.pressColor = [UIColor grayColor];
    [borderButton addBorderLine:[UIColor redColor] fillColor:[UIColor clearColor] lineWidth:1 borderSpace:nil cornerRadius:4 isDash:NO];
    [self.view addSubview:borderButton];
    
    // 虚线边框按钮
    TISButton *dashBorderButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [dashBorderButton setTitle:@"虚线边框按钮" forState:UIControlStateNormal];
    dashBorderButton.frame = CGRectMake(left, 100 + (height + 30) * 3, width, height);
    dashBorderButton.cornerRadius = 4;
    dashBorderButton.normalColor = [UIColor lightGrayColor];
    dashBorderButton.pressColor = [UIColor grayColor];
    [dashBorderButton addBorderLine:[UIColor redColor] fillColor:[UIColor clearColor] lineWidth:1 borderSpace:nil cornerRadius:4 isDash:YES];
    [self.view addSubview:dashBorderButton];
    
    // loading按钮
    self.loadingButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [self.loadingButton setTitle:@"loading按钮" forState:UIControlStateNormal];
    self.loadingButton.frame = CGRectMake(left, 100 + (height + 30) * 4, width, height);
    self.loadingButton.cornerRadius = 4;
    self.loadingButton.normalColor = COLOR_S5;
    self.loadingButton.pressColor = [UIColor redColor];
    [self.loadingButton addTarget:self action:@selector(loadingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loadingButton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingButton.activityIndicator startAnimating];
    });
    
    // 阴影按钮
    TISButton *shadowButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [shadowButton setTitle:@"阴影按钮" forState:UIControlStateNormal];
    [shadowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shadowButton.frame = CGRectMake(left, 100 + (height + 30) * 5, width, height);
    shadowButton.cornerRadius = 4;
    [shadowButton setSh1downShadow];
    shadowButton.normalColor = [UIColor whiteColor];
    shadowButton.pressColor = [UIColor lightGrayColor];
    [self.view addSubview:shadowButton];
    
    // 幽灵按钮
    UIView *ghostView = [[UIView alloc] initWithFrame:CGRectMake(0, 100 + (height + 30) * 6, TIS_Screen_Width, height + 20)];
    ghostView.backgroundColor = COLOR_S5;
    [self.view addSubview:ghostView];
    
    TISButton *ghostButton = [TISButton buttonWithType:UIButtonTypeCustom];
    [ghostButton setTitle:@"幽灵按钮" forState:UIControlStateNormal];
    ghostButton.frame = CGRectMake(left, 10, width, height);
    ghostButton.cornerRadius = 4;
    ghostButton.normalColor = [UIColor clearColor];
    ghostButton.pressColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [ghostButton addBorderLine:[UIColor whiteColor] fillColor:[UIColor clearColor] lineWidth:1 borderSpace:nil cornerRadius:4 isDash:NO];
    [ghostView addSubview:ghostButton];
}

/**
 *  loading按钮点击事件
 */
- (void)loadingButtonClicked {
    if (self.loadingButton.activityIndicator.animating) {
        [self.loadingButton.activityIndicator stopAnimating];
    } else {
        [self.loadingButton.activityIndicator startAnimating];
    }
}

@end
