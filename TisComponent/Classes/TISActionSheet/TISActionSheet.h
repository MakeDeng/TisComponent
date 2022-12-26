//
//  TISActionSheet.h
//  Pods
//
//  Created by tanikawa on 2022/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISActionSheet : UIView <UITableViewDelegate, UITableViewDataSource>

/// 背景按钮
@property (nonatomic, strong) UIButton *bgButton;

/// 数据字典
/// @{@"desc": @"", @"list": @""}
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

/// 动作面板tableview
@property (nonatomic, strong) UITableView *actionSheetTableView;

@property (nonatomic, copy) void (^TISActionSheetBlock)(NSDictionary *dic);

/// 显示面板
- (void)show;

/// 隐藏面板
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
