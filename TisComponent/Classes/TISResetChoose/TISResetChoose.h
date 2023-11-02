//
//  TISResetChoose.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TISButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface TISResetChoose : UIView

@property (nonatomic, strong) TISButton *resetButton; // 重置按钮
@property (nonatomic, strong) TISButton *sureButton; // 确定按钮
@property (nonatomic, assign) NSInteger chooseNumber;// 选择的个数
@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, copy) void (^resetClicked)(void); // 搜索事件
@property (nonatomic, copy) void (^sureClicked)(void); // 搜索事件

@end

NS_ASSUME_NONNULL_END
