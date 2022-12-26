//
//  TISBadge.h
//  Pods
//
//  Created by tanikawa on 2022/12/23.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BADGE_TYPE) {
    BADGE_POINT,    // 默认徽标（小红点）
    BADGE_NUMBER,   // 数字徽标
    BADGE_DIY,      // 自定义徽标
};

NS_ASSUME_NONNULL_BEGIN

@interface TISBadge : UIView

/// 显示通知栏
/// @param type 徽标类型
/// @param text 自定义徽标文字
+ (instancetype)badge:(BADGE_TYPE)type text:(nullable NSString *)text;

/// 徽标文字label
@property (nonatomic, strong) UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
