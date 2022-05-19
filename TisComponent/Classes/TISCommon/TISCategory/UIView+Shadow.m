//
//  UIView+Shadow.m
//  TisComponent
//
//  Created by tanikawa on 2022/5/17.
//

#import "UIView+Shadow.h"

// ⭐️⭐️⭐️注意：如果要设置阴影，则clipsToBounds和layer.masksToBounds必须为NO

@implementation UIView (Shadow)

/**
 *  设置Sh-1-down阴影
 */
- (void)setSh1downShadow {
    [self checkColor];
    self.layer.shadowColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2);
    self.layer.shadowOpacity = 0.05;
    self.layer.shadowRadius = 8;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

/**
 *  设置Sh-2-down阴影
 */
- (void)setSh2downShadow {
    [self checkColor];
    self.layer.shadowColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,5);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 12;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

/**
 *  设置Sh-3-down阴影
 */
- (void)setSh3downShadow {
    [self checkColor];
    self.layer.shadowColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,8);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 16;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

/**
 *  设置Sh-1-up阴影
 */
- (void)setSh1upShadow {
    [self checkColor];
    self.layer.shadowColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,-2);
    self.layer.shadowOpacity = 0.05;
    self.layer.shadowRadius = 8;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

/**
 *  设置Sh-2-up阴影
 */
- (void)setSh2upShadow {
    [self checkColor];
    self.layer.shadowColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,-5);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 12;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

/**
 *  设置Sh-3-up阴影
 */
- (void)setSh3upShadow {
    [self checkColor];
    self.layer.shadowColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,-8);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 16;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

// 检查是否有背景色，如果没有背景色默认设置背景色为白色
- (void)checkColor {
    if (self.layer.backgroundColor == nil) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
}

/**
 *  添加边框
 *  @param borderColor   边框颜色
 *  @param fillColor     填充颜色
 *  @param lineWidth     边框宽度
 *  @param borderSpace   虚线宽度和间隔宽度数组，默认@[@4, @2]，虚线宽4，间隔宽2
 *  @param cornerRadius  边框圆角
 *  @param isDash        是否是虚线
 */
- (void)addBorderLine:(UIColor *)borderColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth borderSpace:(nullable NSArray *)borderSpace cornerRadius:(CGFloat)cornerRadius isDash:(BOOL)isDash {
    
    CGRect rect = self.bounds;
    
    // 添加边框
    CAShapeLayer *border = [CAShapeLayer layer];

    // 边框颜色
    border.strokeColor = borderColor.CGColor;

    // 填充的颜色
    border.fillColor = fillColor.CGColor;

    border.path = [UIBezierPath bezierPathWithRect:rect].CGPath;

    border.frame = rect;

    // 虚线的宽度
    border.lineWidth = lineWidth;
    
    if (isDash) {
        if (borderSpace==nil || borderSpace.count==0) {
            // 设置虚线的间隔(虚线宽度，间隔宽度)默认值
            border.lineDashPattern = @[@4, @2];
        } else {
            // 设置虚线的间隔(虚线宽度，间隔宽度)
            border.lineDashPattern = borderSpace;
        }
    }
    
    // 设置圆角路径
    border.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius].CGPath;

    [self.layer addSublayer:border];
}

/**
 *  绘制分割线
 *  @param lineColor     填充颜色
 *  @param lineWidth     边框宽度
 *  @param borderSpace   虚线宽度和间隔宽度数组，默认@[@4, @2]，虚线宽4，间隔宽2
 *  @param startX        起始点x坐标位置
 *  @param startY        起始点y坐标位置
 *  @param endX          结束点x坐标位置
 *  @param endY          结束点y坐标位置
 *  @param isDash        是否是虚线
 */
- (void)addLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth borderSpace:(nullable NSArray *)borderSpace startX:(CGFloat)startX startY:(CGFloat)startY endX:(CGFloat)endX endY:(CGFloat)endY isDash:(BOOL)isDash {
 
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 
    [shapeLayer setBounds:CGRectMake(0, 0, 0, 0)];
 
    [shapeLayer setPosition:CGPointMake(startX, startY)];
 
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    // 设置线的颜色
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //线的宽度
    shapeLayer.lineWidth = lineWidth;
    
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 设置虚线线宽，线间距
    if (isDash) {
        if (borderSpace==nil || borderSpace.count==0) {
            // 设置虚线的间隔(虚线宽度，间隔宽度)默认值
            shapeLayer.lineDashPattern = @[@4, @2];
        } else {
            // 设置虚线的间隔(虚线宽度，间隔宽度)
            shapeLayer.lineDashPattern = borderSpace;
        }
    }
    
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startX, startY);
 
    CGPathAddLineToPoint(path, NULL, endX, endY);
 
    [shapeLayer setPath:path];
    
    CGPathRelease(path);
    
    // 把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}


@end
