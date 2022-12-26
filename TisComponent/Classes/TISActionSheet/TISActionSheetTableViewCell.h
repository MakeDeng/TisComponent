//
//  TISActionSheetTableViewCell.h
//  TisComponent
//
//  Created by tanikawa on 2022/12/26.
//

#import <UIKit/UIKit.h>
#import "TISHeader.h"

typedef NS_ENUM(NSInteger, ACTION_SHEET_CELL_TYPE) {
    ACTION_SHEET_CELL_NORMAL,       // 默认样式
    ACTION_SHEET_CELL_DESC,         // 带描述类型
    ACTION_SHEET_CELL_ALERT,        // 警示选项
    ACTION_SHEET_CELL_DISABLE,      // 禁用选项
    ACTION_SHEET_CELL_LOADING,      // loading选项
    ACTION_SHEET_CELL_ICON,         // 带icon选项
};

NS_ASSUME_NONNULL_BEGIN

@interface TISActionSheetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeft;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelTop;
@property (weak, nonatomic) IBOutlet TISLoading *loading;
@property (assign, nonatomic) ACTION_SHEET_CELL_TYPE cellType;
@end

NS_ASSUME_NONNULL_END
