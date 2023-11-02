//
//  TISChooseListTableViewCell.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TIS_COOSELIST_TYPE) {
    SINGLE,                     // 单选
    MORE,                       // 多选
    MORE_SELECT,                // 多选-选中
    SINGLE_HIGHTLIGHT,          // 单选搜索关键词高亮
    MORE_HIGHTLIGHT_UNSELECT,   // 多选搜索关键词高亮-未选中
    MORE_HIGHTLIGHT_SELECT,     // 多选搜索关键词高亮-已选中
};

@interface TISChooseListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelHeight;
@property (nonatomic, copy) NSString *keyword; // 搜索关键词（赋值关键词要先于选择类型）
@property (nonatomic, assign) TIS_COOSELIST_TYPE chooseType; // 选择类型

/**
 *  设置显示内容
 *  @param text   全部文字
 *  @param list 高亮搜索词
 *  @param color  高亮颜色
 */
- (void)setCellText:(NSString *)text searchText:(NSArray *)list color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
