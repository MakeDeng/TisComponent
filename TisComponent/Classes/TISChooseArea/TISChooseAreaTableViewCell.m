//
//  TISChooseAreaTableViewCell.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/25.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISChooseAreaTableViewCell.h"
#import "TISHeader.h"

@implementation TISChooseAreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numberLabel.layer.cornerRadius = 12;
    self.numberLabel.layer.masksToBounds = YES;
}

/**
 *  cell显示状态  1：省级cell有数字未选中  2：省级cell无数字未选中  3:省级cell有数字选中  4:省级cell无数字选中  5：市级cell未选中  6：市级cell选中  7：区级cell未选中  8：区级cell选中
 *
 *  @param type 类型
 */
- (void)setType:(NSInteger)type {
    _type = type;
    switch (_type) {
        case 1:
        {
            self.selectImageView.hidden = YES;
            self.numberLabel.hidden = NO;
            self.leftLineView.hidden = YES;
            self.nameLeft.constant = -20;
            self.nameLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
            if (self.isMore == NO) {
                self.numberLabel.hidden = YES;
            }
        }
            break;
        case 2:
        {
            self.selectImageView.hidden = YES;
            self.numberLabel.hidden = YES;
            self.leftLineView.hidden = YES;
            self.nameLeft.constant = -20;
            self.nameLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case 3:
        {
            self.selectImageView.hidden = YES;
            self.numberLabel.hidden = NO;
            self.leftLineView.hidden = NO;
            self.nameLeft.constant = -20;
            self.nameLabel.textColor = [TISTool tisColorWithHex:@"#1f6cdd"];
            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
            if (self.isMore == NO) {
                self.numberLabel.hidden = YES;
            }
        }
            break;
        case 4:
        {
            self.selectImageView.hidden = YES;
            self.numberLabel.hidden = YES;
            self.leftLineView.hidden = NO;
            self.nameLeft.constant = -20;
            self.nameLabel.textColor = [TISTool tisColorWithHex:@"#1f6cdd"];
            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case 5:
        {
            self.selectImageView.hidden = YES;
            self.numberLabel.hidden = YES;
            self.leftLineView.hidden = YES;
            self.nameLeft.constant = -20;
            self.nameLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor whiteColor];
        }
            break;
        case 6:
        {
            self.selectImageView.hidden = YES;
            self.numberLabel.hidden = YES;
            self.leftLineView.hidden = YES;
            self.nameLeft.constant = -20;
            self.nameLabel.textColor = [TISTool tisColorWithHex:@"#1f6cdd"];
            self.backgroundColor = [UIColor whiteColor];
        }
            break;
        case 7:
        {
            self.selectImageView.hidden = NO;
            self.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_un_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_un_selected")];
            
            self.numberLabel.hidden = YES;
            self.leftLineView.hidden = YES;
            self.nameLeft.constant = 12;
            self.nameLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor whiteColor];
            if (self.isMore == NO) {
                self.nameLeft.constant = -20;
                self.selectImageView.hidden = YES;
            }
        }
            break;
        case 8:
        {
            self.selectImageView.hidden = NO;
            self.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_selected")];
            self.numberLabel.hidden = YES;
            self.leftLineView.hidden = YES;
            self.nameLeft.constant = 12;
            self.nameLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor whiteColor];
            if (self.isMore == NO) {
                self.nameLeft.constant = -20;
                self.selectImageView.hidden = YES;
            }
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
