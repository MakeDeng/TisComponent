//
//  TISChooseAreaTableViewCell.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISChooseAreaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLeft;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *leftLineView;
/**
 *  cell显示状态  1：省级cell有数字未选中  2：省级cell无数字未选中  3:省级cell有数字选中  4:省级cell无数字选中  5：市级cell未选中  6：市级cell选中  7：区级cell未选中  8：区级cell选中
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isMore; // 是否是多选（默认为单选）

@end

NS_ASSUME_NONNULL_END
