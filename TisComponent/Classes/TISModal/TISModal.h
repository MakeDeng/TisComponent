//
//  TISModal.h
//  TisComponent
//
//  Created by tanikawa on 2023/1/17.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MODAL_TYPE) {
    MODAL_POINT,     // 默认对话框
    MODAL_TITLE,     // 只有标题的对话框
    MODAL_NO_TITLE,  // 没有标题的对话框
};

NS_ASSUME_NONNULL_BEGIN

@interface TISModal : UIView

/// 背景按钮
@property (nonatomic, strong) UIButton *bgButton;

/// 内容视图
@property (nonatomic, strong) UIView *contentView;

/// 标题label
@property (nonatomic, strong) UILabel *titleLabel;

/// 内容label
@property (nonatomic, strong) UILabel *contentLabel;

/// 操作按钮视图
@property (nonatomic, strong) UIView *doView;

/// 对话框当前是否显示
@property (nonatomic, assign) BOOL isShow;

- (void)showModalWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)array;

/// 显示对话框
- (void)showModal;

/// 隐藏对话框
- (void)hiddenModal;

@end

NS_ASSUME_NONNULL_END
