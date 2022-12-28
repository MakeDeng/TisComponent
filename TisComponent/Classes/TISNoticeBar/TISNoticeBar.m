//
//  TISNoticeBar.m
//  Pods
//
//  Created by tanikawa on 2022/11/15.
//

#import "TISNoticeBar.h"
#import "TISHeader.h"

@implementation TISNoticeBar

#pragma mark - 对象初始化
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}

/// 设置通知栏视图
/// @param icon 通知栏左侧icon图标（可传入NSString或者UIImage，NSString类型支持”alert：警告类型“和”notice：通知公告类型“）
/// @param type 通知类型
/// @param text 通知栏文字
/// @param doView 通知栏右侧自定义视图（可传空，可传入NSString或者自定义的UIView视图，NSString类型支持”close：关闭按钮“和”text：查看详情按钮“和”arrow：右箭头“）
/// @param moreLine 文字超长时是否折行显示
- (instancetype)showNoticeBarWithIcon:(id)icon type:(NOTICE_BAR_TYPE)type text:(NSString *)text doView:(nullable id)doView moreLine:(BOOL)moreLine {
    CGFloat width = self.frame.size.width;
    self.noticeView.frame = CGRectMake(0, 0, width, 38);
    [self addSubview:self.noticeView];
    if (type == NOTICE_BAR_NORMAL) {
        // 默认普通消息
        self.noticeView.backgroundColor = COLOR_S1;
        self.textLabel.textColor = COLOR_S5;
    } else if (type == NOTICE_BAR_ALERT_YELLOW) {
        // 黄色提醒消息
        self.noticeView.backgroundColor = COLOR_ORANGE_1;
        self.textLabel.textColor = COLOR_ORANGE_5;
    } else if (type == NOTICE_BAR_ALERT_RED) {
        // 红色提醒消息
        self.noticeView.backgroundColor = COLOR_RED_1;
        self.textLabel.textColor = COLOR_RED_5;
    } else if (type == NOTICE_BAR_NOTICE) {
        // 通知公告消息
        self.noticeView.backgroundColor = COLOR_ORANGE_1;
        self.textLabel.textColor = COLOR_ORANGE_5;
    }
    
    // 设置图标
    self.iconImageView.frame = CGRectMake(16, 12, 14, 14);
    if ([icon isKindOfClass:[NSString class]]) {
        if ([icon isEqualToString:@"alert"]) {
//            self.iconImageView.image = [UIImage imageNamed:@""];
        } else if ([icon isEqualToString:@"notice"]) {
//            self.iconImageView.image = [UIImage imageNamed:@""];
        }
    } else if ([icon isKindOfClass:[UIImage class]]) {
        self.iconImageView.image = icon;
    }
    [self.noticeView addSubview:self.iconImageView];
    
    // 设置右侧操作视图
    CGFloat right = 16;
    if (doView != nil) {
        if ([doView isKindOfClass:[NSString class]]) {
            UIButton *doButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if ([doView isEqualToString:@"close"]) {
//                [doButton setImage:[UIImage imageNamed:@"notice_bar_close"] forState:UIControlStateNormal];
                [doButton setImage:[UIImage imageNamed:TISCommonSrcName(@"button_close")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"button_close")] forState:UIControlStateNormal];
                doButton.frame = CGRectMake(width - 16 - 16, 11, 16, 16);
                right += 16 + 16;
            } else if ([doView isEqualToString:@"text"]) {
                [doButton setTitle:@"查看详情" forState:UIControlStateNormal];
                [doButton setTitleColor:COLOR_S5 forState:UIControlStateNormal];
                doButton.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
                doButton.frame = CGRectMake(width - 60 - 16, 8, 60, 22);
                right += 60 + 16;
            } else if ([doView isEqualToString:@"arrow"]) {
//                [doButton setImage:[UIImage imageNamed:@"notice_bar_arrow"] forState:UIControlStateNormal];
                [doButton setImage:[UIImage imageNamed:TISCommonSrcName(@"selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"selected")] forState:UIControlStateNormal];
                doButton.frame = CGRectMake(width - 16 - 16, 11, 16, 16);
                right += 16 + 16;
            }
            [doButton addTarget:self action:@selector(doButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.noticeView addSubview:doButton];
        } else if ([doView isKindOfClass:[UIView class]]) {
            UIView *theView = (UIView *)doView;
            theView.frame = CGRectMake(width - theView.frame.size.width - 16, 0, theView.frame.size.width, 38);
            [self.noticeView addSubview:theView];
            right = 16 + 16;
        }
    }
    
    // 设置文字
    self.textLabel.text = text;
    CGFloat left = 16 + 16 + 8;
    CGFloat scrollWidth = width - left - right;
    if (moreLine) {
        // 需要折行显示时最多显示三行
        self.textLabel.numberOfLines = 0;
        [TISTool tisSetLineHeight:self.textLabel lineHeight:22];
        CGFloat textHeight= [TISTool tisGetLabelHeight:self.textLabel size:CGSizeMake(width - left - right, MAXFLOAT)];
        CGFloat bgHeight = textHeight + 8 * 2;
        if (bgHeight > 82) {
            bgHeight = 82;
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, bgHeight);
        self.noticeView.frame = CGRectMake(0, 0, width, bgHeight);
        self.textScrollView.frame = CGRectMake(left, 8, scrollWidth, bgHeight - 8 * 2);
        self.textScrollView.contentSize = CGSizeMake(scrollWidth, textHeight);
        self.textLabel.frame = CGRectMake(0, 0, scrollWidth, textHeight);
        [self.textScrollView addSubview:self.textLabel];
    } else {
        CGFloat textWidth = [TISTool tisGetLabelWidth:self.textLabel size:CGSizeMake(MAXFLOAT, 22)];
        self.textScrollView.frame = CGRectMake(left, 8, scrollWidth, 22);
        CGFloat contentWidth = textWidth + scrollWidth;
        self.textScrollView.contentSize = CGSizeMake(contentWidth, 22);
        self.textScrollView.scrollEnabled = NO;
        self.textLabel.frame = CGRectMake(0, 0, textWidth, 22);
        [self.textScrollView addSubview:self.textLabel];
        [self.textTimer fire];
        self.spaceWidth = scrollWidth;
    }
    [self.noticeView addSubview:self.textScrollView];
    
    return self;
}

// 右侧操作按钮点击事件
- (void)doButtonClicked {
    self.noticeBarRightBlock();
}

// 定时器执行方法
- (void)doTimerMethod {
    CGFloat scrollX = self.textScrollView.contentOffset.x;
    if (scrollX < self.textScrollView.contentSize.width-self.spaceWidth) {
        self.textScrollView.contentOffset = CGPointMake(scrollX + 0.5, 0);
    } else {
        self.textScrollView.contentOffset = CGPointMake(-self.spaceWidth, 0);
    }
}

- (void)dealloc {
    [self.textTimer invalidate];
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
        _iconImageView.image = [UIImage imageNamed:TISCommonSrcName(@"checkbox_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"checkbox_selected")];
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
        _textLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    }
    return _textLabel;
}

- (NSTimer *)textTimer {
    if (!_textTimer) {
        _textTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(doTimerMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_textTimer forMode:NSRunLoopCommonModes];
    }
    return _textTimer;
}



@end
