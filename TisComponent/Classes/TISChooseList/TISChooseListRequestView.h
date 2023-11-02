//
//  TISChooseListRequestView.h
//  TisComponent
//
//  Created by tanikawa on 2023/10/31.
//

#import <UIKit/UIKit.h>
#import "TISLoading.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TIS_COOSELIST_REQUEST_TYPE) {
    NORMAL,    // 正常状态
    EMPTY,     // 空视图
    LOADING,   // loading视图
};

@interface TISChooseListRequestView : UIView

@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, strong) UIView *emptyView; // 空视图
@property (nonatomic, strong) TISLoading *loadingView; // loading视图
@property (nonatomic, assign) TIS_COOSELIST_REQUEST_TYPE viewType; // 视图类型

/// 更新子组件frame
- (void)resizeSubview;

@end

NS_ASSUME_NONNULL_END
