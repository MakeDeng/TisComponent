//
//  TISEmptyState.m
//  TisComponent
//
//  Created by tanikawa on 2023/1/11.
//

#import "TISEmptyState.h"

@implementation TISEmptyState

#pragma mark - 初始化

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.emptyStateView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.emptyStateView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self addSubview:self.emptyStateView];
    }
    return self;
}

- (UIView *)emptyStateView {
    if (!_emptyStateView) {
        _emptyStateView = [UIView new];
    }
    return _emptyStateView;
}

@end
