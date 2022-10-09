//
//  TISTextArea.m
//  TisComponent
//
//  Created by tanikawa on 2022/5/19.
//

#import "TISTextArea.h"
#import "TISHeader.h"

CGFloat topSpace = 16; // 顶部和底部间距

@interface TISTextArea()

{
    CGFloat numberHeight; // 计数器的高度
    CGFloat numberTop; // 计数器距离输入框的距离
    CGFloat titleBottom; // 标题与输入框之间的距离
    CGFloat SetTitleLabelHeight; // 设置的标题label高度
}

@property (nonatomic, assign) BOOL isCreatUI; // 是否已经创建过视图了
@property (nonatomic, strong) UITextView *textArea; // 多行输入控件
@property (nonatomic, strong) UILabel *numberLabel; // 计数label
@property (nonatomic, strong) UILabel *titleLabel; // 标题label

@end

@implementation TISTextArea

@synthesize textAreaSpace = _textAreaSpace;
@synthesize inputColor = _inputColor;
@synthesize placeholder = _placeholder;
@synthesize placeholderColor = _placeholderColor;
@synthesize title = _title;

#pragma mark - 初始化

- (instancetype)init {
    self = [super init];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    return self;
}

- (void)layoutSubviews {
    if (self.isCreatUI == NO) {
        [self creatUI];
    }
    self.isCreatUI = YES;
}

- (UITextView *)textArea {
    if (!_textArea) {
        _textArea = [[UITextView alloc]init];
        _textArea.frame = CGRectMake(self.textAreaSpace, topSpace + self.titleLabelHeight + titleBottom, self.frame.size.width - self.textAreaSpace * 2, self.frame.size.height - topSpace * 2 - self.titleLabelHeight - titleBottom - numberHeight - numberTop);
        _textArea.delegate = self;
        _textArea.text = self.placeholder;
        _textArea.textColor = self.placeholderColor;
//        _textArea.backgroundColor = [UIColor redColor];
        [self setSubCountentView];
    }
    return _textArea;
}

- (CGFloat)textAreaSpace {
    if (_textAreaSpace == 0) {
        return 16;
    }
    return _textAreaSpace;
}

/**
 *  设置输入控件顶部间距（顶部和左边间距太大）
 */
- (void)setSubCountentView {
    for (UIView *view in self.textArea.subviews) {
        if ([NSStringFromClass(view.class) isEqualToString:@"_UITextContainerView"]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 9, view.frame.size.width, view.frame.size.height);
            NSTextContainer *container = [view valueForKey:@"textContainer"];
            container.lineFragmentPadding = 0;
        }
    }
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.frame = CGRectMake(self.textArea.frame.origin.x, self.frame.size.height - topSpace - numberHeight, self.textArea.frame.size.width, numberHeight);
        _numberLabel.text = [NSString stringWithFormat:@"%d/%d",self.inputCount , self.limitCount];
        _numberLabel.textColor = COLOR_M5;
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.hidden = YES;
        _numberLabel.textAlignment = NSTextAlignmentRight;
//        _numberLabel.backgroundColor = [UIColor blueColor];
    }
    return _numberLabel;
}

- (UIColor *)inputColor {
    if (!_inputColor) {
        _inputColor = COLOR_M2;
    }
    return _inputColor;
}

- (NSString *)placeholder {
    if (!_placeholder) {
        _placeholder = @"请输入";
    }
    return _placeholder;
}

- (UIColor *)placeholderColor {
    if (!_placeholderColor) {
        _placeholderColor = COLOR_M5;
    }
    return _placeholderColor;
}

- (NSString *)title {
    if (!_title) {
        _title = @"";
    }
    return _title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(self.textArea.frame.origin.x, topSpace, self.textArea.frame.size.width, self.titleLabelHeight);
        _titleLabel.text = self.title;
        _titleLabel.textColor = COLOR_M2;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.hidden = YES;
//        _titleLabel.backgroundColor = [UIColor orangeColor];
    }
    return _titleLabel;
}



#pragma mark - 代理方法

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeholder]) {
        [self setTextViewCursorIndex];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.inputCount = (int) textView.text.length;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![textView.textColor isEqual:self.inputColor]) {
        textView.textColor = self.inputColor;
    }
    if ([text isEqualToString:@""]) {
        if ([textView.text isEqualToString:@""] || [textView.text isEqualToString:self.placeholder] || textView.text.length==1) {
            textView.text = self.placeholder;
            textView.textColor = self.placeholderColor;
            [self setTextViewCursorIndex];
            self.inputCount = 0;
            return NO;
        }
        return YES;
    } else {
        NSString *totalStr = [NSString stringWithFormat:@"%@%@", textView.text, text];
        if ([textView.text isEqualToString:self.placeholder]) {
            textView.text = @"";
        }
        if (totalStr.length > self.limitCount) {
            return NO;
        }
    }
    return YES;
}



#pragma mark - 方法

/**
 *  创建视图
 */
