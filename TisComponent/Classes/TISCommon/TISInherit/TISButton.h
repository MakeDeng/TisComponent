//
//  TISButton.h
//  TisComponent
//
//  Created by tanikawa on 2022/5/17.
//

#import <UIKit/UIKit.h>
#import "TISButtonActivity.h"

NS_ASSUME_NONNULL_BEGIN

// ⭐️⭐️⭐️注意：必须先设置button的frame再设置颜色

@interface TISButton : UIButton

/**
 *  正常显示颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 *  按下显示颜色
 */
@property (nonatomic, strong) UIColor *pressColor;

/**
 *  不可用显示颜色
 */
@property (nonatomic, strong) UIColor *disableColor;

/**
 *  圆角（默认为0）
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 *  按钮菊花
 */
@property (nonatomic, strong) TISButtonActivity *activityIndicator;

/**
 *  刷新loading显示
 *  @params activity  是否正在loading
 */
- (void)refreshImage:(BOOL)activity;

@end

NS_ASSUME_NONNULL_END
