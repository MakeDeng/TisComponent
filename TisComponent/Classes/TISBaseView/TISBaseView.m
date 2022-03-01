//
//  TISBaseView.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISBaseView.h"

@implementation TISBaseView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.viewFrame = frame;
        // 设置视图
        [self configView];
    }
    return self;
}

/**
 *  设置视图
 */
- (void)configView {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    [self addSubview:self.maskView];
    if (self.animationDuration == 0.0) {
        self.animationDuration = 0.3; // 默认0.3秒动画时长
    }
}



#pragma mark - 懒加载
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame: self.viewFrame];
        _maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    }
    return _maskView;
}



#pragma mark - 方法

/**
 *  显示视图
 */
- (void)tisShow {
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

/**
 *  关闭视图
 */
- (void)tisClose {
    self.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
}

/**
 *  动画效果
 */
- (void)tisShowAnimation {
    CGFloat width = self.viewFrame.size.width;
    CGFloat height = self.viewFrame.size.height;
    
    self.frame = CGRectMake(0, -height, width, height);
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, 0, width, height);
    }];
}

/**
 *  关闭视图
 *
 *  derection
 */
- (void)tisCloseAnimation {
    CGFloat width = self.viewFrame.size.width;
    CGFloat height = self.viewFrame.size.height;
    
    self.frame = CGRectMake(0, 0, width, height);
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.frame = CGRectMake(0, -height, width, height);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, 0, 0, 0);
    }];
}

@end