- (void)creatUI {
    [self addSubview:self.textArea];
    [self addSubview:self.numberLabel];
    [self addSubview:self.titleLabel];
}

/**
 *  设置左右边距
 */
- (void)setTextAreaSpace:(CGFloat)textAreaSpace {
    _textAreaSpace = textAreaSpace;
    [self updateSubFrame];
}

/**
 *  设置是否显示计数器
 */
- (void)setShowNumber:(BOOL)showNumber {
    _showNumber = showNumber;
    if (showNumber) {
        // 显示计数器
        numberHeight = 20;
        numberTop = 4;
        [self updateSubFrame];
        self.numberLabel.hidden = NO;
    } else {
        // 不显示计数器
        numberHeight = 0;
        numberTop = 0;
        [self updateSubFrame];
        self.numberLabel.hidden = YES;
    }
}

/**
 *  设置限制输入总字数
 */
- (void)setLimitCount:(int)limitCount {
    _limitCount = limitCount;
    self.numberLabel.text = [NSString stringWithFormat:@"%d/%d",self.inputCount , self.limitCount];
}

/**
 *  设置已输入总字数
 */
- (void)setInputCount:(int)inputCount {
    _inputCount = inputCount;
    self.numberLabel.text = [NSString stringWithFormat:@"%d/%d",self.inputCount , self.limitCount];
    NSString *inputStr = [NSString stringWithFormat:@"%d", self.inputCount];
    if (self.inputCount == 0) {
        [TISTool tisSetString:self.numberLabel.text someStr:inputStr theLable:self.numberLabel theColor:COLOR_M5];
    } else {
        [TISTool tisSetString:self.numberLabel.text someStr:inputStr theLable:self.numberLabel theColor:self.inputColor];
    }
}

/**
 *  设置已输入总字数
 */
- (void)setDisable:(BOOL)disable {
    _disable = disable;
    if (disable) {
        // 禁用状态
        self.textArea.editable = NO;
        self.textArea.textColor = COLOR_M5;
        self.showNumber = NO;
    } else {
        // 非禁用状态
        self.textArea.editable = YES;
        self.textArea.textColor = self.inputColor;
    }
}

/**
 *  设置输入颜色
 */
- (void)setInputColor:(UIColor *)inputColor {
    _inputColor = inputColor;
    self.textArea.textColor = inputColor;
}

/**
 *  设置占位文字
 */
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textArea.text = placeholder;
}

/**
 *  设置占位文字颜色
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    if ([self.textArea.text isEqualToString:self.placeholder]) {
        self.textArea.textColor = placeholderColor;
    }
}

/**
 *  设置标题文字
 */
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    if (title!=nil && ![title isEqualToString:@""]) {
        self.titleLabelHeight = SetTitleLabelHeight==0 ? 15 : SetTitleLabelHeight;
        titleBottom = 8;
        self.titleLabel.hidden = NO;
    } else {
        self.titleLabelHeight = 0;
        titleBottom = 0;
        self.titleLabel.hidden = YES;
    }
}

/**
 *  标题label高度（默认15）
 */
- (void)setTitleLabelHeight:(CGFloat)titleLabelHeight {
    _titleLabelHeight = titleLabelHeight;
    SetTitleLabelHeight = titleLabelHeight;
    [self updateSubFrame];
}

/**
 *  默认显示的文字
 */
- (void)setDefaultText:(NSString *)defaultText {
    _defaultText = defaultText;
    if (self.limitCount>0 && defaultText.length>self.limitCount) {
        self.inputCount = (int) self.limitCount;
        self.textArea.text = [defaultText substringToIndex:self.limitCount];
        self.textArea.textColor = self.inputColor;
    } else {
        self.inputCount = (int) defaultText.length;
        self.textArea.text = defaultText;
        self.textArea.textColor = self.inputColor;
    }
}

/**
 *  设置输入框光标到最开始位置
 */
- (void)setTextViewCursorIndex {
    NSInteger currentOffset = -self.placeholder.length;
    UITextPosition *newPos = [self.textArea positionFromPosition:self.textArea.endOfDocument offset:currentOffset];
    self.textArea.selectedTextRange = [self.textArea textRangeFromPosition:newPos toPosition:newPos];
}

/**
 *  更新组件位置
 */
- (void)updateSubFrame {
    self.textArea.frame = CGRectMake(self.textAreaSpace, topSpace + self.titleLabelHeight + titleBottom, self.frame.size.width - self.textAreaSpace * 2, self.frame.size.height - topSpace * 2 - self.titleLabelHeight - titleBottom - numberHeight - numberTop);
    self.numberLabel.frame = CGRectMake(self.textArea.frame.origin.x, self.frame.size.height - topSpace - numberHeight, self.textArea.frame.size.width, numberHeight);
    self.titleLabel.frame = CGRectMake(self.textArea.frame.origin.x, topSpace, self.textArea.frame.size.width, self.titleLabelHeight);
}



/**
 *  取消输入框的第一响应事件
 */
- (void)cancelFirstResponder {
    [self.textArea resignFirstResponder];
}



@end
