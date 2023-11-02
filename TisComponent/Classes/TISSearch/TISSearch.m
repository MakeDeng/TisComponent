//
//  TISSearch.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISSearch.h"
#import "TISHeader.h"

@implementation TISSearch

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.viewFrame = frame;
        [self addSubview:self.textFiled];
    }
    return self;
}



#pragma mark - 懒加载

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 8, self.viewFrame.size.width, self.viewFrame.size.height - 8 * 2)];
        _textFiled.delegate = self;
        _textFiled.returnKeyType = UIReturnKeyDone;
        _textFiled.clearButtonMode = UITextFieldViewModeAlways;
        _textFiled.layer.cornerRadius = 5;
        _textFiled.layer.masksToBounds = YES;
        _textFiled.font = [UIFont systemFontOfSize:14];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName: COLOR_M4, NSFontAttributeName: _textFiled.font}];
        _textFiled.attributedPlaceholder = attrString;
        _textFiled.textColor = COLOR_M1;
        _textFiled.backgroundColor = COLOR_M9;
        [_textFiled addTarget:self action:@selector(textFiledTextChange:) forControlEvents:UIControlEventEditingChanged];
        
        CGFloat height = _textFiled.frame.size.height;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TISCommonSrcName(@"tis_textfiled_search")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_textfiled_search")]];
        imageView.frame = CGRectMake(height / 4, height / 4, height / 2, height / 2);
        [leftView addSubview:imageView];
        _textFiled.leftView = leftView;
        _textFiled.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textFiled;
}



#pragma mark - UITextFiled 代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textFiled resignFirstResponder];
    if (![textField.text isEqualToString:@""]) {
        self.goSearch(textField.text);
    }
    return YES;
}

// 搜索框清空按钮点击代理事件
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

// 禁止输入空格
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *blank = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if(![string isEqualToString:blank]) {
        return NO;
    }
    return YES;
}

// 输入框文字变化事件
- (void)textFiledTextChange:(UITextField *)textField {
    // 去除首尾空格
    NSString *textSearchStr = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![textSearchStr isEqualToString:@""]) {
        if (![textField.text isEqualToString:@""]) {
            self.goSearch(textField.text);
        }
    } else {
        // 清空
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    NSLog(@"聚焦了");
    if (self.watchFocus) {
        self.becomeFirst();
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"失焦了");
    if (self.watchFocus) {
        self.registerInput();
    }
}

@end
