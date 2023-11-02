//
//  TISModal.m
//  TisComponent
//
//  Created by tanikawa on 2023/1/17.
//

#import "TISModal.h"
#import "TISHeader.h"

@implementation TISModal

/// 显示对话框
- (void)showModal {
    self.hidden = NO;
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        self.isShow = YES;
    }];
}

/// 隐藏对话框
- (void)hiddenModal {
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.isShow = NO;
    }];
}

#pragma mark - 初始化

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.bgButton];
        [self addSubview:self.contentView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.bgButton];
        [self addSubview:self.contentView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.bgButton];
        [self addSubview:self.contentView];
    }
    return self;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_bgButton addTarget:self action:@selector(hiddenModal) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bgButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.center = CGPointMake(self.center.x, self.center.y);
        _contentView.bounds = CGRectMake(0, 0, 200, 300);
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8.0;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 24, self.frame.size.width - 24 * 2, 24)];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
    }
    return _contentLabel;
}

- (UIView *)doView {
    if (!_doView) {
        _doView = [UIView new];
    }
    return _doView;
}

@end
