//
//  TISNoticeBar.h
//  Pods
//
//  Created by tanikawa on 2022/11/15.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NOTICE_BAR_TYPE) {
    NOTICE_BAR_NORMAL,    // 默认toast(纯文本)
    NOTICE_BAR_LOADING,   // 加载中toast
    NOTICE_BAR_ICON,      // 带icon的toast
};

NS_ASSUME_NONNULL_BEGIN

@interface TISNoticeBar : UIView

/// 通知栏视图
@property (nonatomic, strong) UIView *noticeView;

/// icon图标
@property (nonatomic, strong) UIImageView *iconImageView;

/// 文字背景滚动视图
@property (nonatomic, strong) UIScrollView *textScrollView;

/// 通知栏文字label
@property (nonatomic, strong) UILabel *textLabel;

/// 右侧操作视图
@property (nonatomic, strong) UIView *doView;



/// 显示通知栏
/// @param icon 通知栏左侧icon图标
/// @param text 通知栏文字
/// @param doView 通知栏右侧自定义视图（可传空）
+ (instancetype)showNoticeBar:(UIImageView *)icon text:(NSString *)text doView:(UIView *)doView;

@end

NS_ASSUME_NONNULL_END
