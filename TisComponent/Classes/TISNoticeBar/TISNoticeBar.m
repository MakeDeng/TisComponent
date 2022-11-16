//
//  TISNoticeBar.m
//  Pods
//
//  Created by tanikawa on 2022/11/15.
//

#import "TISNoticeBar.h"
#import "TISHeader.h"

@implementation TISNoticeBar

/// 显示通知栏
/// @param icon 通知栏左侧icon图标
/// @param text 通知栏文字
/// @param doView 通知栏右侧自定义视图（可传空）
+ (instancetype)showNoticeBar:(UIImageView *)icon text:(NSString *)text doView:(UIView *)doView {
    TISNoticeBar *noticeBar = [TISNoticeBar new];
    
    
    return noticeBar;
}



#pragma mark - 对象初始化
- (instancetype)init {
    if (self = [super init]) {
        [self setView];
        [self addSubview:self.noticeView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
        [self addSubview:self.noticeView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setView];
        [self addSubview:self.noticeView];
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

- (UIView *)noticeView {
    if (!_noticeView) {
        _noticeView = [UIView new];
    }
    return _noticeView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UIScrollView *)textScrollView {
    if (!_textScrollView) {
        _textScrollView = [UIScrollView new];
    }
    return _textScrollView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
    }
    return _textLabel;
}

- (UIView *)doView {
    if (!_doView) {
        _doView = [UIView new];
    }
    return _doView;
}



@end
