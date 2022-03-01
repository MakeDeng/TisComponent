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



#pragma mark - 懒加载

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CGFloat width = (self.viewFrame.size.width - 16 * 3) / 2;
        CGFloat height = self.viewFrame.size.height - 12 * 2;
        _resetButton.frame = CGRectMake(16, 12, width, height);
        _resetButton.layer.cornerRadius = 5;
        _resetButton.layer.masksToBounds = YES;
        _resetButton.layer.borderColor = [TISTool tisColorWithHex:@"#e8e8e8"].CGColor;
        _resetButton.layer.borderWidth = 0.5;
        [_resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        CGFloat width = (self.viewFrame.size.width - 16 * 3) / 2;
        CGFloat height = self.viewFrame.size.height - 12 * 2;
        _sureButton.frame = CGRectMake(16 * 2 + width, 12, width, height);
        _sureButton.layer.cornerRadius = 5;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.backgroundColor = [TISTool tisColorWithHex:@"#1f6cdd"];
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
