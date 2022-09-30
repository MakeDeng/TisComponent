//
//  TISInput.m
//  Pods
//
//  Created by tanikawa on 2022/6/21.
//

#import "TISInput.h"
#import "TISHeader.h"

static CGFloat horSpace = 16; // 拓展组件与输入框之间的横向间距（拓展组件为左右布局时）
static CGFloat velSpace = 8;  // 拓展组件与输入框之间的纵向间距（拓展组件为上下布局时）

@implementation TISInput

- (instancetype)init {
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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


- (void)setUpView {
    [self addSubview:self.expandView];
    [self addSubview:self.inputTextFiled];
}

- (void)setInputType:(TIS_INPUT_TYPE)inputType {
    _inputType =  inputType;
    [self layoutSubviews];
}

- (void)layoutSubviews {
    switch (self.inputType) {
        case NORMAL:
            // 普通输入框
            self.inputTextFiled.frame = CGRectMake(self.horizontalSpace, self.verticalSpace, self.frame.size.width - self.horizontalSpace * 2, self.frame.size.height - self.verticalSpace * 2);
            break;
        case HORRIZONTAL_LEFT:
            // 扩展内容在左侧输入框
            self.expandView.frame = CGRectMake(self.horizontalSpace, self.verticalSpace, self.expandView.bounds.size.width, self.frame.size.height - self.verticalSpace * 2);
            self.inputTextFiled.frame = CGRectMake(self.expandView.frame.origin.x + self.expandView.frame.size.width + horSpace, self.verticalSpace, self.frame.size.width - self.expandView.frame.origin.x - self.expandView.frame.size.width - horSpace - self.horizontalSpace, self.frame.size.height - self.verticalSpace * 2);
            break;
        case HORRIZONTAL_RIGHT:
            // 扩展内容在右侧输入框
            self.expandView.frame = CGRectMake(self.frame.size.width - self.horizontalSpace - self.expandView.bounds.size.width, self.verticalSpace, self.expandView.bounds.size.width, self.frame.size.height - self.verticalSpace * 2);
            self.inputTextFiled.frame = CGRectMake(self.horizontalSpace, self.verticalSpace, self.frame.size.width - self.expandView.frame.size.width - horSpace - self.horizontalSpace * 2, self.frame.size.height - self.verticalSpace * 2);
            break;
        case VERTICAL:
            // 扩展内容在上侧输入框
            self.expandView.frame = CGRectMake(self.horizontalSpace, self.verticalSpace, self.frame.size.width - self.horizontalSpace * 2, self.expandView.bounds.size.height);
            self.inputTextFiled.frame = CGRectMake(self.horizontalSpace, self.expandView.bounds.size.height + velSpace + self.verticalSpace, self.frame.size.width - self.horizontalSpace * 2, self.frame.size.height - self.verticalSpace * 2 - self.expandView.bounds.size.height - velSpace);
            break;
        default:
            // 普通输入框
            self.inputTextFiled.frame = CGRectMake(self.horizontalSpace, self.verticalSpace, self.frame.size.width - self.horizontalSpace * 2, self.frame.size.height - self.verticalSpace * 2);
            break;
    }
}

- (void)setClearEnable:(BOOL)clearEnable {
    _clearEnable = clearEnable;
    if (clearEnable) {
        self.inputTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    } else {
        self.inputTextFiled.clearButtonMode = UITextFieldViewModeNever;
    }
}



#pragma mark - 初始化
- (UIView *)expandView {
    if (!_expandView) {
        _expandView = [[UIView alloc] init];
    }
    return _expandView;
}

- (UITextField *)inputTextFiled {
    if (!_inputTextFiled) {
        _inputTextFiled = [[UITextField alloc] init];
        _inputTextFiled.delegate = self;
        _inputTextFiled.textColor = COLOR_M2;
        _inputTextFiled.font = [UIFont systemFontOfSize:16];
    }
    return _inputTextFiled;
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

@end
