//
//  TISTextArea.h
//  TisComponent
//
//  Created by tanikawa on 2022/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISTextArea : UIView <UITextViewDelegate>

/// 输入控件左右间距（默认16）
@property (nonatomic, assign) CGFloat textAreaSpace;

/// 是否显示计数器
@property (nonatomic, assign) BOOL showNumber;

/// 限制输入的总字数
@property (nonatomic, assign) int limitCount;

/// 已输入的总字数
@property (nonatomic, assign) int inputCount;

/// 是否是禁用状态
@property (nonatomic, assign) BOOL disable;

/// 输入文字颜色
@property (nonatomic, strong) UIColor *inputColor;

/// 占位文字
@property (nonatomic, copy) NSString *placeholder;

/// 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;

/// 标题文字
@property (nonatomic, copy) NSString *title;

/// 标题label高度（默认15）
@property (nonatomic, assign) CGFloat titleLabelHeight;

/// 默认显示的文字
@property (nonatomic, copy) NSString *defaultText;

@end

NS_ASSUME_NONNULL_END
