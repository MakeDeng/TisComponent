//
//  TISSwitch.h
//  TisComponent
//
//  Created by tanikawa on 2022/10/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SWITCH_TYPE) {
    SWITCH_NORMAL,    // 单开关(默认)
    SWITCH_TITLE,     // 带标题开关
    SWITCH_DESC,      // 带标题和描述开关
};

@interface TISSwitch : UIView

/// 开关
@property (nonatomic, strong) UISwitch *tisSwitch;

/// 标题label
@property (nonatomic, strong) UILabel *titleLabel;

/// 描述label
@property (nonatomic, strong) UILabel *descLabel;

/// 是否是loading状态
@property (nonatomic, assign) BOOL isLoading;

/// 是否禁用
@property (nonatomic, assign) BOOL isDisable;

/// 开关类型
@property (nonatomic, assign) SWITCH_TYPE swithType;

@end

NS_ASSUME_NONNULL_END
