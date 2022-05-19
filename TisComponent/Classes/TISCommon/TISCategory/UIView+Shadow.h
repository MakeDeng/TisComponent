//
//  UIView+Shadow.h
//  TisComponent
//
//  Created by tanikawa on 2022/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// ⭐️⭐️⭐️注意：如果要设置阴影，则clipsToBounds和layer.masksToBounds必须为NO

@interface UIView (Shadow)

/**
 *  设置Sh-1-down阴影
 */
- (void)setSh1downShadow;

/**
 *  设置Sh-2-down阴影
 */
- (void)setSh2downShadow;

/**
 *  设置Sh-3-down阴影
 */
- (void)setSh3downShadow;

/**
 *  设置Sh-1-up阴影
 */
- (void)setSh1upShadow;

/**
 *  设置Sh-2-up阴影
 */
- (void)setSh2upShadow;

/**
 *  设置Sh-3-up阴影
 */
- (void)setSh3upShadow;

/**
 *  添加边框
 *  @param borderColor   边框颜色
 *  @param fillColor     填充颜色
 *  @param lineWidth     边框宽度
 *  @param borderSpace   虚线宽度和间隔宽度数组，默认@[@4, @2]，虚线宽4，间隔宽2
 *  @param cornerRadius  边框圆角
 *  @param isDash        是否是虚线
 */
- (void)addBorderLine:(UIColor *)borderColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth borderSpace:(nullable NSArray *)borderSpace cornerRadius:(CGFloat)cornerRadius isDash:(BOOL)isDash;

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
- (void)addLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth borderSpace:(nullable NSArray *)borderSpace startX:(CGFloat)startX startY:(CGFloat)startY endX:(CGFloat)endX endY:(CGFloat)endY isDash:(BOOL)isDash;

@end

NS_ASSUME_NONNULL_END
