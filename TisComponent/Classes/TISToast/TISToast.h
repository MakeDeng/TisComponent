//
//  TISToast.h
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISToast : UIView

/// 提示文本label
@property (nonatomic, strong) UILabel *toastLabel;

/// 加载中loading
@property (nonatomic, strong) UIActivityIndicatorView *loading;

/// icon
@property (nonatomic, strong) UIImageView *iconImageView;



/// 显示纯文本toast(弹出前不会清除之前已弹出的toast，会叠加显示)
/// @param view 要显示在的目标视图(文字宽度不会超过目标视图的70%，文字高度不会超过目标高度的70%)
/// @param text 要显示的文字
+ (instancetype)showToastTo:(UIView *)view text:(NSString *)text;

/// 在window上显示显示纯文本toast（弹出前会清除之前已弹出的toast） (文字宽度不会超过屏幕宽度的70%，文字高度不会超过屏幕高度的70%)
/// @param text 要显示的文字
+ (instancetype)showToast:(NSString *)text;

/// 显示加载中toast
/// @param text 加载中文字（默认文字是'加载中...'）
+ (instancetype)showLoading:(NSString *)text;

/// 显示带icon的toast
/// @param icon 提示icon
/// @param text 提示文字
+ (instancetype)showIcon:(UIImage *)icon text:(NSString *)text;



@end

NS_ASSUME_NONNULL_END
