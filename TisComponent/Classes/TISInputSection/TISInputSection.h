//
//  TISInputSection.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/3/2.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISInputSection : UIView <UITextFieldDelegate>

@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, strong) UITextField *minTextFiled; // 最小输入区间
@property (nonatomic, strong) UITextField *maxTextFiled; // 最大输入区间
/**
 *  可输入小数点后几位（默认两位）
 */
@property (nonatomic, assign) int pointNumber;

@end

NS_ASSUME_NONNULL_END
