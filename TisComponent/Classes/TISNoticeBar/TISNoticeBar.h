//
//  TISNoticeBar.h
//  Pods
//
//  Created by tanikawa on 2022/11/15.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NOTICE_BAR_TYPE) {
    NOTICE_BAR_NORMAL,          // 默认普通消息
    NOTICE_BAR_ALERT_YELLOW,    // 黄色提醒消息
    NOTICE_BAR_ALERT_RED,       // 红色提醒消息
    NOTICE_BAR_NOTICE,          // 通知公告消息
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

/// 滚动定时器
@property (nonatomic, strong) NSTimer *textTimer;

/// 定时器滚动的占位宽度
@property (nonatomic, assign) CGFloat spaceWidth;

/// 右侧配置按钮时
@property (nonatomic, copy) void (^noticeBarRightBlock)(void);



/// 设置通知栏视图
/// @param icon 通知栏左侧icon图标（可传入NSString或者UIImage，NSString类型支持”alert：警告类型“和”notice：通知公告类型“）
/// @param type 通知类型
/// @param text 通知栏文字
/// @param doView 通知栏右侧自定义视图（可传空，可传入NSString或者自定义的UIView视图，NSString类型支持”close：关闭按钮“和”text：查看详情按钮“和”arrow：右箭头“）
/// @param moreLine 文字超长时是否折行显示
- (instancetype)showNoticeBarWithIcon:(id)icon type:(NOTICE_BAR_TYPE)type text:(NSString *)text doView:(nullable id)doView moreLine:(BOOL)moreLine;

@end

NS_ASSUME_NONNULL_END
