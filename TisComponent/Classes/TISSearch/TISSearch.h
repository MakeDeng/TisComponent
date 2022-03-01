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
@property (nonatomic, copy) void (^goSearch)(NSString *string); // 搜索事件

@end

NS_ASSUME_NONNULL_END
