//
//  TISMBHUD.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface TISMBHUD : NSObject

/**
 显示请求加载框
 */
+ (MBProgressHUD *)showLoadHud;

/**
 显示文字提示框(默认1s)

 @param string 提示文字
 */
+ (void)showTostHud:(NSString *)string;

/**
 显示文字提示框(带消失时间)

 @param string 提示文字
 @param delay 多长时间消失
 @param offset 位置偏移
 */
+ (void)showTostHudString:(NSString *)string afterDelay:(NSTimeInterval)delay offset:(CGPoint)offset;

@end

NS_ASSUME_NONNULL_END
