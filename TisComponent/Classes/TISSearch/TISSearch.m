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
        _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, self.viewFrame.size.width, self.viewFrame.size.height - 10 * 2)];
        _textFiled.delegate = self;
        _textFiled.placeholder = @"搜索";
        _textFiled.returnKeyType = UIReturnKeyDone;
        _textFiled.clearButtonMode = UITextFieldViewModeAlways;
        _textFiled.layer.cornerRadius = 5;
        _textFiled.layer.masksToBounds = YES;
        _textFiled.font = [UIFont systemFontOfSize:14];
        _textFiled.backgroundColor = [[TISTool tisColorWithHex:@"#E8E8E8"] colorWithAlphaComponent:0.5];
        
        CGFloat height = _textFiled.frame.size.height;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TISCommonSrcName(@"textfiled_search")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"textfiled_search")]];
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
        self.textFiled.text = @"";
    }
    return YES;
}

@end
