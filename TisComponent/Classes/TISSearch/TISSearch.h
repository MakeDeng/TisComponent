//
//  TISSearch.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISSearch : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textFiled; // 搜索框
@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, assign) BOOL watchFocus; // 是否需要聚焦和失焦回调事件(默认不需要，如果需要必须实现聚焦和失焦的block回调事件)
@property (nonatomic, copy) void (^becomeFirst)(void); // 输入框聚焦事件
@property (nonatomic, copy) void (^registerInput)(void); // 输入框失焦事件
@property (nonatomic, copy) void (^goSearch)(NSString *string); // 搜索事件

@end

NS_ASSUME_NONNULL_END
