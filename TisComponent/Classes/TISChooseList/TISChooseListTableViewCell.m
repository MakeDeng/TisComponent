//
//  TISChooseListTableViewCell.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISChooseListTableViewCell.h"

@implementation TISChooseListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    if (_isMore) {
        // 多选
        self.selectImageView.hidden = NO;
        self.nameLeft.constant = 12;
    } else {
        // 单选
        self.selectImageView.hidden = YES;
        self.nameLeft.constant = -20;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
