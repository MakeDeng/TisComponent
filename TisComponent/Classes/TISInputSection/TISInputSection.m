//
//  TISInputSection.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/3/2.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISInputSection.h"
#import "TISHeader.h"

@implementation TISInputSection

#pragma mark - 初始化

- (instancetype)init {
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.viewFrame = frame;
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setUpView];
    }
    return self;
}

- (void)layoutSubviews {
    self.viewFrame = self.frame;
}



#pragma mark - 设置视图

- (void)setUpView {
    self.pointNumber = 2;
    [self addSubview:self.separateView];
    self.minTextFiled.returnKeyType = UIReturnKeyDone;
    self.minTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.minTextFiled];
    self.maxTextFiled.returnKeyType = UIReturnKeyDone;
    self.maxTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.maxTextFiled];
}



#pragma mark - 懒加载

- (UIView *)separateView {
    if (!_separateView) {
        CGFloat width = 16 + self.space * 2;
        _separateView = [[UIView alloc] initWithFrame:CGRectMake((self.viewFrame.size.width - width) / 2, 0, width, self.viewFrame.size.height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.space, 0, (_separateView.frame.size.width - self.space * 2), _separateView.frame.size.height)];
        label.text = @"~";
        label.textColor = COLOR_M2;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        [_separateView addSubview:label];
    }
    return _separateView;
}

- (UITextField *)minTextFiled {
    if (!_minTextFiled) {
        _minTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(self.horizontalSpace, self.verticalSpace, (self.viewFrame.size.width - self.separateView.frame.size.width - self.horizontalSpace * 2) / 2, self.viewFrame.size.height - self.verticalSpace * 2)];
        _minTextFiled.delegate = self;
        _minTextFiled.placeholder = @"数字范围";
        _minTextFiled.returnKeyType = UIReturnKeyDone;
        _minTextFiled.clearButtonMode = UITextFieldViewModeAlways;
        _minTextFiled.layer.cornerRadius = 5;
        _minTextFiled.layer.masksToBounds = YES;
        _minTextFiled.font = [UIFont systemFontOfSize:16];
        
        CGFloat height = _minTextFiled.frame.size.height;
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, height)];
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, height)];
        unitLabel.text = @"m²";
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont systemFontOfSize:16];
        [rightView addSubview:unitLabel];
        
        _minTextFiled.rightView = rightView;
        _minTextFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    return _minTextFiled;
}

- (UITextField *)maxTextFiled {
    if (!_maxTextFiled) {
        _maxTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(self.horizontalSpace + self.minTextFiled.frame.size.width + self.separateView.frame.size.width , self.verticalSpace, (self.viewFrame.size.width - self.separateView.frame.size.width - self.horizontalSpace * 2) / 2, self.viewFrame.size.height - self.verticalSpace * 2)];
        _maxTextFiled.delegate = self;
        _maxTextFiled.placeholder = @"数字范围";
        _maxTextFiled.returnKeyType = UIReturnKeyDone;
        _maxTextFiled.clearButtonMode = UITextFieldViewModeAlways;
        _maxTextFiled.layer.cornerRadius = 5;
        _maxTextFiled.layer.masksToBounds = YES;
        _maxTextFiled.font = [UIFont systemFontOfSize:16];
        
        CGFloat height = _maxTextFiled.frame.size.height;
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, height)];
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, height)];
        unitLabel.text = @"m²";
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont systemFontOfSize:16];
        [rightView addSubview:unitLabel];
        
        _maxTextFiled.rightView = rightView;
        _maxTextFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    return _maxTextFiled;
}

- (CGFloat)horizontalSpace {
    if (_horizontalSpace == 0) {
        _horizontalSpace = 20;
    }
    return _horizontalSpace;
}

- (CGFloat)verticalSpace {
    if (_verticalSpace == 0) {
        _verticalSpace = 18;
    }
    return _verticalSpace;
}

- (CGFloat)space {
    if (_space == 0) {
        _space = 12;
    }
    return _space;
}



#pragma mark - UITextFiled 代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.minTextFiled resignFirstResponder];
    [self.maxTextFiled resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSString *textStr = [NSString stringWithFormat:@"%@%@", textField.text, string];
    NSArray *array = [textStr componentsSeparatedByString:@"."];
    if (array.count >= 2) {
        NSString *pointAfter = array[1];
        if (pointAfter.length > self.pointNumber) {
            return NO;
        }
    }
    return YES;
}

@end
