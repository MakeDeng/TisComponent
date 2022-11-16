//
//  TISLoading.h
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// ⭐️⭐️⭐️颜色要先于类型和尺寸设置

typedef NS_ENUM(NSInteger, LOADING_TYPE) {
    LOADING_NORMAL,             // loading样式(默认菊花)
    LOADING_NORMAL_HORRIZONTAL, // 菊花和文字横向排列
    LOADING_NORMAL_VERTICALL,   // 菊花和文字纵向排列
    LOADING_POINT,              // 三个点loading
    LOADING_PROGRESS,           // 进度条loading
};

typedef NS_ENUM(NSInteger, LOADING_SIZE) {
    LOADING_SIZE_NORMAL,    // 开关尺寸(默认大尺寸)
    LOADING_SIZE_SMALL,     // 小尺寸开关
};

@interface TISLoading : UIView

/// 菊花loading
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

/// 进度条loading
@property (nonatomic, strong) UIProgressView *progress;

/// 三个点loading
@property (nonatomic, strong) UIView *pointLoading;

/// 加载中label
@property (nonatomic, strong) UILabel *loadingLabel;

/// loading类型
@property (nonatomic, assign) LOADING_TYPE loadingType;

/// loading尺寸
@property (nonatomic, assign) LOADING_SIZE loadingSize;

/// 开始动画（三个点loading）
- (void)startLoading;

/// 结束动画（三个点loading）
- (void)endLoading;

@end

NS_ASSUME_NONNULL_END
