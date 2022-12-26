//
//  TISActionSheetTableViewCell.m
//  TisComponent
//
//  Created by tanikawa on 2022/12/26.
//

#import "TISActionSheetTableViewCell.h"

@implementation TISActionSheetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.loading.loadingSize = LOADING_SIZE_SMALL;
}

- (void)setCellType:(ACTION_SHEET_CELL_TYPE)cellType {
    _cellType = cellType;
    switch (cellType) {
        case ACTION_SHEET_CELL_DESC:
        {
            self.iconImageView.hidden = YES;
            self.contentLabelLeft.constant = -16;
            self.contentLabel.hidden = NO;
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            self.descLabel.textAlignment = NSTextAlignmentCenter;
            self.descLabel.hidden = NO;
            self.descLabelTop.constant = 8;
            self.loading.hidden = YES;
        }
            break;
        case ACTION_SHEET_CELL_ALERT:
        {
            self.iconImageView.hidden = YES;
            self.contentLabelLeft.constant = -16;
            self.contentLabel.hidden = NO;
            self.contentLabel.textColor = COLOR_RED_5;
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            self.descLabel.hidden = YES;
            self.descLabelTop.constant = -20;
            self.loading.hidden = YES;
        }
            break;
        case ACTION_SHEET_CELL_DISABLE:
        {
            self.iconImageView.hidden = YES;
            self.contentLabelLeft.constant = -16;
            self.contentLabel.hidden = NO;
            self.contentLabel.textColor = [COLOR_M2 colorWithAlphaComponent:0.5];
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            self.descLabel.hidden = YES;
            self.descLabelTop.constant = -20;
            self.loading.hidden = YES;
        }
            break;
        case ACTION_SHEET_CELL_LOADING:
        {
            self.iconImageView.hidden = YES;
            self.contentLabel.hidden = YES;
            self.descLabel.hidden = YES;
            self.descLabelTop.constant = -20;
            self.loading.hidden = NO;
        }
            break;
        case ACTION_SHEET_CELL_ICON:
        {
            self.iconImageView.hidden = NO;
            self.contentLabelLeft.constant = 16;
            self.contentLabel.hidden = NO;
            self.contentLabel.textColor = COLOR_M2;
            self.contentLabel.textAlignment = NSTextAlignmentLeft;
            self.descLabel.hidden = YES;
            self.descLabelTop.constant = -20;
            self.loading.hidden = YES;
        }
            break;
        default:
        {
            self.iconImageView.hidden = YES;
            self.contentLabelLeft.constant = -16;
            self.contentLabel.hidden = NO;
            self.contentLabel.textColor = COLOR_M2;
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            self.descLabel.hidden = YES;
            self.descLabelTop.constant = -20;
            self.loading.hidden = YES;
        }
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
