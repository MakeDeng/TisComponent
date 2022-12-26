//
//  TisHeader.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#ifndef TisHeader_h
#define TisHeader_h

#pragma mark - 尺寸

// 手机屏幕宽度
#define TIS_Screen_Width [UIScreen mainScreen].bounds.size.width

// 手机屏幕高度

#define TIS_Screen_Height [UIScreen mainScreen].bounds.size.height
// 是否是iPhone（不是则是ipad）
#define TIS_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 是否是iphonex以上的刘海屏机型
#define TIS_IPHONE_X (TIS_Screen_Width>=375.0f && TIS_Screen_Height>=812.0f && TIS_IS_IPHONE)

// 状态栏高度
#define TIS_STATUS_BAR_HEIGHT (CGFloat)(TIS_IPHONE_X?(44.0):(20.0))

// 状态栏和导航栏总高度
#define TIS_NAV_HEIGHT (CGFloat)(TIS_IPHONE_X?(88.0):(64.0))

// TabBar高度
#define TIS_TABBAR_HEIGHT (CGFloat)(TIS_IPHONE_X?(49.0 + 34.0):(49.0))

// 顶部安全区域远离高度
#define TIS_TOP_SAFE_HEIGHT (CGFloat)(TIS_IPHONE_X?(44.0):(0))

// 底部安全区域远离高度
#define TIS_BOTTOM_SAFE_HEIGHT (CGFloat)(TIS_IPHONE_X?(34.0):(0))

// iPhoneX的状态栏高度差值(只是刘海那一小部分)
#define kTopBarDifHeight (CGFloat)(TIS_IPHONE_X?(24.0):(0))



#pragma mark - 弱引用
#define TIS_WEAKSELF __weak typeof(self) weakSelf = self;



#pragma mark - 图片

// 改变代码图片路径
#define TISCommonSrcName(file) [@"TisComponent.bundle" stringByAppendingPathComponent:file]
#define TISCommonFrameworkSrcName(file) [@"Frameworks/TisComponent.framework/TisComponent.bundle" stringByAppendingPathComponent:file]



#pragma mark - 颜色

// RGBA颜色
#define TIS_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

// HEX颜色
#define TIS_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// HEX颜色（带透明度）
#define TIS_HEX_ALPHA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]



#pragma mark - 文件头文件

#import "TISTool.h"
#import "TISColor.h"
#import "TISSize.h"
#import "UIView+Shadow.h"
#import "TISButton.h"
#import "TISChooseListView.h"
#import "TISChooseArea.h"
#import "TISChooseItem.h"
#import "TISInputSection.h"
#import "TISPhone.h"
#import "TISTextArea.h"
#import "TISRadio.h"
#import "TISInput.h"
#import "TISSwitch.h"
#import "TISLoading.h"
#import "TISToast.h"
#import "TISNoticeBar.h"
#import "TISBadge.h"
#import "TISActionSheet.h"

#endif /* TisHeader_h */
