//
//  TISMBHUD.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISMBHUD.h"

@implementation TISMBHUD

/**
 *  显示请求加载框
 */
+ (MBProgressHUD *)showLoadHud
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *loadHud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    loadHud.margin=10;
    loadHud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    loadHud.label.textColor = [UIColor whiteColor];
    loadHud.contentColor = [UIColor whiteColor];
    loadHud.label.text = @"";
    return loadHud;
}

/**
 *  显示文字提示框(默认1s)
 *
 *  @param string 提示文字
 */
+ (void)showTostHud:(NSString *)string
{
    UIWindow * window=[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *tostHud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    tostHud.contentColor=[UIColor clearColor];
    tostHud.margin=10;
    tostHud.label.textColor=[UIColor whiteColor];
    tostHud.bezelView.backgroundColor=[[UIColor clearColor] colorWithAlphaComponent:0.6];
    tostHud.mode=MBProgressHUDModeText;
    tostHud.label.textColor=[UIColor whiteColor];
    tostHud.label.numberOfLines=0;
    tostHud.label.text = [NSString stringWithFormat:@"%@",string];
    [tostHud hideAnimated:YES afterDelay:1];
}

/**
 *  显示文字提示框(带消失时间)
 
 *  @param string 提示文字
 *  @param delay 多长时间消失
 *  @param offset 位置偏移
 */
+ (void)showTostHudString:(NSString *)string afterDelay:(NSTimeInterval)delay offset:(CGPoint)offset
{
    UIWindow * window=[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *tostHud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    tostHud.contentColor=[UIColor clearColor];
    tostHud.margin=10;
    tostHud.offset = offset;
    tostHud.label.textColor=[UIColor whiteColor];
    tostHud.bezelView.backgroundColor=[[UIColor clearColor] colorWithAlphaComponent:0.6];
    tostHud.mode=MBProgressHUDModeText;
    tostHud.label.textColor=[UIColor whiteColor];
    tostHud.label.numberOfLines=0;
    tostHud.label.text = [NSString stringWithFormat:@"%@",string];
    [tostHud hideAnimated:YES afterDelay:delay];
}

@end
