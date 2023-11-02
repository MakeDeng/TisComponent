//
//  TISResetChoose.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISResetChoose.h"
#import "TISHeader.h"

@implementation TISResetChoose

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.viewFrame = frame;
        [self addSubview:self.resetButton];
        [self addSubview:self.sureButton];
    }
    return self;
}



#pragma mark - set

- (void)setChooseNumber:(NSInteger)chooseNumber {
    _chooseNumber = chooseNumber;
    NSString *numStr = @"确定";
    if (chooseNumber > 0) {
        numStr = [NSString stringWithFormat:@"确定·%ld", (long)chooseNumber];
    }
    [self.sureButton setTitle:numStr forState:UIControlStateNormal];
}



#pragma mark - 懒加载

- (TISButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [TISButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:COLOR_M1 forState:UIControlStateNormal];
        CGFloat width = (self.viewFrame.size.width - 16 * 2 - 10) / 5 *2;
        CGFloat height = self.viewFrame.size.height - 16 * 2;
        _resetButton.frame = CGRectMake(16, 12, width, height);
        _resetButton.cornerRadius = 4;
        _resetButton.normalColor = COLOR_M10;
        _resetButton.pressColor = COLOR_M8;
        [_resetButton addBorderLine:COLOR_M7 fillColor:[UIColor clearColor] lineWidth:1 borderSpace:nil cornerRadius:4 isDash:NO];
        [_resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (TISButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [TISButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        CGFloat resetWidth = (self.viewFrame.size.width - 16 * 2 - 10) / 5 *2;
        CGFloat width = (self.viewFrame.size.width - 16 * 2 - 10) / 5 * 3;
        CGFloat height = self.viewFrame.size.height - 16 * 2;
        _sureButton.frame = CGRectMake(16 + 10 + resetWidth, 12, width, height);
        _sureButton.cornerRadius = 4;
        _sureButton.normalColor = COLOR_S5;
        _sureButton.pressColor = COLOR_S6;
        [_sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}



#pragma mark - 方法

/**
 *  重置按钮点击事件
 */
- (void)resetButtonClicked {
    self.resetClicked();
}

/**
 *  确定按钮点击事件
 */
- (void)sureButtonClicked {
    self.sureClicked();
}


@end
