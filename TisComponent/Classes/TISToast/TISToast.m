//
//  TISToast.m
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/11/14.
//

#import "TISToast.h"
#import "TISHeader.h"

@implementation TISToast

/// 显示纯文本toast(弹出前不会清除之前已弹出的toast，会叠加显示)
/// @param view 要显示在的目标视图(文字宽度不会超过目标视图的70%，文字高度不会超过屏幕高度的70%)
/// @param text 要显示的文字
+ (instancetype)showToastTo:(UIView *)view text:(NSString *)text {
    // 显示toast
    TISToast *toast = [TISToast new];
    toast.toastLabel.text = text;
    CGFloat textWidth = [TISTool tisGetLabelWidth:toast.toastLabel size:CGSizeMake(MAXFLOAT,20)];
    CGFloat textMaxWidth = view.frame.size.width * 0.7 - 20 * 2;
    if (textWidth > textMaxWidth) {
        textWidth = textMaxWidth;
    }
    CGFloat textHeight = [TISTool tisGetLabelHeight:toast.toastLabel size:CGSizeMake(textWidth, MAXFLOAT)];
    CGFloat textMaxHeight = view.frame.size.height * 0.7 - 12 * 2;
    if (textHeight > textMaxHeight) {
        textHeight = textMaxHeight;
    }
    toast.frame = CGRectMake((view.frame.size.width - textWidth - 20 * 2) / 2, (view.frame.size.height - textHeight - 12 * 2) / 2, textWidth + 20 * 2, textHeight + 12 * 2);
    [view addSubview:toast];
    
    // 2秒后移除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [toast removeFromSuperview];
    });
    return toast;
}

/// 在window上显示显示纯文本toast（弹出前会清除之前已弹出的toast） (文字宽度不会超过屏幕宽度的70%，文字高度不会超过屏幕高度的70%)
/// @param text 要显示的文字
+ (instancetype)showToast:(NSString *)text {
    // 如果有之前的toast先移除
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if ([window viewWithTag:1993]!=nil && [[window viewWithTag:1993] isKindOfClass:[TISToast class]]) {
        [[window viewWithTag:1993] removeFromSuperview];
    }
    
    // 显示toast
    TISToast *toast = [TISToast new];
    toast.toastLabel.text = text;
    CGFloat textWidth = [TISTool tisGetLabelWidth:toast.toastLabel size:CGSizeMake(MAXFLOAT,20)];
    CGFloat textMaxWidth = TIS_Screen_Width * 0.7 - 20 * 2;
    if (textWidth > textMaxWidth) {
        textWidth = textMaxWidth;
    }
    CGFloat textHeight = [TISTool tisGetLabelHeight:toast.toastLabel size:CGSizeMake(textWidth, MAXFLOAT)];
    CGFloat textMaxHeight = TIS_Screen_Height * 0.7 - 12 * 2;
    if (textHeight > textMaxHeight) {
        textHeight = textMaxHeight;
    }
    toast.frame = CGRectMake((TIS_Screen_Width - textWidth - 20 * 2) / 2, (TIS_Screen_Height - textHeight - 12 * 2) / 2, textWidth + 20 * 2, textHeight + 12 * 2);
    toast.tag = 1993;
    [window addSubview:toast];
    
    // 2秒后移除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [toast removeFromSuperview];
    });
    
    return toast;
}

/// 显示加载中toast
/// @param text 加载中文字（默认文字是'加载中...'）
+ (instancetype)showLoading:(NSString *)text {
    // 判空
    if (text==nil || [text isEqualToString:@""]) {
        text = @"";
    }
    
    // 如果有之前的toast先移除
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if ([window viewWithTag:1993]!=nil && [[window viewWithTag:1993] isKindOfClass:[TISToast class]]) {
        [[window viewWithTag:1993] removeFromSuperview];
    }
    
    // 显示toast
    TISToast *toast = [TISToast new];
    [toast addSubview:toast.loading];
    CGFloat textTop = 24 + 40 + 8;
    toast.toastLabel.frame = CGRectMake(20, textTop, 60, 24);
    toast.toastLabel.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    toast.toastLabel.text = text;
    CGFloat textWidth = [TISTool tisGetLabelWidth:toast.toastLabel size:CGSizeMake(MAXFLOAT,20)];
    CGFloat textMaxWidth = TIS_Screen_Width * 0.7 - 20 * 2;
    if (textWidth > textMaxWidth) {
        textWidth = textMaxWidth;
    }
    CGFloat textMinWidth = 128 - 20 * 2;
    if (textWidth < textMinWidth) textWidth = textMinWidth;
    CGFloat textHeight = [TISTool tisGetLabelHeight:toast.toastLabel size:CGSizeMake(textWidth, MAXFLOAT)];
    CGFloat textMaxHeight = TIS_Screen_Height * 0.7 - 24 - textTop;
    if (textHeight > textMaxHeight) {
        textHeight = textMaxHeight;
    }
    toast.frame = CGRectMake((TIS_Screen_Width - textWidth - 20 * 2) / 2, (TIS_Screen_Height - 24 - textTop) / 2, textWidth + 20 * 2, textHeight + 24 + textTop);
    toast.loading.center = CGPointMake(toast.toastLabel.center.x, toast.loading.center.y);
    toast.tag = 1993;
    [window addSubview:toast];
    
    return toast;
}

