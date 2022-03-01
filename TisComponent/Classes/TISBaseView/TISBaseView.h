//
//  TISBaseView.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISBaseView : UIView

@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, strong) UIView *maskView; // 蒙层视图
@property (nonatomic, assign) NSTimeInterval animationDuration; // 显示或关闭时的动画时间

/**
 *  显示视图
 */
- (void)tisShow;

/**
 *  关闭视图
 */
- (void)tisClose;

/**
 *  动画效果
 */
- (void)tisShowAnimation;

/**
 *  关闭视图
 *
 *  动画效果
 */
- (void)tisCloseAnimation;

@end

NS_ASSUME_NONNULL_END
