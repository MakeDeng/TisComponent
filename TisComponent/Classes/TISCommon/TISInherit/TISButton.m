//
//  TISButton.m
//  TisComponent
//
//  Created by tanikawa on 2022/5/17.
//

#import "TISButton.h"

// ⭐️⭐️⭐️注意：必须先设置button的frame再设置颜色

@implementation TISButton

/**
 *  设置正常显示颜色
 */
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self setBackgroundImage:[self getImageFromColor:normalColor] forState:UIControlStateNormal];
}

/**
 *  设置按下显示颜色
 */
- (void)setPressColor:(UIColor *)pressColor {
    _pressColor = pressColor;
    [self setBackgroundImage:[self getImageFromColor:pressColor] forState:UIControlStateHighlighted];
}

/**
 *  设置不可用显示颜色
 */
- (void)setDisableColor:(UIColor *)disableColor {
    _disableColor = disableColor;
    self.backgroundColor = [UIColor clearColor];
    self.tintColor = [UIColor clearColor];
    [self setBackgroundImage:[self getImageFromColor:disableColor] forState:UIControlStateDisabled];
}

/**
 *  颜色转换为背景图片
 */
- (UIImage *)getImageFromColor:(UIColor *)color {
    if (self.cornerRadius > 0) {
        CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
        UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
        CGContextAddPath(UIGraphicsGetCurrentContext(), bezierPath.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    } else {
        CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}



#pragma mark - 设置按钮loading相关

/**
 *  刷新loading显示
 *  @params activity  是否正在loading
 */
- (void)refreshImage:(BOOL)activity {
    if (activity) {
        CGFloat activityWidth = 30;
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, activityWidth, 0, 0)];
        self.activityIndicator.bounds = CGRectMake(0, 0, activityWidth, activityWidth);
        self.activityIndicator.center = CGPointMake((self.frame.size.width - self.titleLabel.frame.size.width)/2, self.titleLabel.center.y);
    } else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

/**
 *  按钮菊花初始化
 */
- (TISButtonActivity *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[TISButtonActivity alloc] init];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

@end
