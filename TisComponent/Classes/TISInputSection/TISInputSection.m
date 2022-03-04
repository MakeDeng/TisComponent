//
//  TISInputSection.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/3/2.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISInputSection.h"

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
    self.minTextFiled.returnKeyType = UIReturnKeyDone;
    self.minTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.minTextFiled];
    self.maxTextFiled.returnKeyType = UIReturnKeyDone;
    self.maxTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.maxTextFiled];
}



#pragma mark - 懒加载

- (UITextField *)minTextFiled {
    if (!_minTextFiled) {
        _minTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, self.viewFrame.size.width / 2 + 10, self.viewFrame.size.height - 10 * 2)];
        _minTextFiled.delegate = self;
        _minTextFiled.placeholder = @"搜索";
        _minTextFiled.returnKeyType = UIReturnKeyDone;
        _minTextFiled.clearButtonMode = UITextFieldViewModeAlways;
        _minTextFiled.layer.cornerRadius = 5;
        _minTextFiled.layer.masksToBounds = YES;
        _minTextFiled.font = [UIFont systemFontOfSize:14];
        
        CGFloat height = _minTextFiled.frame.size.height;
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, height)];
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, height)];
        unitLabel.text = @"m²";
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont systemFontOfSize:14];
        [rightView addSubview:unitLabel];
        
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, height)];
        sectionLabel.text = @"~";
        sectionLabel.textAlignment = NSTextAlignmentCenter;
        sectionLabel.font = [UIFont systemFontOfSize:14];
        [rightView addSubview:sectionLabel];
        
        _minTextFiled.rightView = rightView;
        _minTextFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    return _minTextFiled;
}

- (UITextField *)maxTextFiled {
    if (!_maxTextFiled) {
        _maxTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(self.viewFrame.size.width / 2 + 20, 10, self.viewFrame.size.width / 2 - 20, self.viewFrame.size.height - 10 * 2)];
        _maxTextFiled.delegate = self;
        _maxTextFiled.placeholder = @"搜索";
        _maxTextFiled.returnKeyType = UIReturnKeyDone;
        _maxTextFiled.clearButtonMode = UITextFieldViewModeAlways;
        _maxTextFiled.layer.cornerRadius = 5;
        _maxTextFiled.layer.masksToBounds = YES;
        _maxTextFiled.font = [UIFont systemFontOfSize:14];
        
        CGFloat height = _maxTextFiled.frame.size.height;
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, height)];
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, height)];
        unitLabel.text = @"m²";
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont systemFontOfSize:14];
        [rightView addSubview:unitLabel];
        
        _maxTextFiled.rightView = rightView;
        _maxTextFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    return _maxTextFiled;
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
