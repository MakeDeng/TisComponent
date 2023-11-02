//
//  TISInput.h
//  Pods
//
//  Created by tanikawa on 2022/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TIS_INPUT_TYPE) {
    NORMAL_INPUT,              // 普通输入框
    HORRIZONTAL_LEFT,    // 扩展内容在左侧输入框
    HORRIZONTAL_RIGHT,   // 扩展内容在右侧输入框
    VERTICAL,            // 扩展内容在上侧输入框
};

@interface TISInput : UIView <UITextFieldDelegate>

@property (nonatomic, assign) CGFloat horizontalSpace; // 输入框横向边界间距
@property (nonatomic, assign) CGFloat verticalSpace; // 输入框纵向边界间距
@property (nonatomic, strong) UIView *expandView; /// 拓展内容视图(水平排列必须设置expandView的bounds的宽度，纵向排列必须设置expandView的bounds的高度)
@property (nonatomic, assign) TIS_INPUT_TYPE inputType; // 输入框类型
@property (nonatomic, strong) UITextField *inputTextFiled; // 输入框
@property (nonatomic, assign) BOOL clearEnable; // 是否有清除按钮

@end

NS_ASSUME_NONNULL_END
