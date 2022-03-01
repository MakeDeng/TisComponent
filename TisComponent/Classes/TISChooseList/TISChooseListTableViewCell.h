//
//  TISChooseListTableViewCell.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISChooseListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLeft;

@property (nonatomic, assign) BOOL isMore; // 是否是多选

@end

NS_ASSUME_NONNULL_END