/// 显示带icon的toast
/// @param icon 提示icon
/// @param text 提示文字
+ (instancetype)showIcon:(UIImage *)icon text:(NSString *)text {
    // 判空
    if (text==nil || [text isEqualToString:@""]) {
        text = @"";
    }
    
    // 如果有之前的toast先移除
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if ([window viewWithTag:1993]!=nil && [[window viewWithTag:1993] isKindOfClass:[TISToast class]]) {
        [[window viewWithTag:1993] removeFromSuperview];
    }
    
    // 显示toast
    TISToast *toast = [TISToast new];
    toast.iconImageView.image = icon;
    [toast addSubview:toast.iconImageView];
    CGFloat textTop = 24 + 40 + 8;
    toast.toastLabel.frame = CGRectMake(20, textTop, 60, 24);
    toast.toastLabel.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toast.toastLabel.text = text;
    CGFloat textWidth = [TISTool tisGetLabelWidth:toast.toastLabel size:CGSizeMake(MAXFLOAT,20)];
    CGFloat textMaxWidth = 262 - 20 * 2;
    if (textWidth > textMaxWidth) {
        textWidth = textMaxWidth;
    }
    CGFloat textMinWidth = 128 - 20 * 2;
    if (textWidth < textMinWidth) textWidth = textMinWidth;
    CGFloat textHeight = [TISTool tisGetLabelHeight:toast.toastLabel size:CGSizeMake(textWidth, MAXFLOAT)];
    CGFloat textMaxHeight = TIS_Screen_Height * 0.7 - 24 - textTop;
    if (textHeight > textMaxHeight) {
        textHeight = textMaxHeight;
    }
    toast.frame = CGRectMake((TIS_Screen_Width - textWidth - 20 * 2) / 2, (TIS_Screen_Height - 24 - textTop) / 2, textWidth + 20 * 2, textHeight + 24 + textTop);
    toast.iconImageView.center = CGPointMake(toast.toastLabel.center.x, toast.iconImageView.center.y);
    toast.tag = 1993;
    [window addSubview:toast];
    
    // 2秒后移除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [toast removeFromSuperview];
    });
    
    return toast;
}



#pragma mark - 对象初始化
- (instancetype)init {
    if (self = [super init]) {
        [self setView];
        [self addSubview:self.toastLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
        [self addSubview:self.toastLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setView];
        [self addSubview:self.toastLabel];
    }
    return self;
}

- (void)setView {
    self.bounds = CGRectMake(0, 0, 100, 120);
    self.backgroundColor = [COLOR_M1 colorWithAlphaComponent:0.7];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}



#pragma mark - 属性初始化

- (UILabel *)toastLabel {
    if (!_toastLabel) {
        _toastLabel = [UILabel new];
        _toastLabel.textColor = [UIColor whiteColor];
        _toastLabel.font = [UIFont systemFontOfSize:16.0];
        _toastLabel.textAlignment = NSTextAlignmentCenter;
        _toastLabel.numberOfLines = 0;
        _toastLabel.frame = CGRectMake(20, 12, 60, 96);
        _toastLabel.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _toastLabel;
}

- (UIActivityIndicatorView *)loading {
    if (!_loading) {
        _loading = [[UIActivityIndicatorView alloc] init];
        _loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _loading.color = COLOR_M4;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.5, 1.5);
        _loading.transform = transform;
        _loading.frame = CGRectMake(0, 24, 40, 40);
        _loading.color = [UIColor whiteColor];
        [_loading startAnimating];
    }
    return _loading;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.frame = CGRectMake(0, 24, 40, 40);
    }
    return _iconImageView;
}



@end
